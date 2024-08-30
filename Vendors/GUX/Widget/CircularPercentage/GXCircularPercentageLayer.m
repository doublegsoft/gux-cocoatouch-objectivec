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
#import "GXCircularPercentageLayer.h"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface GXCircularPercetnageLayer ()

@end

@implementation GXCircularPercetnageLayer

static const float kStartAngle = 0.0;
static const float kStopAngle = 360.0;

- (instancetype)initWithLayer:(id)layer {
  self = [super initWithLayer:layer];
  if (self) {
    if ([layer isKindOfClass:[GXCircularPercetnageLayer class]]) {
      GXCircularPercetnageLayer* previous = (GXCircularPercetnageLayer*)layer;
      self.startAngle = previous.startAngle;
      self.stopAngle = previous.stopAngle;
      self.radius = previous.radius;
      self.thickness = previous.thickness;
      self.bgColor = previous.bgColor;
      self.valColor = previous.valColor;
    }
    [self setup];
  }
  return self;
}

- (id<CAAction>)actionForKey:(NSString *)event {
  if ([event isEqualToString:@"stopAngle"]) {
    return [self createGaugeAnimationWithKey:event];
  }
  return [super actionForKey:event];
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
  if ([key isEqualToString:@"stopAngle"]) {
    return YES;
  }
  return [super needsDisplayForKey:key];
}

- (void)setup {
  self.contentsScale = [UIScreen mainScreen].scale;
}

- (CABasicAnimation *)createGaugeAnimationWithKey:(NSString *)key {
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
  animation.fromValue = [[self presentationLayer] valueForKey:key];
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  animation.duration = self.animationDuration;
  return animation;
}

- (CGMutablePathRef)drawGaugeWithStartPoint:(CGPoint)startPoint {
  CGMutablePathRef path = CGPathCreateMutable();
  
  CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
  
  CGPathAddLineToPoint(path, NULL, self.center.x + self.radius * cosf(self.startAngle), self.center.y + self.radius * sinf(self.startAngle));
  CGPathAddArc(path, NULL, self.center.x, self.center.y, self.radius, self.startAngle, self.stopAngle, false);
  
  CGPathAddLineToPoint(path, NULL, self.center.x + (self.radius - self.thickness) * cosf(self.stopAngle), self.center.y + (self.radius - self.thickness) * sinf(self.stopAngle));
  CGPathAddArc(path, NULL, self.center.x, self.center.y, self.radius - self.thickness, self.stopAngle, self.startAngle, true);
  
  return path;
}

- (void)drawInContext:(CGContextRef)ctx {
  CGPoint startPoint = CGPointMake(self.center.x + (self.radius - self.thickness) * cosf(self.startAngle), self.center.y + (self.radius - self.thickness) * sinf(self.startAngle));
  
  CGContextSetShouldAntialias(ctx, true);
  
  CGContextAddArc(ctx, self.frame.size.width / 2, self.frame.size.height / 2, self.radius - (self.thickness / 2), 0, 2.0 * M_PI, false);
  CGContextSetLineWidth(ctx, self.thickness);
  CGContextSetLineCap(ctx, kCGLineCapRound);
  CGContextSetStrokeColorWithColor(ctx, self.bgColor.CGColor);
  CGContextDrawPath(ctx, kCGPathStroke);
  
  CGContextAddPath(ctx, [self drawGaugeWithStartPoint:startPoint]);
  
  CGContextSetFillColorWithColor(ctx, self.valColor.CGColor);
  
  CGContextDrawPath(ctx, kCGPathEOFill);
}

- (CGPoint)center {
  return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (CGFloat)convertDegreesToRadius:(CGFloat)degrees {
  return (M_PI * degrees) / 180.0;
}

@end
