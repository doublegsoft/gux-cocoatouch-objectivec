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
#import "GXSwiperNavigator.h"

#import "GUX/Common/GUX.h"
#import "Styles.h"
#import "iCarousel.h"

@interface GXSwiperNavigator () <iCarouselDelegate, iCarouselDataSource>

@property (nonatomic, strong) iCarousel* carousel;

@property (nonatomic, strong) NSTimer* timer;

@property (nonatomic, strong) UIPageControl* pageControl;

@end

@implementation GXSwiperNavigator

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if (self.carousel == nil) {
    self.carousel = [[iCarousel alloc] init];
    self.carousel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.scrollSpeed = 0;
    self.carousel.decelerationRate = 0.2;
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
//  if (self.timer == nil) {
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
//                                                  target:self
//                                                selector:@selector(doAutoplay)
//                                                userInfo:nil
//                                                 repeats:YES];
//  }
}

- (void)doAutoplay {
  if (self.carousel.numberOfItems == 0) {
    return;
  }
  NSInteger nextIndex = (self.carousel.currentItemIndex + 1) % [self numberOfItemsInCarousel:self.carousel];
  [self.carousel scrollToItemAtIndex:nextIndex animated:YES];
}

- (void)doTapCarouselItem:(UITapGestureRecognizer*)gesture {
  NSInteger index = [self.carousel indexOfItemView:gesture.view];
  if (self.delegate) {
    [self.delegate swiperNavigator:self didTapItemAtIndex:index];
  }
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
  return [self.dataSource numberOfNavigators:self];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
  if (view == nil)
  {
    NSDictionary* nav = [self.dataSource swiperNavigator:self dataForItemAtIndex:index];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
    [GUX loadImageFromURL:nav[@"imagePath"] intoImageView:imageView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapCarouselItem:)];
    [imageView addGestureRecognizer:tapGesture];
    view = imageView;
  }
  // view.hidden = carousel.currentItemIndex != index;
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
