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
#import "WidgetViewController.h"

#import "VC/Page/Widget/ListViewViewController.h"
#import "VC/Page/Widget/CalendarViewController.h"
#import "VC/Page/Widget/TabsViewController.h"
#import "VC/Page/Widget/GridNavigatorViewController.h"
#import "VC/Page/Widget/ListNavigatorViewController.h"
#import "VC/Page/Widget/ScrollNavigatorViewController.h"
#import "VC/Page/Widget/SwiperNavigatorViewController.h"
#import "VC/Page/Widget/EditableFormViewController.h"
#import "VC/Page/Widget/ReadonlyFormViewController.h"
#import "VC/Page/Widget/BarChartViewController.h"
#import "VC/Page/Widget/LineChartViewController.h"
#import "VC/Page/Widget/PieChartViewController.h"
#import "VC/Page/Widget/GaugeChartViewController.h"

#import "iCarousel.h"

#import "GUX/Widget/ScrollNotification/GXScrollNotificationDelegate.h"
#import "GUX/Widget/ScrollNotification/GXScrollNotificationDataSource.h"
#import "GUX/Widget/SwiperNavigator/GXSwiperNavigatorDelegate.h"
#import "GUX/Widget/SwiperNavigator/GXSwiperNavigatorDataSource.h"
#import "GUX/Widget/SwiperNavigator/GXSwiperNavigator.h"
#import "GUX/Widget/ScrollNotification/GXScrollNotification.h"

#import "GUX/Common/GUX.h"
#import "Styles.h"
#import "SDK.h"

@interface WidgetViewController () <UIScrollViewDelegate,
                                    GXScrollNotificationDelegate,
                                    GXScrollNotificationDataSource,
                                    GXSwiperNavigatorDelegate,
                                    GXSwiperNavigatorDataSource>

/*!
** swiper navigator
*/
@property (nonatomic, strong) GXSwiperNavigator* swiperNavigator4Ad;

@property (nonatomic, strong) GXScrollNotification* scrollNotification4App;

@property (nonatomic, strong) NSMutableArray* notifs4App;

@property (nonatomic, strong) NSMutableArray* ads4App;

@end

@implementation WidgetViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  // Show the navigation bar
  [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"组件介绍";
  
  self.notifs4App = [[NSMutableArray alloc] init];
  self.ads4App = [[NSMutableArray alloc] init];
  NSInteger contentHeight = 0;
  
  UIScrollView* scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                        -[GUX topPadding],
                                                                        [GUX screenWidth],
                                                                        [GUX screenHeight] - [GUX bottomPadding])];
  scroll.delegate = self;
  scroll.bounces = NO;
  scroll.showsVerticalScrollIndicator = NO;
  scroll.showsHorizontalScrollIndicator = NO;
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:scroll];
  
  CGFloat imageWidth = [GUX screenWidth];
  CGFloat imageHeight = 240;
  
  // 计算滚动高度
  contentHeight += imageHeight + Styles.padding;
  
  /*!
  ** swiper navigator
  */
  self.swiperNavigator4Ad = [[GXSwiperNavigator alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
  self.swiperNavigator4Ad.delegate = self;
  self.swiperNavigator4Ad.dataSource = self;
  [scroll addSubview:self.swiperNavigator4Ad];
  
  [SDK fetchApplicationAdvertisementsWithParameters:@{} andCompletion:^(NSArray *data) {
    [self.ads4App addObjectsFromArray:data];
    [self.swiperNavigator4Ad autoplay:5];
  }];
  
  /*!
  ** scroll notification
  */
  int cardWidth = [GUX screenWidth] - Styles.padding * 2;
  int cardHeight = 168;
  int y = 248;
  
  self.scrollNotification4App = [[GXScrollNotification alloc] initWithFrame:CGRectMake(0, y, GUX.screenWidth, 24)];
  self.scrollNotification4App.delegate = self;
  self.scrollNotification4App.dataSource = self;
  [scroll addSubview:self.scrollNotification4App];
  
  [SDK fetchApplicationNotificationsWithParameters:@{} andCompletion:^(NSArray* data) {
    [self.notifs4App addObjectsFromArray:data];
    [self.scrollNotification4App autoplay:3];
  }];
  
  contentHeight += 24 + Styles.padding / 2;
  y += 24 + Styles.padding / 2;
  
  CGRect frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  UIView* widget = [self makeWidgetWithFrame:frame
                                    andTitle:@"滚动导航"
                                 andSubtitle:@"swiper_navigator"
                                    andImage:@"Image.Widget.Swiper_Navigator"
                              andDescription:@"滚动导航通常用在顶部以图片形式给用户介绍系统内容或者第三方广告。"
                                 andSelector:@selector(gotoSwiperNavigator:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"栅格导航"
                         andSubtitle:@"grid_navigator"
                            andImage:@"Image.Widget.Grid_Navigator"
                      andDescription:@"栅格导航提供以栏位布局为主要风格的页面入口，入口通常为类似于按钮的图标加文字的形式，或者完整的图片形式。"
                         andSelector:@selector(gotoGridNavigator:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"列表导航"
                         andSubtitle:@"list_navigator"
                            andImage:@"Image.Widget.List_Navigator"
                      andDescription:@"列表导航提供以列表布局的页面跳转的入口，每一个瓦片通常都是目的内容图标、文字加指示器图标构成。"
                         andSelector:@selector(gotoListNavigator:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"滑动导航"
                         andSubtitle:@"scroll_navigator"
                            andImage:@"Image.Widget.Scroll_Navigator"
                      andDescription:@"滑动导航是一种通常放置于页面顶部的类别选择部件，通过单项的点击选择后高亮，同时改变下方集合部件的内容。"
                         andSelector:@selector(gotoScrollNavigator:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"页签导航"
                         andSubtitle:@"tabs"
                            andImage:@"Image.Widget.Tabs"
                      andDescription:@"页签导航类似于滑动导航，区别在于单项的个数较少，不超过屏幕宽度，同时是需要支持内容页面的滑动切换功能。"
                         andSelector:@selector(gotoTabs:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"日历导航"
                         andSubtitle:@"calendar"
                            andImage:@"Image.Widget.Calendar"
                      andDescription:@"日历导航是以日期为分类类别的选择部件，通过日期的选择来触发下方集合内容的改变。"
                         andSelector:@selector(gotoCalendar:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"滚动通知"
                         andSubtitle:@"scroll_notification"
                            andImage:@"Image.Widget.Scroll_Notification"
                      andDescription:@"滚动通知提供给用户系统滚动播出的系统消息。"
                         andSelector:@selector(gotoTabs:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"编辑表单"
                         andSubtitle:@"editable_form"
                            andImage:@"Image.Widget.Editable_Form"
                      andDescription:@"编辑表单提供用户输入信息的部件，存在单列式和两列式两种编辑表单展现形式。"
                         andSelector:@selector(gotoEditableForm:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"只读表单"
                         andSubtitle:@"readonly_form"
                            andImage:@"Image.Widget.Readonly_Form"
                      andDescription:@"只读表单提供展现用户输入信息的部件，不可编辑，和编辑表单一样也存在单列式和两列式两种展现形式。"
                         andSelector:@selector(gotoReadonlyForm:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"传统列表"
                         andSubtitle:@"list_view"
                            andImage:@"Image.Widget.List_View"
                      andDescription:@"传统列表以瓦片的形式单列竖式展示集合内容，是应用程序最为常用的集合内容展现部件。"
                         andSelector:@selector(gotoListView:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"栅格列表"
                         andSubtitle:@"grid_view"
                            andImage:@"Image.Widget.Grid_View"
                      andDescription:@"栅格列表以卡片的形式双列竖式展示集合内容，是应用程序最为常用的集合内容展现部件。"
                         andSelector:@selector(gotoListView:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"饼状图表"
                         andSubtitle:@"chart"
                            andImage:@"Image.Widget.Pie_Chart"
                      andDescription:@"饼状图表提供按照类别（少量）对某类信息统计的数据可视化的解决方案。"
                         andSelector:@selector(gotoPieChart:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"柱状图表"
                         andSubtitle:@"chart"
                            andImage:@"Image.Widget.Bar_Chart"
                      andDescription:@"柱状图表提供按照类别对某类信息统计的数据可视化的解决方案，同时也支持主维度下子维度的展示。"
                         andSelector:@selector(gotoBarChart:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"折线图表"
                         andSubtitle:@"chart"
                            andImage:@"Image.Widget.Line_Chart"
                      andDescription:@"折线图表提供按照类别对某类信息趋势分析的数据可视化的解决方案。"
                         andSelector:@selector(gotoLineChart:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"表盘图表"
                         andSubtitle:@"chart"
                            andImage:@"Image.Widget.Gauge_Chart"
                      andDescription:@"表盘图表提供按照即时数据展示的数据可视化的解决方案。"
                         andSelector:@selector(gotoGaugeChart:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;
  
  frame = CGRectMake(Styles.padding, y, cardWidth, cardHeight);
  widget = [self makeWidgetWithFrame:frame
                            andTitle:@"底部弹窗"
                         andSubtitle:@"bottom_sheet"
                            andImage:@"Image.Widget.Bottom_Sheet"
                      andDescription:@"底部弹窗提供从底部弹出的编辑界面，通常是自定义的信息录入界面。"
                         andSelector:@selector(gotoListView:)];
  [scroll addSubview:widget];
  
  contentHeight += cardHeight + Styles.padding;
  y += cardHeight + Styles.padding;

  scroll.contentSize = CGSizeMake([GUX screenWidth], contentHeight);
}

- (UIView*)makeWidgetWithFrame:(CGRect)frame 
                      andTitle:(NSString*)title
                   andSubtitle:(NSString*)subtitle
                      andImage:(NSString*)imageName
                andDescription:(NSString*)description
                   andSelector:(SEL)selector {
  int buttonWidth = 120;
  int buttonHeight = 36;
  UIView* ret = [[UIView alloc] init];
  
  UILabel* titleLabel = [[UILabel alloc] init];
  titleLabel.frame = CGRectMake(Styles.padding, Styles.padding, frame.size.width - Styles.padding * 2, 24);
  titleLabel.text = title;
  titleLabel.font = Styles.titleFont;
  titleLabel.textColor = Styles.textPrimaryColor;
  ret.frame = frame;
  
  UILabel* subtitleLabel = [[UILabel alloc] init];
  subtitleLabel.frame = CGRectMake(Styles.padding, Styles.padding + 20 + 4, frame.size.width - Styles.padding * 2, 24);
  subtitleLabel.text = subtitle;
  subtitleLabel.font = Styles.subtitleFont;
  subtitleLabel.textColor = Styles.textSecondaryColor;
  ret.frame = frame;
  
  int iconWidth = 42;
  UIImageView* iconView = [[UIImageView alloc] init];
  iconView.frame = CGRectMake(frame.size.width - iconWidth - Styles.padding, Styles.padding, iconWidth, iconWidth);
  iconView.image = [UIImage imageNamed:imageName];
  
  UILabel* descrLabel = [[UILabel alloc] init];
  descrLabel.frame = CGRectMake(Styles.padding, Styles.padding + 40 + 16, frame.size.width - Styles.padding * 2, 24);
  descrLabel.numberOfLines = 0;
  descrLabel.lineBreakMode = NSLineBreakByWordWrapping;
  descrLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
  descrLabel.textColor = Styles.textSecondaryColor;
  
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.firstLineHeadIndent = 26.0;
  paragraphStyle.lineSpacing = 4.0;

  NSDictionary* attributes = @{
    NSParagraphStyleAttributeName: paragraphStyle
  };
  NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:description attributes:attributes];

  descrLabel.attributedText = attributedText;
  
  [descrLabel sizeToFit];
  
  UIButton* learn = [[UIButton alloc] init];
  [learn setTitle:@"了解更多" forState:UIControlStateNormal];
  learn.frame = CGRectMake(frame.size.width - Styles.padding - buttonWidth, 
                           frame.size.height - Styles.padding - buttonHeight,
                           buttonWidth, buttonHeight);
  [learn setTitleColor:Styles.primaryColor forState:UIControlStateNormal];
  learn.layer.cornerRadius = 12;
  learn.layer.borderWidth = 1;
  learn.layer.borderColor = Styles.primaryColor.CGColor;
  [learn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
  
  [ret addSubview:titleLabel];
  [ret addSubview:subtitleLabel];
  [ret addSubview:iconView];
  [ret addSubview:descrLabel];
  [ret addSubview:learn];
  
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

- (void)gotoListView:(UIButton *)sender {
  ListViewViewController* vc = [[ListViewViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoCalendar:(UIButton *)sender {
  CalendarViewController* vc = [[CalendarViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoTabs:(UIButton *)sender {
  TabsViewController* vc = [[TabsViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoGridNavigator:(UIButton *)sender {
  GridNavigatorViewController* vc = [[GridNavigatorViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoListNavigator:(UIButton *)sender {
  ListNavigatorViewController* vc = [[ListNavigatorViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoScrollNavigator:(UIButton *)sender {
  ScrollNavigatorViewController* vc = [[ScrollNavigatorViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoSwiperNavigator:(UIButton *)sender {
  SwiperNavigatorViewController* vc = [[SwiperNavigatorViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoEditableForm:(UIButton *)sender {
  EditableFormViewController* vc = [[EditableFormViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoReadonlyForm:(UIButton *)sender {
  ReadonlyFormViewController* vc = [[ReadonlyFormViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoLineChart:(UIButton *)sender {
  LineChartViewController* vc = [[LineChartViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoBarChart:(UIButton *)sender {
  BarChartViewController* vc = [[BarChartViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoPieChart:(UIButton *)sender {
  PieChartViewController* vc = [[PieChartViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoGaugeChart:(UIButton *)sender {
  GaugeChartViewController* vc = [[GaugeChartViewController alloc] init];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - GXScrollNotificationDelegate

- (void)scrollNotification:(GXScrollNotification *)scrollNotification didTapItemAtIndex:(NSInteger)index {
  NSLog(@"clicked scroll notification at index: %ld", index);
}

#pragma mark - GXScrollNotificationDataSource

- (NSInteger)numberOfNotifications:(GXScrollNotification *)scrollNotification {
  return self.notifs4App.count;
}

- (NSDictionary *)scrollNotification:(GXScrollNotification *)scrollNotification dataForItemAtIndex:(NSInteger)index {
  return self.notifs4App[index];
}

#pragma mark - GXSwiperNavigatorDelegate

- (void)swiperNavigator:(id)swiperNavigator didTapItemAtIndex:(NSInteger)index {
  NSLog(@"clicked swiper navigator at index: %ld", index);
}

#pragma mark - GXSwiperNavigatorDataSource

- (NSInteger)numberOfNavigators:(GXSwiperNavigator *)swiperNavigator {
  return self.ads4App.count;
}

- (NSDictionary *)swiperNavigator:(GXSwiperNavigator *)swiperNavigator dataForItemAtIndex:(NSInteger)index { 
  return self.ads4App[index];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView.contentOffset.y >= 100)
    [self.navigationController setNavigationBarHidden:NO animated:YES];
  else {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
  }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView.contentOffset.y < 320) {
    // NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
  }
  else if (scrollView.contentOffset.y >= 320) {
    // NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
  }
}


@end
