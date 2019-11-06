//
//  AppDelegate.m
//  FlutterHybrid
//
//  Created by yuan on 2019/11/4.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:ViewController.new];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

#warning 为什么会闪退？？？？
- (void)applicationDidEnterBackground:(UIApplication*)application {
//    [_lifeCycleDelegate applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication*)application {
//    [_lifeCycleDelegate applicationWillEnterForeground:application];
}
- (void)applicationWillResignActive:(UIApplication*)application {
//    [_lifeCycleDelegate applicationWillResignActive:application];
}
- (void)applicationDidBecomeActive:(UIApplication*)application {
//    [_lifeCycleDelegate applicationDidBecomeActive:application];
}
- (void)applicationWillTerminate:(UIApplication*)application {
//    [_lifeCycleDelegate applicationWillTerminate:application];
}

@end

