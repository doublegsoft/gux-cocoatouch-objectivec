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
#import "GridViewViewController.h"

#import "GUX/Common/GUX.h"
#import "GUX/Widget/GridView/GXGridView.h"
#import "Styles.h"

@interface GridViewViewController () <GXGridViewDelegate, GXGridViewDataSource>

@property (nonatomic, strong) UISearchBar* searchBar;

@property (nonatomic, strong) GXGridView* gridView;

@end

@implementation GridViewViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  
  self.view.backgroundColor = Styles.backgroundColor;
  self.title = @"栅格列表";
  
  int y = GUX.topPadding + navigationBarHeight;
  int contentWidth = GUX.screenWidth - Styles.padding * 2;
  int sbHeight = 42;
  int scHeight = 36;
  
  self.searchBar = [[UISearchBar alloc] init];
  self.searchBar.frame = CGRectMake(0, y,
                                    [GUX screenWidth], sbHeight);
  
  y += sbHeight;
  y += Styles.padding;
  
  self.gridView = [[GXGridView alloc] initWithFrame:CGRectMake(0, y,
                                                               GUX.screenWidth,
                                                               GUX.screenHeight- y - Styles.padding - GUX.bottomPadding)];
  self.gridView.backgroundColor = UIColor.whiteColor;
  self.gridView.dataSource = self;
  self.gridView.delegate = self;
  
  [self.view addSubview:self.searchBar];
  [self.view addSubview:self.gridView];
  
  [self.gridView render];
}

#pragma mark - GXGridViewDelegate

- (void)gridView:(GXGridView *)gridView gotoWhereAtIndex:(NSInteger)index {
  
}

#pragma mark - GXGridViewDataSource

- (NSInteger)numberOfItems:(GXGridView*)gridView {
  return 60;
}

- (UIView *)gridView:(GXGridView *)gridView viewForItemAtIndex:(NSInteger)index { 
  UIView* ret = [[UIView alloc] init];
  ret.frame = CGRectMake(0, 0, GUX.screenWidth - Styles.padding * 2, 44 + arc4random() % 40);
  
  ret.backgroundColor = Styles.surfaceColor;
  
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

@end
