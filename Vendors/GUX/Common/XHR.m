/*
** ──────────────────────────────────────────────────
** ─██████████████─██████──██████─████████──████████─
** ─██░░░░░░░░░░██─██░░██──██░░██─██░░░░██──██░░░░██─
** ─██░░██████████─██░░██──██░░██─████░░██──██░░████─
** ─██░░██─────────██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██─────────██░░██──██░░██───████░░░░░░████───
** ─██░░██──██████─██░░██──██░░██─────██░░░░░░██─────
** ─██░░██──██░░██─██░░██──██░░██───████░░░░░░████───
** ─██░░██──██░░██─██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██████░░██─██░░██████░░██─████░░██──██░░████─
** ─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─
** ─██████████████─██████████████─████████──████████─
** ──────────────────────────────────────────────────
*/
#import "XHR.h"

@implementation XHR

+ (void)requestFromURL:(NSString *)url 
            withMethod:(NSString*)method
         andParameters:(NSDictionary*)parameters
         andCompletion:(void (^)(NSDictionary* response))completionHandler {
  NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
  request.HTTPMethod = method;
  
  if ([method isEqualToString:@"POST"]) {
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];

    if (error) {
      NSMutableDictionary* err = [[NSMutableDictionary alloc] init];
      err[@"code"] = @(403);
      err[@"message"] = @"客户端封装请求数据错误";
      completionHandler(err);
      return;
    }

    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)jsonData.length] forHTTPHeaderField:@"Content-Length"];
  }
  NSURLSession* session = [NSURLSession sharedSession];
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSMutableDictionary* err = [[NSMutableDictionary alloc] init];
      err[@"code"] = @(error.code);
      err[@"message"] = error.description;
      completionHandler(err);
    } else {
      NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
      if (httpResponse.statusCode == 200) {
        NSError* jsonError = nil;
        NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
          NSMutableDictionary* err = [[NSMutableDictionary alloc] init];
          err[@"code"] = @(jsonError.code);
          err[@"message"] = jsonError.description;
          completionHandler(err);
        } else {
          completionHandler(jsonResponse);
        }
      } else {
        NSMutableDictionary* err = [[NSMutableDictionary alloc] init];
        err[@"code"] = @(httpResponse.statusCode);
        err[@"message"] = @"服务器发生错误";
        completionHandler(err);
      }
    }
  }];
  [dataTask resume];
}


+ (void)postToURL:(NSString *)url 
    withParameters:(NSDictionary *)paramseters
    andCompletion:(void (^__strong)(NSDictionary *__strong))completionHandler {
  [self requestFromURL:url withMethod:@"POST" andParameters:paramseters andCompletion:completionHandler];
}

+ (void)putToURL:(NSString*)url
   withParameters:(NSDictionary*)paramseters
   andCompletion:(void (^)(NSDictionary* response))completionHandler {
  [self requestFromURL:url withMethod:@"PUT" andParameters:paramseters andCompletion:completionHandler];
}

+ (void)patchToURL:(NSString*)url
     withParameters:(NSDictionary*)paramseters
     andCompletion:(void (^)(NSDictionary* response))completionHandler {
  [self requestFromURL:url withMethod:@"PATCH" andParameters:paramseters andCompletion:completionHandler];
}

@end
