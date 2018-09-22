//
//  YSNavigationController.m
//  Yoshop
//
//  Created by zhaowei on 16/5/25.
//  Copyright © 2016年 yoshop. All rights reserved.
//

#import "XLNavigationController.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

@interface XLNavigationController ()
<
    UINavigationControllerDelegate
>
@end

@implementation XLNavigationController

/**
 *  系统在第一次使用这个类的时候调用(1个类只会调用一次)
 */
+ (void)initialize {
    //设置背景图片
    NSString *bgName = @"";//@"nav_bg";
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:bgName] forBarMetrics:UIBarMetricsDefault];

    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    // 将返回按钮的文字position设置不在屏幕上显示
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"ro_left"];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:@"ro_left"];

    //设置item普通状态
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    attrs[NSForegroundColorAttributeName] = ZFCOLOR_BLACK;
    [[UIBarButtonItem appearance] setTitleTextAttributes:attrs forState:UIControlStateNormal];

    //设置item不可用状态
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    disabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    self.delegate = self;
    [self.navigationBar setBarStyle:UIBarStyleDefault];
}

- (void)config {
    NSString *backImageName = @"return_nav";
    
    UIImage *image = [UIImage imageNamed:backImageName];
    CGFloat w = image.size.width;
    if (KScreenWidth <= 320) {
        w = 30;
    }
    self.navigationBar.backIndicatorImage = image;
    UIImage *backButtonImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, w, 0, -w)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    // 将返回按钮的文字position设置不在屏幕上显示
    if (kiOSSystemVersion < 11) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    }
    self.interactivePopGestureRecognizer.enabled = YES;

    return;
}

//重写这个方法,能拦截所有的push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
