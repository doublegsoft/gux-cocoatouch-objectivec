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
#import "GUX.h"

@implementation GUX

static CGFloat _screenWidth = 0;

static CGFloat _screenHeight = 0;

static CGFloat _topPadding = -1;

static CGFloat _bottomPadding = -1;

+ (void)loadImageFromURL:(NSString*)url intoImageView:(UIImageView *)imageView {
  // Create a data task to download the image
  NSURLSessionDataTask* downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Error downloading image: %@", error);
      return;
    }
    
    if (data) {
      // Convert the downloaded data to a UIImage
      UIImage *downloadedImage = [UIImage imageWithData:data];
      
      // Update the image view on the main thread
      dispatch_async(dispatch_get_main_queue(), ^{
        imageView.image = downloadedImage;
      });
    }
  }];
  
  // Start the download task
  [downloadTask resume];
}

+ (CGFloat)screenWidth {
  if (_screenWidth == 0) {
    [GUX initDevice];
  }
  return _screenWidth;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
  NSString *cleanHexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
  
  unsigned int hexInt;
  [[NSScanner scannerWithString:cleanHexString] scanHexInt:&hexInt];
  
  // Extract the RGB components from the hex value
  CGFloat red = ((hexInt & 0xFF0000) >> 16) / 255.0;
  CGFloat green = ((hexInt & 0x00FF00) >> 8) / 255.0;
  CGFloat blue = (hexInt & 0x0000FF) / 255.0;
  CGFloat alpha = 1.0;
  
  // Create and return the UIColor object
  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)screenHeight {
  if (_screenHeight == 0) {
    [GUX initDevice];
  }
  return _screenHeight;
}

+ (CGFloat)topPadding {
  if (_topPadding == -1) {
    [GUX initDevice];
  }
  return _topPadding;
}

+ (CGFloat)bottomPadding {
  if (_bottomPadding == -1) {
    [GUX initDevice];
  }
  return _bottomPadding;
}

+ (void)initDevice {
  _screenWidth = [UIScreen mainScreen].bounds.size.width;
  _screenHeight = [UIScreen mainScreen].bounds.size.height;
  if (@available(iOS 11.0, *)) {
    UIWindow* window = UIApplication.sharedApplication.windows.firstObject;
    _topPadding = window.safeAreaInsets.top;
    _bottomPadding = window.safeAreaInsets.bottom;
  }
}

@end


