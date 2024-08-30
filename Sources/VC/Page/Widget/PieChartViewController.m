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
#import "PieChartViewController.h"

#import "DGCharts-Swift.h"

#import "GUX/Common/GUX.h"
#import "Styles.h"

@interface PieChartViewController ()

@property (nonatomic, strong) PieChartView* pieChart1;

@property (nonatomic, strong) PieChartView* pieChart2;

@end

@implementation PieChartViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = Styles.backgroundColor;
  self.title = @"饼状图表";

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
                                   andTitle:@"空心大饼"];
  card.backgroundColor = UIColor.whiteColor;
  [scroll addSubview:card];
  
  self.pieChart1 = [[PieChartView alloc] initWithFrame:chartInCardBounds];
  [card addSubview:self.pieChart1];
  [self realoadData4Chart:self.pieChart1];
  
  y += cardHeight + Styles.padding;
  contentHeight += cardHeight + Styles.padding;
  
  card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, cardHeight)
                           andTitle:@"实心大饼"];
  card.backgroundColor = UIColor.whiteColor;
  [scroll addSubview:card];
  
  self.pieChart2 = [[PieChartView alloc] initWithFrame:chartInCardBounds];
  self.pieChart2.drawHoleEnabled = NO;
  [card addSubview:self.pieChart2];
  [self realoadData4Chart:self.pieChart2];
  
  y += cardHeight + Styles.padding;
  contentHeight += cardHeight + Styles.padding;
  
  scroll.contentSize = CGSizeMake(GUX.screenWidth, contentHeight);
}

- (void)realoadData4Chart:(PieChartView*)pieChart {
  NSMutableArray* dataEntries = [[NSMutableArray alloc] init];
  
  [dataEntries addObject:[[PieChartDataEntry alloc] initWithValue:20.0 label:@"教育"]];
  [dataEntries addObject:[[PieChartDataEntry alloc] initWithValue:30.0 label:@"医疗"]];
  [dataEntries addObject:[[PieChartDataEntry alloc] initWithValue:10.0 label:@"住房"]];
  [dataEntries addObject:[[PieChartDataEntry alloc] initWithValue:40.0 label:@"投资"]];
  
  PieChartDataSet* dataSet = [[PieChartDataSet alloc] initWithEntries:dataEntries label:@"资产占比"];
  PieChartData* data = [[PieChartData alloc] initWithDataSets:@[dataSet]];
  
  // Customize the pie chart
  dataSet.colors = ChartColorTemplates.material;
  pieChart.data = data;
  
  // Additional configurations
  pieChart.chartDescription.text = @"";
  [pieChart animateWithXAxisDuration:1.5 yAxisDuration:1.5];
}

@end
