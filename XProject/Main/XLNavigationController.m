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
#import "XLBaseViewController.h"

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
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexColorString:@"276ecd"]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    // 将返回按钮的文字position设置不在屏幕上显示
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"ro_left"];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:@"ro_left"];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    self.delegate = self;
    [self.navigationBar setBarStyle:UIBarStyleDefault];
}

//重写这个方法,能拦截所有的push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    NSArray *viewControllerArray = [self viewControllers];
    if ([viewControllerArray count] > 1) {
        viewController.navigationItem.hidesBackButton = YES;
        id target = nil;
        if ([viewController isKindOfClass:[XLBaseViewController class]]) {
            target = viewController;
        }else{
            target = self;
        }
        NSString *imageName = @"nav_arrow_left";
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName]
                                                                                                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:target
                                                                                          action:@selector(goBackAction)];
        viewController.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    }
}

-(void)goBackAction
{
    [self popViewControllerAnimated:YES];
}

@end
