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
#import "CalendarViewController.h"

#import "FSCalendar.h"
#import "DGCharts-Swift.h"

#import "GUX/Common/GUX.h"
#import "Styles.h"

@interface CalendarViewController () <ChartViewDelegate, FSCalendarDelegate>

@property (nonatomic, strong) LineChartView* lineChart;

@property (nonatomic, strong) FSCalendar* calendar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"日历导航";
  
  int y = GUX.topPadding + navigationBarHeight;
  self.calendar = [[FSCalendar alloc] init];
  self.calendar.scope = FSCalendarScopeWeek;
  self.calendar.delegate = self;
  self.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
  self.calendar.frame = CGRectMake(Styles.padding, y, [GUX screenWidth] - Styles.padding * 2, 300);
  [self.view addSubview:self.calendar];
  
  y += 300 + Styles.padding - 200;
  
  self.lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(Styles.padding, y,
                                                                   self.view.frame.size.width - Styles.padding * 2, 300)];
  self.lineChart.delegate = self;
  [self.view addSubview:self.lineChart];
  
  self.lineChart.chartDescription.enabled = NO;
  self.lineChart.dragEnabled = NO;
  [self.lineChart setScaleEnabled:NO];
  self.lineChart.pinchZoomEnabled = NO;
  self.lineChart.drawGridBackgroundEnabled = NO;
  self.lineChart.leftAxis.enabled = false;
  self.lineChart.rightAxis.enabled = false;
  self.lineChart.xAxis.enabled = false;
  self.lineChart.legend.enabled = false;
  [self reloadLineChartData];
}

- (void)reloadLineChartData {
  NSMutableArray *values = [[NSMutableArray alloc] init];
      
  for (int i = 0; i < 20; i++) {
    double val = arc4random_uniform(100) + 3;
    [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
  }
  
  LineChartDataSet* set1 = [[LineChartDataSet alloc] initWithEntries:values label:@"营业额"];
  set1.circleColor = Styles.primaryColor;
  set1.colors = @[Styles.primaryColor];
  set1.circleHoleColor = Styles.primaryColor;
  set1.circleRadius = 6.0;
  set1.drawIconsEnabled = NO;
  
  NSMutableArray* dataSets = [[NSMutableArray alloc] init];
  [dataSets addObject:set1];
  
  LineChartData* data = [[LineChartData alloc] initWithDataSets:dataSets];
  [self.lineChart setData:data];
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSString *selectedDate = [formatter stringFromDate:date];
  [self reloadLineChartData];
}


@end
