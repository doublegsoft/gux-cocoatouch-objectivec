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
#import "LineChartViewController.h"

#import "DGCharts-Swift.h"

#import "GUX/Common/GUX.h"
#import "Styles.h"

@interface LineChartViewController ()

@property (nonatomic, strong) LineChartView* lineChart1;

@property (nonatomic, strong) LineChartView* lineChart2;

@property (nonatomic, strong) LineChartView* lineChart3;

@end

@implementation LineChartViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = Styles.backgroundColor;
  self.title = @"折线图表";

  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  int y = 0;
  int contentHeight = 0;
  int contentWidth = GUX.screenWidth - Styles.padding * 2;
  int cardHeight = 300;
  
  UIScrollView* scroll = [[UIScrollView alloc] init];
  scroll.frame = CGRectMake(0,
                            GUX.topPadding + navigationBarHeight,
                            GUX.screenWidth,
                            GUX.screenHeight - GUX.topPadding + navigationBarHeight - GUX.bottomPadding);
  scroll.bounces = NO;
  scroll.showsVerticalScrollIndicator = NO;
  scroll.showsHorizontalScrollIndicator = NO;
  [self.view addSubview:scroll];
  
  CGRect chartInCardBounds = CGRectMake(Styles.padding, Styles.padding * 2.5,
                                        contentWidth - Styles.padding * 2,
                                        cardHeight - Styles.padding * 3.5 - 16);
  
  UIView* card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, cardHeight)
                                   andTitle:@"一个指标"];
  card.backgroundColor = UIColor.whiteColor;
  
  self.lineChart1 = [[LineChartView alloc] initWithFrame:chartInCardBounds];
  [card addSubview:self.lineChart1];
  
  self.lineChart1.chartDescription.enabled = NO;
  self.lineChart1.dragEnabled = NO;
  [self.lineChart1 setScaleEnabled:NO];
  self.lineChart1.pinchZoomEnabled = NO;
  self.lineChart1.drawGridBackgroundEnabled = NO;
  self.lineChart1.leftAxis.enabled = false;
  self.lineChart1.rightAxis.enabled = false;
  self.lineChart1.xAxis.enabled = false;
  self.lineChart1.legend.enabled = false;
  [self reloadLineChartData:self.lineChart1 andSeries:@[@"营业额"]];
  
  [scroll addSubview:card];
  
  y += cardHeight + Styles.padding;
  contentHeight += cardHeight + Styles.padding;
  
  card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, cardHeight)
                           andTitle:@"两个指标"];
  card.backgroundColor = UIColor.whiteColor;
  
  self.lineChart2 = [[LineChartView alloc] initWithFrame:chartInCardBounds];
  [self reloadLineChartData:self.lineChart2 andSeries:@[@"营业额", @"毛利"]];
  [card addSubview:self.lineChart2];
  
  y += cardHeight + Styles.padding;
  contentHeight += cardHeight + Styles.padding;
  
  [scroll addSubview:card];
  
  card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, cardHeight)
                           andTitle:@"三个指标"];
  card.backgroundColor = UIColor.whiteColor;
  
  self.lineChart3 = [[LineChartView alloc] initWithFrame:chartInCardBounds];
  [self reloadLineChartData:self.lineChart3 andSeries:@[@"A类商品", @"B类商品", @"C类商品"]];
  [card addSubview:self.lineChart3];
  
  y += cardHeight + Styles.padding;
  contentHeight += cardHeight + Styles.padding;
  
  [scroll addSubview:card];
  
  scroll.contentSize = CGSizeMake(GUX.screenWidth, contentHeight);
}

- (void)reloadLineChartData:(LineChartView*)lineChart andSeries:(NSArray*)labels {
  NSMutableArray* dataSets = [[NSMutableArray alloc] init];
  for (int i = 0; i < labels.count; i++) {
    NSMutableArray* values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 12; i++) {
      double val = arc4random_uniform(100) + 3;
      [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet* set1 = [[LineChartDataSet alloc] initWithEntries:values label:labels[i]];
    set1.circleColor = ChartColorTemplates.material[i];
    set1.colors = @[ChartColorTemplates.material[i]];
    set1.circleHoleColor = ChartColorTemplates.material[i];
    set1.circleRadius = 6.0;
    set1.drawIconsEnabled = NO;
    
    [dataSets addObject:set1];
  }
  
  LineChartData* data = [[LineChartData alloc] initWithDataSets:dataSets];
  lineChart.data = data;
}
@end
