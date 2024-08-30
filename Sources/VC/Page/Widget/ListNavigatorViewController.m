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
#import "ListNavigatorViewController.h"
#import "Toast/UIView+Toast.h"
#import "GUX/Common/GUX.h"
#import "Styles.h"

@interface ListNavigatorViewController ()

@end

@implementation ListNavigatorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"列表导航";
  
  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  int avatarWidth = 128;
  
  UIView* background = [[UIView alloc] init];
  background.frame = CGRectMake(0, 0, GUX.screenWidth, GUX.topPadding + navigationBarHeight + avatarWidth / 3 * 2);
  background.backgroundColor = Styles.surfaceColor;
  [self.view addSubview:background];
  
  int y = GUX.topPadding + navigationBarHeight;
  UIImageView* avatar = [[UIImageView alloc] init];
  avatar.frame = CGRectMake((GUX.screenWidth - avatarWidth) / 2, y, avatarWidth, avatarWidth);
  avatar.image = [UIImage imageNamed:@"Image.Logo"];
  
  avatar.layer.cornerRadius = avatarWidth / 2;
  avatar.clipsToBounds = YES;
  [self.view addSubview:avatar];
  
  y += avatarWidth + Styles.padding;
  
  UIScrollView* navs = [[UIScrollView alloc] init];
  navs.frame = CGRectMake(0, y, GUX.screenWidth, GUX.screenHeight - y - Styles.padding);
  [self.view addSubview:navs];
  
  long itemHeight = 56;
  long yInScroll = 0;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Swiper_Navigator" andTitle:@"滚动导航"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Grid_Navigator" andTitle:@"栅格导航"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.List_Navigator" andTitle:@"列表导航"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Tabs" andTitle:@"页签导航"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Calendar" andTitle:@"日历导航"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Scroll_Navigator" andTitle:@"滑动导航"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Scroll_Notification" andTitle:@"滚动通知"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.List_View" andTitle:@"传统列表"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Grid_View" andTitle:@"栅格列表"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Editable_Form" andTitle:@"编辑表单"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Readonly_Form" andTitle:@"只读表单"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Pie_Chart" andTitle:@"饼状图表"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Bar_Chart" andTitle:@"柱状图表"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Line_Chart" andTitle:@"折线图表"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Gauge_Chart" andTitle:@"表盘图表"]];
  yInScroll += itemHeight;
  [navs addSubview:[self makeNavigationItemAtY:yInScroll andImage:@"Image.Widget.Bottom_Sheet" andTitle:@"底部弹窗"]];
  yInScroll += itemHeight;
  
  navs.contentSize = CGSizeMake(GUX.screenWidth, yInScroll);
}

- (UIView*)makeNavigationItemAtY:(long)y andImage:(NSString*)imageName andTitle:(NSString*)title {
  UIView* ret = [[UIView alloc] init];
  int height = 56;
  int iconWidth = 36;
  ret.frame = CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, height);
  
  UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
  imageView.frame = CGRectMake(0, (height - iconWidth) / 2, iconWidth, iconWidth);
  [ret addSubview:imageView];
  
  UILabel* label = [[UILabel alloc] init];
  label.frame = CGRectMake(iconWidth + Styles.padding, (height - 20) / 2, 120, 20);
  label.text = title;
  [ret addSubview:label];
  
  iconWidth = 20;
  UIImageView* iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image.Icon.Right_Arrow"]];
  iconView.frame = CGRectMake(ret.frame.size.width - iconWidth,
                              (height - iconWidth) / 2, iconWidth, iconWidth);
  [ret addSubview:iconView];
  
  UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, ret.frame.size.height - 1, ret.frame.size.width, 1)];
  bottomLine.backgroundColor = Styles.dividerColor;
  [ret addSubview:bottomLine];
  
  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapListNavigateItem:)];
  [ret addGestureRecognizer:tapGesture];
  
  return ret;
}

- (void)doTapListNavigateItem:(UITapGestureRecognizer *)sender {
  [self.navigationController.view makeToast:@"模拟跳转到指定页面"];
}

@end
