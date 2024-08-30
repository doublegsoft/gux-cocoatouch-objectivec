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
#import "Toast/UIView+Toast.h"
#import "DSFSparkline-Swift.h"
#import "GUX/Common/GUX.h"
#import "TabsViewController.h"
#import "Styles.h"

@interface TabsViewController ()

@end

@implementation TabsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.selectedGroup = 0;
  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"页签导航";
  
  int y = GUX.topPadding + navigationBarHeight;
  int contentWidth = GUX.screenWidth - Styles.padding * 2;
  int sbHeight = 42;
  int scHeight = 36;
  
  self.searchBar = [[UISearchBar alloc] init];
  self.searchBar.frame = CGRectMake(0, y,
                                    [GUX screenWidth], sbHeight);
  
  y += sbHeight;
  y += Styles.padding / 2;
  
  self.segmentedControl = [[UISegmentedControl alloc] init];
  self.segmentedControl.frame = CGRectMake(Styles.padding, y,
                                           contentWidth, scHeight);
  
  [self.segmentedControl insertSegmentWithTitle:@"A" atIndex:0 animated:YES];
  [self.segmentedControl insertSegmentWithTitle:@"B" atIndex:1 animated:YES];
  [self.segmentedControl insertSegmentWithTitle:@"C" atIndex:2 animated:YES];
  
  self.segmentedControl.tintColor = Styles.primaryColor;
  self.segmentedControl.selectedSegmentIndex = 0;
  
  [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
  
  y += scHeight;
  
  self.listView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                y + Styles.padding,
                                                                GUX.screenWidth - Styles.padding,
                                                                GUX.screenHeight- y - Styles.padding * 2)];
  
  self.listView.dataSource = self;
  self.listView.delegate = self;
  
  [self.view addSubview:self.searchBar];
  [self.view addSubview:self.segmentedControl];
  [self.view addSubview:self.listView];
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
  [self.navigationController.view makeToastActivity:CSToastPositionCenter];
  self.selectedGroup = sender.selectedSegmentIndex;
  
  [self.listView reloadData];
  
  dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
          
  // Dispatch the block after the delay
  dispatch_after(delayTime, dispatch_get_main_queue(), ^{
    [self.navigationController.view hideToastActivity];
  });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  int iconWidth = 48;
  int chartWidth = 150;
  int cellContentWidth = GUX.screenWidth - Styles.padding * 2;
  UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  // Configure the cell
  cell.backgroundColor = [UIColor whiteColor];
  
  UIImageView* imageView = [[UIImageView alloc] init];
  imageView.frame = CGRectMake(Styles.padding, Styles.padding, iconWidth, iconWidth);
  imageView.image = [UIImage imageNamed:@"Image.Widget.Tabs"];
  [cell.contentView addSubview:imageView];
  
  // Add a label to the cell
  UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(Styles.padding + iconWidth + 8, Styles.padding + 4, 120, 22)];
  label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
  label.text = [NSString stringWithFormat:@"页签：%@", [self.segmentedControl titleForSegmentAtIndex:self.selectedGroup]];
  [cell.contentView addSubview:label];
  
  label = [[UILabel alloc] initWithFrame:CGRectMake(Styles.padding + iconWidth + 8, Styles.padding + 26, 120, 22)];
  label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
  label.textColor = [Styles textSecondaryColor];
  label.text = [NSString stringWithFormat:@"这里是行号： %ld", (long)indexPath.item];
  [cell.contentView addSubview:label];
  
  int total = 5;
  if (indexPath.row % total == 0) {
    DSFSparklinePercentBarGraphView* sparkline = [[DSFSparklinePercentBarGraphView alloc] init];
    sparkline.frame = CGRectMake(cellContentWidth - chartWidth + Styles.padding, (80 - 36) / 2, chartWidth, 36);
    sparkline.value = 0.8;
    sparkline.barColor = Styles.primaryColor;
    [cell.contentView addSubview:sparkline];
  } else if (indexPath.row % total == 1) {
    DSFSparklineDataBarGraphView* sparkline = [[DSFSparklineDataBarGraphView alloc] init];
    sparkline.frame = CGRectMake(cellContentWidth - chartWidth + Styles.padding, (80 - 36) / 2, chartWidth, 36);
    sparkline.dataSource = [[DSFSparklineStaticDataSource alloc] init:@[@10,@12,@33,@21,@56,@34] lowerBound:0 upperBound:60];
    [cell.contentView addSubview:sparkline];
  } else if (indexPath.row % total == 2) {
    DSFSparklinePieGraphView* sparkline = [[DSFSparklinePieGraphView alloc] init];
    sparkline.frame = CGRectMake(cellContentWidth - chartWidth + Styles.padding, Styles.padding / 2, chartWidth, 64);
    sparkline.dataSource = [[DSFSparklineStaticDataSource alloc] init:@[@10,@12,@33,@21,@56,@34] lowerBound:0 upperBound:60];
    [cell.contentView addSubview:sparkline];
  } else if (indexPath.row % total == 3) {
    DSFSparklineStackLineGraphView* sparkline = [[DSFSparklineStackLineGraphView alloc] init];
    sparkline.frame = CGRectMake(cellContentWidth - chartWidth + Styles.padding, Styles.padding / 2, chartWidth, 64);
    DSFSparklineDataSource* ds = [[DSFSparklineDataSource alloc] init];
    [ds setWithValues:@[@10,@12,@33,@21,@56,@34]];
    sparkline.dataSource = ds;
    [cell.contentView addSubview:sparkline];
  } else if (indexPath.row % total == 4) {
    DSFSparklineLineGraphView* sparkline = [[DSFSparklineLineGraphView alloc] init];
    sparkline.frame = CGRectMake(cellContentWidth - chartWidth + Styles.padding, Styles.padding / 2, chartWidth, 64);
    DSFSparklineDataSource* ds = [[DSFSparklineDataSource alloc] init];
    [ds setWithValues:@[@10,@12,@33,@21,@56,@34]];
    sparkline.dataSource = ds;
    [cell.contentView addSubview:sparkline];
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Handle row selection
  // NSLog(@"Selected row: %ld", (long)indexPath.row);
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
  // Create a delete action
  UIContextualAction* deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
    // Handle the delete action
    // NSLog(@"Delete row: %ld", (long)indexPath.row);
    
//    // Remove the row from the data source
//    // [self.dataArray removeObjectAtIndex:indexPath.row];
//    
//    // Delete the row from the table view
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    
//    // Call the completion handler
//    completionHandler(YES);
  }];
  
  // Create a swipe configuration with the delete action
  UISwipeActionsConfiguration *swipeActions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
  
  return swipeActions;
}

#pragma mark - Swipe Actions

- (UISwipeActionsConfiguration *)collectionView:(UICollectionView *)collectionView trailingSwipeActionsConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath {
  // Create a delete action
  UIContextualAction* deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
      // Handle the delete action
    // NSLog(@"Delete item at indexPath: %@", indexPath);
    completionHandler(YES);
  }];
  
  // Create a swipe actions configuration
  UISwipeActionsConfiguration* configuration = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
  return configuration;
}

@end
