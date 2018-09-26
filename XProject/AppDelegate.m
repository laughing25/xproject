//
//  AppDelegate.m
//  XProject
//
//  Created by 610715 on 2018/7/10.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "AppDelegate.h"
#import "XLTabBarController.h"
#import "LoginApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[CMHKLanguagesManager shareManager] initUserLanguage];
    
    [YTKNetworkConfig sharedConfig].baseUrl = @"http://testapi.fnwcm.com/";
    [YTKNetworkConfig sharedConfig].debugLogEnabled = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *rootViewController = [[UIViewController alloc] init];
    rootViewController.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootViewController;
 
    AccountManager *account = [AccountManager shareInstance];
    if ([account isLogin]) {
        @weakify(self)
        LoginApi *api = [[LoginApi alloc] initWithlogin:account.oldUserId password:account.oldPassword];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            @strongify(self)
            AccountModel *accountModel = [AccountModel yy_modelWithJSON:[request requestResponseData]];
            accountModel.password = account.oldPassword;
            account.accountModel = accountModel;
            [self enterHomePage];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            @strongify(self)
            [self enterHomePage];
        }];
    }else{
        [self enterHomePage];
    }
    return YES;
}

- (void)enterHomePage
{
    XLTabBarController *tabbar = [[XLTabBarController alloc] init];
    self.window.rootViewController = tabbar;
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


@end
