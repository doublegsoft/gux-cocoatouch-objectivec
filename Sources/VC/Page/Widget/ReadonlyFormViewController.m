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
#import "ReadonlyFormViewController.h"
#import "Styles.h"

@interface ReadonlyFormViewController ()

@property (nonatomic, strong) UISegmentedControl* segmentedControl;

@end

@implementation ReadonlyFormViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  int y = GUX.topPadding + navigationBarHeight;
  int contentWidth = GUX.screenWidth - Styles.padding * 2;
  int sbHeight = 42;
  int scHeight = 36;
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"只读表单";
  
  self.segmentedControl = [[UISegmentedControl alloc] init];
  self.segmentedControl.frame = CGRectMake(Styles.padding, y,
                                           contentWidth, scHeight);
  
  [self.segmentedControl insertSegmentWithTitle:@"双列表单" atIndex:0 animated:YES];
  [self.segmentedControl insertSegmentWithTitle:@"单列表单" atIndex:1 animated:YES];
  
  self.segmentedControl.tintColor = Styles.primaryColor;
  self.segmentedControl.selectedSegmentIndex = 0;
  
  [self.view addSubview:self.segmentedControl];
}

@end

