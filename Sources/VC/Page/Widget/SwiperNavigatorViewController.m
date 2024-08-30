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
#import "GUX/Common/GUX.h"
#import "SwiperNavigatorViewController.h"
#import "Styles.h"
#import "SDK.h"

@interface SwiperNavigatorViewController ()

@property (nonatomic, strong) iCarousel* swiperNavigator4Ad;

@property (nonatomic, strong) NSTimer* timer4Ad;

@property (nonatomic, strong) NSMutableArray* images4Ad;

@end

@implementation SwiperNavigatorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.images4Ad = [[NSMutableArray alloc] init];
  
  self.title = @"滚动导航";
  self.view.backgroundColor = Styles.backgroundColor;
  
  self.swiperNavigator4Ad = [[iCarousel alloc] init];
  self.swiperNavigator4Ad.frame = CGRectMake(0, 0, GUX.screenWidth, 200);
  self.swiperNavigator4Ad.delegate = self;
  self.swiperNavigator4Ad.dataSource = self;
  self.swiperNavigator4Ad.type = iCarouselTypeCoverFlow2;
  [self.view addSubview:self.swiperNavigator4Ad];
  
  [SDK fetchApplicationAdvertisementsWithParameters:@{} andCompletion:^(NSArray *data) {
    [self.images4Ad addObjectsFromArray:data];
    
    self.timer4Ad = [NSTimer scheduledTimerWithTimeInterval:3.5
                                                     target:self
                                                   selector:@selector(doPlayAd)
                                                   userInfo:nil
                                                    repeats:YES];
    
    [self.swiperNavigator4Ad reloadData];
  }];
}

- (void)doTapListNavigateItem:(UITapGestureRecognizer *)sender {
  
}

- (void)doPlayAd {
  NSInteger nextIndex = (self.swiperNavigator4Ad.currentItemIndex + 1) % [self numberOfItemsInCarousel:self.swiperNavigator4Ad];
  [self.swiperNavigator4Ad scrollToItemAtIndex:nextIndex animated:YES];
}

#pragma mark - iCarousel

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
  return self.images4Ad.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
  
  //create new view if no view is available for recycling
  if (view == nil)
  {
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GUX.screenWidth, 200)];
    [GUX loadImageFromURL:self.images4Ad[index][@"imagePath"] intoImageView:(UIImageView*)view];
    view.contentMode = UIViewContentModeCenter;
  }
  
  return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
  //customize carousel display
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
      return value * 1.05;
    }
    case iCarouselOptionFadeMax:
    {
//      if (self.carousel.type == iCarouselTypeCustom)
//      {
//        return 0.0;
//      }
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

@end
