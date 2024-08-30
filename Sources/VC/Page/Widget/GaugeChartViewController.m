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
#import "GaugeChartViewController.h"

#import "GUX/Widget/CircularPercentage/GXCircularPercentage.h"

#import "GUX/Common/GUX.h"
#import "Styles.h"

@interface GaugeChartViewController ()

@property (nonatomic, strong) GXCircularPercentage* gaugePercentage;


@end

@implementation GaugeChartViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = Styles.backgroundColor;
  self.title = @"表盘图表";

  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  int y = 0;
  int contentHeight = 0;
  int contentWidth = GUX.screenWidth - Styles.padding * 2;
  int cardHeight = 200;
  
  UIScrollView* scroll = [[UIScrollView alloc] init];
  scroll.frame = CGRectMake(0,
                            GUX.topPadding + navigationBarHeight,
                            GUX.screenWidth,
                            GUX.screenHeight - GUX.topPadding + navigationBarHeight - GUX.bottomPadding);
  [self.view addSubview:scroll];
  
  CGRect chartInCardBounds = CGRectMake(Styles.padding, Styles.padding * 2.5,
                                        contentWidth - Styles.padding * 2,
                                        cardHeight - Styles.padding * 3.5 - 16);
  
  UIView* card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, cardHeight)
                                   andTitle:@"进度表盘"];
  card.backgroundColor = UIColor.whiteColor;
  
  self.gaugePercentage = [[GXCircularPercentage alloc] initWithFrame:chartInCardBounds];
  self.gaugePercentage.thickness = 10;
  
  self.gaugePercentage.labelFont = [UIFont systemFontOfSize:40 weight: UIFontWeightThin];
  self.gaugePercentage.labelColor = Styles.primaryColor;
  self.gaugePercentage.bgColor = UIColor.lightGrayColor;
  self.gaugePercentage.valColor = Styles.primaryColor;
  self.gaugePercentage.labelText = @"80%";

  [card addSubview:self.gaugePercentage];
  [scroll addSubview:card];
  
  
  y += cardHeight + Styles.padding;
  contentWidth += cardHeight + Styles.padding;
  
  scroll.contentSize = CGSizeMake(GUX.screenWidth, contentHeight);
  
  self.gaugePercentage.percentage = 80;
}

@end
