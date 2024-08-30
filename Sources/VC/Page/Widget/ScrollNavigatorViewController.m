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
#import "ScrollNavigatorViewController.h"
#import "Styles.h"

@interface ScrollNavigatorViewController ()

@end

@implementation ScrollNavigatorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"滑动导航";
  self.view.backgroundColor = Styles.backgroundColor;
  
  int y = GUX.topPadding + self.navigationController.navigationBar.frame.size.height;
  CGRect frame = CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, 120);
  UIView* card = [self makeWidgetWithFrame:frame andTitle:@"图标示例"];
  card.backgroundColor = Styles.surfaceColor;
  
  UIScrollView* navs = [[UIScrollView alloc] initWithFrame:CGRectMake(Styles.padding,
                                                                      Styles.padding + 22,
                                                                      frame.size.width - Styles.padding * 2,
                                                                      64)];
  navs.bounces = NO;
  navs.showsVerticalScrollIndicator = NO;
  navs.showsHorizontalScrollIndicator = NO;
  
  long itemWidth = 56;
  long xInScroll = Styles.padding;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Swiper_Navigator"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Grid_Navigator"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.List_Navigator"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Tabs"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Calendar"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Scroll_Navigator"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Scroll_Notification"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.List_View"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Grid_View"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Editable_Form"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Readonly_Form"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Pie_Chart"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Bar_Chart"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Line_Chart"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Gauge_Chart"]];
  xInScroll += itemWidth;
  [navs addSubview:[self makeNavigationItemAtX:xInScroll andImage:@"Image.Widget.Bottom_Sheet"]];
  xInScroll += itemWidth;
  
  navs.contentSize = CGSizeMake(xInScroll, 64);
  [card addSubview:navs];
  [self.view addSubview:card];
  
  y += 120 + Styles.padding;
  frame = CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, 160);
  card = [self makeWidgetWithFrame:frame andTitle:@"日期示例"];
  card.backgroundColor = Styles.surfaceColor;
  
  [self.view addSubview:card];
}

- (UIView*)makeNavigationItemAtX:(long)x andImage:(NSString*)imageName {
  UIView* ret = [[UIView alloc] init];
  int height = 64;
  int iconWidth = 48;
  ret.frame = CGRectMake(x, Styles.padding / 2, GUX.screenWidth - Styles.padding * 2, height);
  
  UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
  imageView.frame = CGRectMake(0, (height - iconWidth) / 2, iconWidth, iconWidth);
  [ret addSubview:imageView];
  
  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapListNavigateItem:)];
  [ret addGestureRecognizer:tapGesture];
  
  return ret;
}

- (void)doTapListNavigateItem:(UITapGestureRecognizer *)sender {
  
}

- (UIView*)makeWidgetWithFrame:(CGRect)frame
                      andTitle:(NSString*)title {
  int buttonWidth = 120;
  int buttonHeight = 36;
  UIView* ret = [[UIView alloc] init];
  
  UILabel* titleLabel = [[UILabel alloc] init];
  titleLabel.frame = CGRectMake(Styles.padding, Styles.padding, frame.size.width - Styles.padding * 2, 24);
  titleLabel.text = title;
  titleLabel.font = Styles.titleFont;
  titleLabel.textColor = Styles.textPrimaryColor;
  ret.frame = frame;

  [ret addSubview:titleLabel];
  
  // Set rounded corners
  ret.layer.cornerRadius = 10.0;
  ret.layer.masksToBounds = NO;
  
  // Set shadow
  ret.layer.shadowColor = [[UIColor blackColor] CGColor];
  ret.layer.shadowOffset = CGSizeMake(0.0, 2.0);
  ret.layer.shadowOpacity = 0.2;
  ret.layer.shadowRadius = 2.0;
  
  // Set border (optional)
  ret.layer.borderColor = [[UIColor lightGrayColor] CGColor];
  ret.layer.borderWidth = 0.5;
  
  return ret;
}

@end
