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
#import "GridNavigatorViewController.h"
#import "Styles.h"

@interface GridNavigatorViewController ()

@end

@implementation GridNavigatorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"栅格导航";
  self.view.backgroundColor = Styles.backgroundColor;
  
  UIScrollView* scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                        [GUX topPadding],
                                                                        [GUX screenWidth],
                                                                        [GUX screenHeight] - [GUX bottomPadding])];
  scroll.bounces = NO;
  scroll.showsVerticalScrollIndicator = NO;
  scroll.showsHorizontalScrollIndicator = NO;
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:scroll];
  
  int y = 0;
  UIView* frequentView = [self makeSection:CGRectMake(Styles.padding, y, [GUX screenWidth] - Styles.padding * 2, 214) andTitle:@"常用应用"];
  
  UIView* entryView = [self makeGridItem1WithIndex:0 andTitle:@"微信支付" andSubtitle:@"方便快捷支付体系"];
  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
  [entryView addGestureRecognizer:tapGesture];
  [frequentView addSubview:entryView];
  
  entryView = [self makeGridItem1WithIndex:1 andTitle:@"智能门禁" andSubtitle:@"刷脸开门打卡考勤"];
  [frequentView addSubview:entryView];
  
  entryView = [self makeGridItem1WithIndex:2 andTitle:@"停车收费" andSubtitle:@"自动抬杆自动扣费"];
  [frequentView addSubview:entryView];
  
  entryView = [self makeGridItem1WithIndex:3 andTitle:@"外卖点餐" andSubtitle:@"足不出户尽享美食"];
  [frequentView addSubview:entryView];
  
  [scroll addSubview:frequentView];
  
  y += 214 + Styles.padding;
  UIView* itemView = [self makeGridItem2WithIndex:0 atY:y andTitle:@"开发任务" andSubtitle:@"享受一键式开发的便捷服务"];
  [scroll addSubview:itemView];
  itemView = [self makeGridItem2WithIndex:1 atY:y andTitle:@"测试安排" andSubtitle:@"享受一键式的自动化测试服务"];
  [scroll addSubview:itemView];
  
  y += 80 + Styles.padding;
}

- (UIView*)makeSection:(CGRect)frame
              andTitle:(NSString*)title {
  UIView* ret = [[UIView alloc] init];
  ret.backgroundColor = Styles.surfaceColor;
  
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
  ret.layer.shadowColor = [[UIColor whiteColor] CGColor];
  ret.layer.shadowOffset = CGSizeMake(0.0, 2.0);
  ret.layer.shadowOpacity = 0.2;
  ret.layer.shadowRadius = 2.0;
  
  // Set border (optional)
  ret.layer.borderColor = Styles.dividerColor.CGColor;
  ret.layer.borderWidth = 0.5;
  
  return ret;
}

- (UIView*)makeGridItem1WithIndex:(NSInteger)index andTitle:(NSString*)title andSubtitle:(NSString*)subtitle {
  UIView* ret = [[UIView alloc] init];
  ret.backgroundColor = [UIColor whiteColor];
  
  int entryWidth = (GUX.screenWidth - Styles.padding * 5) / 2;
  int entryHeight = 64;
  int iconWidth = 48;
  long labelWidth = entryWidth - Styles.padding * 2 - iconWidth - 4;
  
  long row = index / 2;
  
  ret.frame = CGRectMake(Styles.padding + (index % 2) * (entryWidth + Styles.padding),
                         Styles.padding * 2 + 22 + (Styles.padding + entryHeight) * row,
                         entryWidth,
                         entryHeight);
  
  UIImageView* imageView = [[UIImageView alloc] init];
  imageView.frame = CGRectMake(Styles.padding / 2, Styles.padding / 2, iconWidth, iconWidth);
  imageView.image = [UIImage imageNamed:@"Image.Widget.Grid_Navigator"];
  [ret addSubview:imageView];
  
  UILabel* titleLabel = [[UILabel alloc] init];
  titleLabel.frame = CGRectMake(Styles.padding + iconWidth, Styles.padding / 2 + 4, labelWidth, 22);
  titleLabel.font = Styles.titleFont;
  titleLabel.text = title;
  [ret addSubview:titleLabel];
  
  UILabel* subtitleLabel = [[UILabel alloc] init];
  subtitleLabel.frame = CGRectMake(Styles.padding + iconWidth, Styles.padding / 2 + 24, labelWidth, 22);
  subtitleLabel.font = Styles.subtitleFont;
  subtitleLabel.textColor = Styles.textSecondaryColor;
  subtitleLabel.text = subtitle;
  [ret addSubview:subtitleLabel];
  
  ret.layer.cornerRadius = 10.0;
  ret.layer.masksToBounds = NO;
  
  ret.layer.borderColor = [[UIColor whiteColor] CGColor];
  ret.layer.borderWidth = 0.5;
  
  return ret;
}

- (UIView*)makeGridItem2WithIndex:(NSInteger)index atY:(int)y andTitle:(NSString*)title andSubtitle:(NSString*)subtitle {
  UIView* ret = [[UIView alloc] init];
  ret.backgroundColor = Styles.surfaceColor;
  
  int entryWidth = (GUX.screenWidth - Styles.padding * 3) / 2;
  int entryHeight = 80;
  int iconWidth = 48;
  
  long row = index / 2;
  
  ret.frame = CGRectMake(Styles.padding + (index % 2) * (entryWidth + Styles.padding),
                         y + (Styles.padding + entryHeight) * row,
                         entryWidth,
                         entryHeight);
  
  UIImageView* imageView = [[UIImageView alloc] init];
  imageView.frame = CGRectMake(Styles.padding / 2, Styles.padding, iconWidth, iconWidth);
  imageView.image = [UIImage imageNamed:@"Image.Widget.Grid_Navigator"];
  [ret addSubview:imageView];
  
  long labelWidth = entryWidth - Styles.padding * 2 - iconWidth - 4;
  UILabel* titleLabel = [[UILabel alloc] init];
  titleLabel.frame = CGRectMake(Styles.padding + iconWidth, Styles.padding + 4, labelWidth, 22);
  titleLabel.font = Styles.titleFont;
  titleLabel.text = title;
  [ret addSubview:titleLabel];
  
  UILabel* subtitleLabel = [[UILabel alloc] init];
  subtitleLabel.frame = CGRectMake(Styles.padding + iconWidth, Styles.padding + 24, labelWidth, 22);
  subtitleLabel.font = Styles.subtitleFont;
  subtitleLabel.textColor = Styles.textSecondaryColor;
  subtitleLabel.text = subtitle;
  [ret addSubview:subtitleLabel];
  
  ret.layer.cornerRadius = 10.0;
  ret.layer.masksToBounds = NO;
  
  ret.layer.borderColor = [[UIColor whiteColor] CGColor];
  ret.layer.borderWidth = 0.5;
  
  return ret;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
  NSLog(@"View was tapped!");
  // Add your custom logic here
}


@end
