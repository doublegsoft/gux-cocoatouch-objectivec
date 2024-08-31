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
#import "SDK.h"
#import "GUX/Common/XHR.h"
#import "GUX/Common/GUX.h"

@implementation SDK

static NSString* HOST = @"http://192.168.0.207:9098";

+ (void)fetchWelcomeImagesWithParameters:(NSDictionary*)parameters andCompletion:(void (^)(NSArray* data))completionHandler {
  NSMutableArray* data = [[NSMutableArray alloc] init];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/welcome/1.png", HOST]}];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/welcome/2.png", HOST]}];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/welcome/3.png", HOST]}];
  completionHandler(data);
}

+ (void)fetchApplicationAdvertisementsWithParameters:(NSDictionary *)parameters andCompletion:(void (^)(NSArray*))completionHandler {
  NSMutableArray* data = [[NSMutableArray alloc] init];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/500x300/1.jpg", HOST]}];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/500x300/2.jpg", HOST]}];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/500x300/3.jpg", HOST]}];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/500x300/4.jpg", HOST]}];
  [data addObject:@{@"imagePath":[NSString stringWithFormat:@"%@/img/500x300/5.jpg", HOST]}];
  completionHandler(data);
}

+ (void)fetchApplicationNotificationsWithParameters:(NSDictionary *)parameters andCompletion:(void (^)(NSArray*))completionHandler {
  NSMutableArray* data = [[NSMutableArray alloc] init];
  [data addObject:@{@"content":@"GUX CocoaTouch ObjectiveC框架已经启动了！"}];
  [data addObject:@{@"content":@"目前GUX支持H5、WeChat、Flutter、CocoaTouch了。"}];
  [data addObject:@{@"content":@"预祝GUX项目取得成功！！"}];
  completionHandler(data);
}

@end
