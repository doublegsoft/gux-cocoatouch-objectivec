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
#import "ListViewViewController.h"

#import "GUX/Common/GUX.h"
#import "GUX/Widget/ListView/GXListView.h"
#import "Styles.h"

@interface ListViewViewController () <GXListViewDelegate, GXListViewDataSource>

@property (nonatomic, strong) UISearchBar* searchBar;

@property (nonatomic, strong) GXListView* listView;

@end

@implementation ListViewViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  
  self.view.backgroundColor = Styles.backgroundColor;
  self.title = @"传统列表";
  
  int y = GUX.topPadding + navigationBarHeight;
  int contentWidth = GUX.screenWidth - Styles.padding * 2;
  int sbHeight = 42;
  int scHeight = 36;
  
  self.searchBar = [[UISearchBar alloc] init];
  self.searchBar.frame = CGRectMake(0, y,
                                    [GUX screenWidth], sbHeight);
  
  y += sbHeight;
  y += Styles.padding;
  
  self.listView = [[GXListView alloc] initWithFrame:CGRectMake(Styles.padding, y,
                                                               GUX.screenWidth - Styles.padding * 2,
                                                               GUX.screenHeight- y - Styles.padding - GUX.bottomPadding)];
  
  self.listView.dataSource = self;
  self.listView.delegate = self;
  
  [self.view addSubview:self.searchBar];
  [self.view addSubview:self.listView];
}

#pragma mark - GXListViewDelegate

- (void)listView:(GXListView *)listView doRemoveItemAtIndex:(NSInteger)index { 
  
}

- (void)listView:(GXListView *)listView gotoWhereAtIndex:(NSInteger)index { 

}

#pragma mark - GXListViewDataSource

- (UIView *)listView:(GXListView *)listView viewForItemAtIndex:(NSInteger)index {
  UIView* ret = [[UIView alloc] init];
  ret.frame = CGRectMake(0, 0, GUX.screenWidth - Styles.padding * 2, 44);
  
  UILabel* label = [[UILabel alloc] init];
  label.text = [NSString stringWithFormat:@"%ld", index];
  label.frame = CGRectMake(Styles.padding, 14, 100, 16);
  
  UIView* bottomLine = [[UIView alloc] init];
  bottomLine.frame = CGRectMake(Styles.padding,
                                ret.bounds.size.height - 1,
                                ret.bounds.size.width - Styles.padding * 2,
                                1);
  bottomLine.backgroundColor = Styles.dividerColor;
  
  [ret addSubview:label];
  [ret addSubview:bottomLine];
  return ret;
}

- (NSInteger)numberOfItems:(GXListView *)listView { 
  return 100;
}

@end
