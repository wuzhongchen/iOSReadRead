//
//  AppDelegate.m
//  readread
//
//  Created by hs on 2020/12/12.
//  Copyright © 2020 hs. All rights reserved.
//

#import "AppDelegate.h"
#import "DefTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1. 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    DefTabBarController *tabBarVC = [[DefTabBarController alloc] init];
    self.window.rootViewController = tabBarVC;
    
    //3. 使窗口可见
    [self.window makeKeyAndVisible];
    return YES;
}


@end
