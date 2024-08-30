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
#pragma once

#import <Foundation/Foundation.h>

@interface XHR : NSObject

+ (void)requestFromURL:(NSString*)url
            withMethod:(NSString*)method
         andParameters:(NSDictionary*)parameters
         andCompletion:(void (^)(NSDictionary* response))completionHandler;

+ (void)getFromURL:(NSString*)url;

+ (void)postToURL:(NSString*)url 
    withParameters:(NSDictionary*)paramseters
    andCompletion:(void (^)(NSDictionary* response))completionHandler;

+ (void)putToURL:(NSString*)url 
   withParameters:(NSDictionary*)paramseters
   andCompletion:(void (^)(NSDictionary* response))completionHandler;

+ (void)patchToURL:(NSString*)url 
     withParameters:(NSDictionary*)paramseters
     andCompletion:(void (^)(NSDictionary* response))completionHandler;

+ (void)deleteFromURL:(NSString*)url withParameters:(NSDictionary*)parameters;

@end
