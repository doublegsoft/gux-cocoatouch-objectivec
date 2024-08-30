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
#import "BarChartViewController.h"

#import "DGCharts-Swift.h"

#import "GUX/Common/GUX.h"
#import "Styles.h"

@interface BarChartViewController ()

@property (nonatomic, strong) BarChartView* verticalBarChart;

@property (nonatomic, strong) BarChartView* horizontalBarChart;

@end

@implementation BarChartViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = Styles.backgroundColor;
  self.title = @"柱状图表";

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
  [self.view addSubview:scroll];
  
  CGRect chartInCardBounds = CGRectMake(Styles.padding, Styles.padding * 2.5,
                                        contentWidth - Styles.padding * 2,
                                        cardHeight - Styles.padding * 3.5 - 16);
  
  UIView* card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, cardHeight)
                                   andTitle:@"垂直风格"];
  card.backgroundColor = UIColor.whiteColor;
  
  self.verticalBarChart = [[BarChartView alloc] initWithFrame:chartInCardBounds];
  self.verticalBarChart.xAxis.drawGridLinesEnabled = NO;
  [card addSubview:self.verticalBarChart];
  [self reloadBarChartData:self.verticalBarChart];

  
  [scroll addSubview:card];
  
  y += cardHeight + Styles.padding;
  contentHeight += cardHeight + Styles.padding;
  
  card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, cardHeight)
                           andTitle:@"水平风格"];
  card.backgroundColor = UIColor.whiteColor;
  self.horizontalBarChart = [[HorizontalBarChartView alloc] initWithFrame:chartInCardBounds];
  self.horizontalBarChart.xAxis.drawGridLinesEnabled = NO;
  [card addSubview:self.horizontalBarChart];
  [self reloadBarChartData:self.horizontalBarChart];
  
  y += cardHeight + Styles.padding;
  contentHeight += cardHeight + Styles.padding;
  
  [scroll addSubview:card];
  scroll.contentSize = CGSizeMake(GUX.screenWidth, contentHeight);
}

- (void)reloadBarChartData:(BarChartView*)barChart {
  NSArray *xAxisLabels = @[@"医疗", @"教育", @"交通", @"餐饮", @"文化"];
  NSMutableArray *dataEntries = [[NSMutableArray alloc] init];
  
  [dataEntries addObject:[[BarChartDataEntry alloc] initWithX:0 y:20.0]];
  [dataEntries addObject:[[BarChartDataEntry alloc] initWithX:1 y:40.0]];
  [dataEntries addObject:[[BarChartDataEntry alloc] initWithX:2 y:30.0]];
  [dataEntries addObject:[[BarChartDataEntry alloc] initWithX:3 y:60.0]];
  [dataEntries addObject:[[BarChartDataEntry alloc] initWithX:4 y:50.0]];
  
  BarChartDataSet* dataSet = [[BarChartDataSet alloc] initWithEntries:dataEntries label:@"营业利润"];
  BarChartData* data = [[BarChartData alloc] initWithDataSets:@[dataSet]];
  
  dataSet.colors = ChartColorTemplates.material;
  barChart.xAxis.labelPosition = XAxisLabelPositionBottom;
  barChart.xAxis.labelCount = 5;
  barChart.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xAxisLabels];
  barChart.data = data;
  [barChart animateWithYAxisDuration:1.5];
}

@end
