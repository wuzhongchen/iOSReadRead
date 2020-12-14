//
//  DefTabBarController.m
//  readread
//
//  Created by hs on 2020/12/12.
//  Copyright © 2020 hs. All rights reserved.
//

#import "DefTabBarController.h"
#import "BookShelfViewController.h"
#import "BookStoreViewController.h"
#import "MineViewController.h"
@interface DefTabBarController ()

@end

@implementation DefTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureAllChildViewController];
    

    //设置各个barItem的图标与文字
    [self configureAllBarItems];


    //替换系统的tabBarItem
    [self configureCustomedTabBarItem];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -----添加自定义的tabBarItem-----
- (void)configureCustomedTabBarItem{
    
}

#pragma mark -----配置所有子控制器-----
- (void)configureAllChildViewController{
    BookShelfViewController *shelfVC = [[BookShelfViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shelfVC];
    
    [self addChildViewController:nav];
    
    BookStoreViewController *storeVC = [[BookStoreViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:storeVC];
    
    [self addChildViewController:nav2];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    [self addChildViewController:nav3];
}

#pragma mark -----设置所有按钮的图片与标题-----
- (void)configureAllBarItems{
    
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"书架";
    nav.tabBarItem.image = [UIImage imageNamed:@"hw_app_library_default"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"hw_app_library_selected"];
    
    UINavigationController *nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"书城";
    nav2.tabBarItem.image = [UIImage imageNamed:@"hw_app_explore_default"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"hw_app_explore_selected"];
    
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"我的";
    nav3.tabBarItem.image = [UIImage imageNamed:@"hw_app_profile_default"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"hw_app_profile_selected"];
}

@end
