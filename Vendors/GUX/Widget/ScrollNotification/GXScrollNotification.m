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
#import "GXScrollNotification.h"

#import "iCarousel.h"
#import "Styles.h"
#import "GUX/Common/GUX.h"

@interface GXScrollNotification () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) iCarousel* carousel;

@property (nonatomic, strong) NSTimer* timer;

@end

@implementation GXScrollNotification

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(Styles.padding, 2, 20, 20)];
  icon.image = [UIImage imageNamed:@"Image.Icon.Broadcast"];
  [self addSubview:icon];
  
  if (self.carousel == nil) {
    self.carousel = [[iCarousel alloc] init];
    self.carousel.frame = CGRectMake(Styles.padding * 3 / 2 + 20, 0, GUX.screenWidth - Styles.padding * 2 - 24, 24);
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.vertical = YES;
    self.carousel.type = iCarouselTypeLinear;
    [self addSubview:self.carousel];
  }
  
  return self;
}

- (void)dealloc {
  [self.timer invalidate];
  self.timer = nil;
}

- (void)autoplay:(NSInteger)interval {
  [self.carousel reloadData];
  if (self.timer == nil) {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                  target:self
                                                selector:@selector(doAutoplay)
                                                userInfo:nil
                                                 repeats:YES];
  }
}

- (void)doAutoplay {
  if (self.carousel.numberOfItems == 0) {
    return;
  }
  NSInteger nextIndex = (self.carousel.currentItemIndex + 1) % [self numberOfItemsInCarousel:self.carousel];
  [self.carousel scrollToItemAtIndex:nextIndex animated:YES];
}

- (void)doTapCarouselItem:(UITapGestureRecognizer*)gesture {
  UILabel* label = (UILabel *)gesture.view;
  NSInteger index = [self.carousel indexOfItemView:label];
  if (self.delegate) {
    [self.delegate scrollNotification:self didTapItemAtIndex:index];
  }
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
  return [self.dataSource numberOfNotifications:self];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
  if (view == nil)
  {
    NSDictionary* notif = [self.dataSource scrollNotification:self dataForItemAtIndex:index];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(Styles.padding + 24, 4, GUX.screenWidth - Styles.padding * 2 - 24, 24)];
    label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    label.textColor = Styles.textSecondaryColor;
    label.text = notif[@"content"];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapCarouselItem:)];
    [label addGestureRecognizer:tapGesture];
    view = label;
  }
  view.hidden = carousel.currentItemIndex != index;
  return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
  switch (option)
  {
    case iCarouselOptionWrap:
    {
      //normally you would hard-code this to YES or NO
      return YES;
    }
    case iCarouselOptionSpacing:
    {
      //add a bit of spacing between the item views
      return value * 1.0;
    }
    case iCarouselOptionFadeMax:
    {
      return value;
    }
    case iCarouselOptionShowBackfaces:
    case iCarouselOptionRadius:
    case iCarouselOptionAngle:
    case iCarouselOptionArc:
    case iCarouselOptionTilt:
    case iCarouselOptionCount:
    case iCarouselOptionFadeMin:
    case iCarouselOptionFadeMinAlpha:
    case iCarouselOptionFadeRange:
    case iCarouselOptionOffsetMultiplier:
    case iCarouselOptionVisibleItems:
    {
      return value;
    }
  }
}

#pragma mark - iCarouselDelegate

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
  [carousel reloadData];
}

@end
