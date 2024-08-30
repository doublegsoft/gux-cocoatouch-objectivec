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
#import "MainViewController.h"
#import "WidgetViewController.h"
#import "PageViewController.h"
#import "ApplicationViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  WidgetViewController* widget = [[WidgetViewController alloc] init];
  PageViewController* page = [[PageViewController alloc] init];
  ApplicationViewController* app = [[ApplicationViewController alloc] init];
  
  widget.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"部件介绍"
                                                    image:[UIImage imageNamed:@"Image.Widget"]
                                                      tag:0];
  
  page.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"页面设计"
                                                  image:[UIImage imageNamed:@"Image.Page"]
                                                    tag:1];
  
  app.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"应用程序"
                                                 image:[UIImage imageNamed:@"Image.Application"]
                                                   tag:2];
  
  UINavigationController* vc1 = [[UINavigationController alloc] initWithRootViewController:widget];
  UINavigationController* vc2 = [[UINavigationController alloc] initWithRootViewController:page];
  UINavigationController* vc3 = [[UINavigationController alloc] initWithRootViewController:app];
  
  [self setViewControllers:[NSArray arrayWithObjects:vc1, vc2, vc3, nil]];
}


@end
