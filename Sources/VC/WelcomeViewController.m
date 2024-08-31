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
#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "MainViewController.h"

#import "GUX/Common/GUX.h"

#import "SDK.h"

@interface WelcomeViewController ()

/*!
** swiper control
*/
@property (nonatomic, strong) UIScrollView* scrollView;

/*!
** page indicator
*/
@property (nonatomic, strong) UIPageControl* pageControl;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  
  // Initialize the scroll view
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.pagingEnabled = YES;
  self.scrollView.showsHorizontalScrollIndicator = NO;
  self.scrollView.delegate = self;
  
  
  // Add content to the scroll view
  [self addContentToScrollView];
  
  // Add the scroll view to the main view
  [self.view addSubview:self.scrollView];
}

- (void)addContentToScrollView {
  // Example content: three colored views
  NSArray* colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
  CGFloat width = self.view.bounds.size.width;
  CGFloat height = self.view.bounds.size.height;
  
  CGFloat imageWidth = 300;
  CGFloat imageHeight = 300;
  CGFloat x = ([GUX screenWidth] - imageWidth) / 2;
  CGFloat y = ([GUX screenHeight] - imageHeight) / 3;
  
  [SDK fetchWelcomeImagesWithParameters:@{} andCompletion:^(NSArray* data) {
    for (int i = 0; i < data.count; i++) {
      UIView* pageView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
      UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWidth, imageHeight)];
      [GUX loadImageFromURL:data[i][@"imagePath"] intoImageView:imageView];
      [pageView addSubview:imageView];
      if (i == 2) {
        UIButton* enter = [[UIButton alloc] initWithFrame:CGRectMake(x + (imageWidth - 180) / 2, y + imageHeight + 50, 180, 56)];
        [enter setTitle:@"进入应用" forState:UIControlStateNormal];
        [enter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        enter.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        enter.backgroundColor = [GUX colorWithHexString:@"#73b17b"];
        enter.layer.cornerRadius = 28;
        [enter addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventTouchDown];
        [pageView addSubview:enter];
      }
      [self.scrollView addSubview:pageView];
    }
    // Set the content size of the scroll view
    self.scrollView.contentSize = CGSizeMake(width * data.count, height);
    
    // Initialize the page control
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - [GUX bottomPadding] - 50, self.view.bounds.size.width, 50)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
//    [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Add the page control to the main view
    [self.view addSubview:self.pageControl];
  }];
}

- (IBAction)gotoMainView:(UIButton *)sender {
  AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  MainViewController* main = [[MainViewController alloc] init];
  appDelegate.window.rootViewController = main;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  CGFloat pageWidth = scrollView.frame.size.width;
  NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
  self.pageControl.currentPage = page;
}

@end
