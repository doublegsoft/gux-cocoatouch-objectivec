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
#import "GXTwoColumnForm.h"

#import "CoreActionSheetPicker.h"

#import "GUX/Common/GUX.h"
#import "GUX/Widget/Common/GXTextField.h"

#import "Styles.h"

@interface GXTwoColumnForm() <UITextFieldDelegate>

@property (nonatomic, strong) AbstractActionSheetPicker* actionSheetPicker;

@property (nonatomic) NSInteger labelWidth;

@end

@implementation GXTwoColumnForm

static CGFloat TEXT_HEIGHT = 48;

- (instancetype)initWithLabelWidth:(CGFloat)labelWidth {
  self = [super init];
  self.labelWidth = labelWidth;
  return self;
}

- (void)render:(NSArray*)fields {
  CGFloat contentHeight = 0;
  UIScrollView* scroll = [[UIScrollView alloc] init];
  scroll.showsHorizontalScrollIndicator = NO;
  scroll.bounces = NO;
  scroll.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
  int y = 0;
  for (int i = 0; i < fields.count; i++) {
    NSDictionary* field = fields[i];
    NSString* input = field[@"input"];
    UIView* view;
    if ([input isEqualToString:@"date"]) {
      view = [self buildDate:field atY:y];
    } else if ([input isEqualToString:@"mobile"]) {
      view = [self buildText:field atY:y];
      
      UITextField* textField = view.subviews[1];
      textField.keyboardType = UIKeyboardTypePhonePad;
    } else if ([input isEqualToString:@"select"]) {
      view = [self buildSelect:field atY:y];
    } else {
      view = [self buildText:field atY:y];
    }
    y += TEXT_HEIGHT;
    contentHeight += TEXT_HEIGHT;
    [scroll addSubview:view];
    
    UIView* divider = [[UIView alloc] initWithFrame:CGRectMake(0, y - 1, self.bounds.size.width, 1)];
    divider.backgroundColor = Styles.dividerColor;
    [scroll addSubview:divider];
  }
  scroll.contentSize = CGSizeMake(self.bounds.size.width, contentHeight);
  [self addSubview:scroll];
}

- (UIView*)buildText:(NSDictionary*)field atY:(CGFloat)y {
  UIView* ret = [[UIView alloc] init];
  ret.frame = CGRectMake(0, y, self.bounds.size.width, TEXT_HEIGHT);
  UILabel* label = [[UILabel alloc] init];
  label.font = [UIFont systemFontOfSize:15];
  label.frame = CGRectMake(0, 0, self.labelWidth, TEXT_HEIGHT);
  label.text = [NSString stringWithFormat:@"%@：", field[@"title"]];
  
  GXTextField* text = [[GXTextField alloc] initWithField:field];
  text.frame = CGRectMake(self.labelWidth, 0, self.bounds.size.width - self.labelWidth, TEXT_HEIGHT);
  text.font = [UIFont systemFontOfSize:15];
  text.delegate = self;
  text.placeholder = @"请填写";
  
  [ret addSubview:label];
  [ret addSubview:text];
  return ret;
}

- (UIView*)buildDate:(NSDictionary*)field atY:(CGFloat)y {
  UIView* ret = [[UIView alloc] init];
  ret.frame = CGRectMake(0, y, self.bounds.size.width, TEXT_HEIGHT);
  
  UILabel* label = [[UILabel alloc] init];
  label.font = [UIFont systemFontOfSize:15];
  label.frame = CGRectMake(0, 0, self.labelWidth, TEXT_HEIGHT);
  label.text = [NSString stringWithFormat:@"%@：", field[@"title"]];
  
  GXTextField* date = [[GXTextField alloc] initWithField:field];
  date.frame = CGRectMake(self.labelWidth, 0, self.bounds.size.width - self.labelWidth - 24, TEXT_HEIGHT);
  date.font = [UIFont systemFontOfSize:15];
  date.delegate = self;
  date.placeholder = @"请选择...";
  date.enabled = NO;
  
  UILabel* icon = [[UILabel alloc] init];
  icon.font = [UIFont fontWithName:@"gx-iconfont" size:24];
  icon.text = @"\ue60b";
  icon.frame = CGRectMake(self.bounds.size.width - 24, 12, 24, 24);
  
  ret.userInteractionEnabled = YES;
  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doPickDate:)];
  [ret addGestureRecognizer:tapGesture];
  
  [ret addSubview:label];
  [ret addSubview:date];
  [ret addSubview:icon];
  return ret;
}

- (UIView*)buildSelect:(NSDictionary*)field atY:(CGFloat)y {
  UIView* ret = [[UIView alloc] init];
  ret.frame = CGRectMake(0, y, self.bounds.size.width, TEXT_HEIGHT);
  
  UILabel* label = [[UILabel alloc] init];
  label.font = [UIFont systemFontOfSize:15];
  label.frame = CGRectMake(0, 0, self.labelWidth, TEXT_HEIGHT);
  label.text = [NSString stringWithFormat:@"%@：", field[@"title"]];
  
  GXTextField* select = [[GXTextField alloc] initWithField:field];
  select.frame = CGRectMake(self.labelWidth, 0, self.bounds.size.width - self.labelWidth, TEXT_HEIGHT);
  
  select.font = [UIFont systemFontOfSize:15];
  select.delegate = self;
  select.placeholder = @"请选择...";
  select.enabled = NO;
  
  UILabel* icon = [[UILabel alloc] init];
  icon.font = [UIFont fontWithName:@"gx-iconfont" size:18];
  icon.text = @"\ue61f";
  icon.frame = CGRectMake(self.bounds.size.width - 20, 12, 24, 24);
  
  ret.userInteractionEnabled = YES;
  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doPickValue:)];
  [ret addGestureRecognizer:tapGesture];
  
  [ret addSubview:label];
  [ret addSubview:select];
  [ret addSubview:icon];
  return ret;
}

- (void)doPickDate:(UITapGestureRecognizer*)gesture {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  
  UITextField* dateField = gesture.view.subviews[1];
  dateField.font = [UIFont systemFontOfSize:15];
  NSString* text = dateField.text;
  NSDate* curr = [dateFormatter dateFromString:text];
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents* minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
  NSDateComponents* maximumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
  [minimumDateComponents setYear:1900];
  [maximumDateComponents setYear:2099];
  [maximumDateComponents setMonth:12];
  [maximumDateComponents setDay:31];
  NSDate* minDate = [calendar dateFromComponents:minimumDateComponents];
  NSDate* maxDate = [calendar dateFromComponents:maximumDateComponents];
  
  
  _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:curr
                                                        minimumDate:minDate
                                                        maximumDate:maxDate
                                                             target:self
                                                             action:@selector(didSelectDate:element:)
                                                             origin:dateField];
  self.actionSheetPicker.hideCancel = YES;
  [self.actionSheetPicker showActionSheetPicker];
}

- (void)didSelectDate:(NSDate *)selectedDate element:(id)element {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  UITextField* text = element;
  text.text = [dateFormatter stringFromDate:selectedDate];
}

- (void)doPickValue:(UITapGestureRecognizer*)gesture {
  GXTextField* textField = gesture.view.subviews[1];
  NSDictionary* options = textField.field[@"options"];
  NSArray* values = options[@"values"];
  NSMutableArray* vals = [[NSMutableArray alloc] init];
  for (int i = 0; i < values.count; i++) {
    NSDictionary* row = values[i];
    [vals addObject:row[@"text"]];
    
  }
  ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
    textField.text = selectedValue;
  };
  [ActionSheetStringPicker showPickerWithTitle:@""
                                          rows:vals
                              initialSelection:0
                                     doneBlock:done
                                   cancelBlock:nil
                                        origin:gesture.view];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

@end
