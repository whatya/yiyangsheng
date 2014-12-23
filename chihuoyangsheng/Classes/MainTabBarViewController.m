//
//  MainTabBarViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-23.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBar setSelectionIndicatorImage:[[UIImage imageNamed:@"btn_background.png"]
                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIStoryboard *versionSnd = [UIStoryboard storyboardWithName:@"VersionSnd" bundle:nil];
    
    UIViewController *tabbarVC1 = [storyboard instantiateViewControllerWithIdentifier:@"tabbarVC1"];
    UIViewController *tabbarVC2 = [versionSnd instantiateViewControllerWithIdentifier:@"tabbarVC2"];
    UIViewController *tabbarVC3 = [versionSnd instantiateViewControllerWithIdentifier:@"tabbarVC3"];
    UIViewController *tabbarVC4 = [versionSnd instantiateViewControllerWithIdentifier:@"tabbarVC4"];
    self.viewControllers = @[tabbarVC1,tabbarVC2,tabbarVC3,tabbarVC4];
    NSArray *test = self.tabBar.items;
    UITabBarItem *tab1 = test[0];
    tab1.image = [[UIImage imageNamed:@"tabbar1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab1.title = @"每日食谱";
    tab1.selectedImage = [[UIImage imageNamed:@"tabbar1S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tab2 = test[1];
    tab2.image = [[UIImage imageNamed:@"tabbar2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab2.title = @"怎么吃";
    tab2.selectedImage = [[UIImage imageNamed:@"tabbar2S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tab3 = test[2];
    tab3.image = [[UIImage imageNamed:@"tabbar3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab3.title = @"活动";
    tab3.selectedImage = [[UIImage imageNamed:@"tabbar1b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab3.selectedImage = [[UIImage imageNamed:@"tabbar3S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tab4 = test[3];
    tab4.image = [[UIImage imageNamed:@"tabbar4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab4.title = @"资讯";
    tab4.selectedImage = [[UIImage imageNamed:@"tabbar4S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}




@end
