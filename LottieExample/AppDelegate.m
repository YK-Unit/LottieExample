//
//  AppDelegate.m
//  LottieExample
//
//  Created by York on 2017/8/12.
//  Copyright © 2017年 YK-Unit. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SplashView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [self customizeView];

    [self.window makeKeyAndVisible];

    [self addSplashView];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Methods
- (void)customizeView {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = rootNav;
}

- (void)addSplashView {
    SplashView *splashView = [[SplashView alloc] initWithFrame:self.window.bounds];
    __weak SplashView *weakSplashView = splashView;
    [splashView showOnView:self.window withAnimationCompleter:^{
        [UIView animateWithDuration:0.5 animations:^{
            weakSplashView.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSplashView removeFromSuperview];
        }];
    }];
}
@end
