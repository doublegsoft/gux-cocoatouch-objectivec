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
#import "Styles.h"
#import "GUX/Common/GUX.h"

@implementation Styles

static NSInteger _padding = 16;

+ (NSInteger)padding {
  return _padding;
}

+ (UIFont*)titleFont {
  return [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
}

+ (UIFont*)subtitleFont {
  return [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
}

+ (UIColor*)primaryColor {
  return [GUX colorWithHexString:@"#73b17b"];
}

+ (UIColor*)textPrimaryColor {
  return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
}

+ (UIColor*)textSecondaryColor {
  return [UIColor grayColor];
}

+ (UIColor*)dividerColor {
  return [GUX colorWithHexString:@"#efefef"];
}

+ (UIColor*)backgroundColor {
  return [GUX colorWithHexString:@"#f2f2f2"];
}

+ (UIColor*)surfaceColor {
  return [GUX colorWithHexString:@"#B2D7FF"];
}

+ (UIView*)buildCardWithFrame:(CGRect)frame andTitle:(NSString*)title {
  UIView* ret = [[UIView alloc] init];
  ret.frame = frame;
  ret.layer.cornerRadius = 15.0;
  ret.layer.masksToBounds = NO;
  
  if (title != nil && title.length > 0) {
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(Styles.padding, Styles.padding, ret.bounds.size.width / 2 - Styles.padding, 16);
    label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    label.text = title;
    [ret addSubview:label];
  }
  
  return ret;
}

@end
