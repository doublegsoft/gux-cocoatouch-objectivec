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
#import <UIKit/UIKit.h>

#import "GXCircularPercentage.h"
#import "GXCircularPercentageLayer.h"

@interface GXCircularPercentage ()

@property (nonatomic, strong) UILabel* label;

@property (nonatomic) float _percentage;

@end

@implementation GXCircularPercentage

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  GXCircularPercetnageLayer* layer = (GXCircularPercetnageLayer*)self.layer.sublayers[0];
  
  layer.radius = [self radius];
  layer.thickness = self.thickness;
  layer.frame = self.bounds;
  layer.bgColor = self.bgColor;
  layer.valColor = self.valColor;
  layer.animationDuration = self.animationDuration;
  layer.startAngle = [self convertDegreesToRadius:self.startAngle];
  layer.stopAngle = [self convertPercentageInRadius:self.percentage];
  
  [self updateTextLabel];
}

- (float)percentage {
  return self._percentage;
}

- (void)setPercentage:(float)percentage {
  self._percentage = percentage;
  
  GXCircularPercetnageLayer* layer = self.layer.sublayers[0];
  layer.stopAngle = [self convertPercentageInRadius:percentage];
  self.accessibilityValue = [NSString stringWithFormat:@"%.0f%%", percentage];
  [self setNeedsDisplay];
  [layer setNeedsDisplay];
}

- (void)setup {
  [self createGaugeView];
  [self createTitleLabel];
  [self setupAccessibility];
}

- (void)setupAccessibility {
  self.isAccessibilityElement = YES;
}

- (void)createGaugeView {
  GXCircularPercetnageLayer* gaugeLayer = [[GXCircularPercetnageLayer alloc] initWithLayer:self.layer];
  
  gaugeLayer.radius = self.radius;
  gaugeLayer.thickness = self.thickness;
  gaugeLayer.frame = self.bounds;
  gaugeLayer.bgColor = self.bgColor;
  gaugeLayer.valColor = self.valColor;
  gaugeLayer.animationDuration = self.animationDuration;
  gaugeLayer.startAngle = [self convertDegreesToRadius:self.startAngle];
  gaugeLayer.stopAngle = [self convertPercentageInRadius:self.percentage];
  
  [self.layer addSublayer:gaugeLayer];
  
  self.backgroundColor = [UIColor clearColor];
}

- (void)createTitleLabel {
  self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
  [self updateTextLabel];
  [self addSubview:self.label];
}

- (void)updateTextLabel {
  self.label.font = self.labelFont;
  self.label.textColor = self.labelColor;
  self.label.text = self.labelText;
  [self.label sizeToFit];
  self.label.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (float)convertPercentageInRadius:(float)percentage {
  return [self convertDegreesToRadius:((360.0 / 100.0 * percentage) + self.startAngle)];
}

- (float)convertDegreesToRadius:(float)degrees {
  return ((M_PI * degrees) / 180.0);
}

- (CGFloat)radius {
  return MIN(self.bounds.size.width, self.bounds.size.height) / 2;
}

@end
