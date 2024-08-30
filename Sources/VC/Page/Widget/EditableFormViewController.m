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
#import "EditableFormViewController.h"

#import "GUX/Common/GUX.h"
#import "GUX/Widget/TwoColumnForm/GXTwoColumnForm.h"
#import "GUX/Widget/SingleColumnForm/GXSingleColumnForm.h"
#import "Styles.h"



@interface EditableFormViewController ()

@property (nonatomic, strong) UISegmentedControl* segmentedControl;

@property (nonatomic, strong) GXTwoColumnForm* twoColumnForm;

@end

@implementation EditableFormViewController

static NSArray* fields;

- (void)viewDidLoad {
  [super viewDidLoad];
  CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
  int y = GUX.topPadding + navigationBarHeight;
  int contentWidth = GUX.screenWidth - Styles.padding * 2;
  int sbHeight = 42;
  int scHeight = 36;
  
  fields = @[@{
    @"title": @"姓名",
    @"name": @"personName",
    @"input": @"text",
  },@{
    @"title": @"曾用名",
    @"name": @"alias",
    @"input": @"text",
  },@{
    @"title": @"性别",
    @"name": @"genderCode",
    @"input": @"select",
    @"options": @{
      @"values": @[@{
        @"text": @"男", @"value": @"M"
      },@{
        @"text": @"女", @"value": @"F"
      }]
    }
  },@{
    @"title": @"生日",
    @"name": @"birthdate",
    @"input": @"date",
  },@{
    @"title": @"手机号码",
    @"name": @"mobile",
    @"input": @"mobile",
  }];
  
  self.view.backgroundColor = Styles.backgroundColor;
  self.title = @"编辑表单";
  
  self.segmentedControl = [[UISegmentedControl alloc] init];
  self.segmentedControl.frame = CGRectMake(Styles.padding, y,
                                           contentWidth, scHeight);
  
  [self.segmentedControl insertSegmentWithTitle:@"双列表单" atIndex:0 animated:YES];
  [self.segmentedControl insertSegmentWithTitle:@"单列表单" atIndex:1 animated:YES];
  
  self.segmentedControl.tintColor = Styles.primaryColor;
  self.segmentedControl.selectedSegmentIndex = 0;
  
  [self.view addSubview:self.segmentedControl];
  y += scHeight + Styles.padding;
  
  [self renderTwoColumnFormAtY:y];
}

- (void)renderTwoColumnFormAtY:(CGFloat)y {
  UIView* card = [Styles buildCardWithFrame:CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, 300)
                                   andTitle:@"个人资料"];
  card.backgroundColor = [UIColor whiteColor];
  
  self.twoColumnForm = [[GXTwoColumnForm alloc] initWithLabelWidth:100];
  self.twoColumnForm.frame = CGRectMake(Styles.padding, Styles.padding * 2.5,
                                        GUX.screenWidth - Styles.padding * 4, 300);
  
  [self.twoColumnForm render:fields];
  [card addSubview:self.twoColumnForm];
  
  [self.view addSubview:card];
}

@end

