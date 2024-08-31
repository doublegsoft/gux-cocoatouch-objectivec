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
#import <UIKit/UIKit.h>

#import "GXGridView.h"

@interface GXGridView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, assign) CGFloat firstColumnHeight;

@property (nonatomic, assign) CGFloat secondColumnHeight;

@end

@implementation GXGridView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
  self.firstColumnHeight = 0;
  self.secondColumnHeight = 0;
  
  [self addSubview:self.scrollView];
  return self;
}

- (void)render {
  CGFloat gap = 8;
  CGFloat width = (self.bounds.size.width - gap * 3) / 2;
  for (int i = 0; i < [self.dataSource numberOfItems:self]; i++) {
    UIView* view = [[UIView alloc] init];
    UIView* content = [self.dataSource gridView:self viewForItemAtIndex:i];
    content.frame = CGRectMake(0, 0, width, content.bounds.size.height);
    if (_firstColumnHeight <= _secondColumnHeight) {
      view.frame = CGRectMake(gap, gap + _firstColumnHeight, width, content.bounds.size.height);
      _firstColumnHeight += content.bounds.size.height + gap;
    } else {
      view.frame = CGRectMake(gap * 2 + width, gap + _secondColumnHeight, width, content.bounds.size.height);
      _secondColumnHeight += content.bounds.size.height + gap;
    }
    [view addSubview:content];
    [self.scrollView addSubview:view];
    
    if (_firstColumnHeight <= _secondColumnHeight) {
      self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, _secondColumnHeight);
    } else {
      self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, _firstColumnHeight);
    }
  }
}

@end
