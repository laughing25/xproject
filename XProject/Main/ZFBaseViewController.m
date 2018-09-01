//
//  ZFBaseViewController.m
//  Dezzal
//
//  Created by 7FD75 on 16/7/21.
//  Copyright © 2016年 7FD75. All rights reserved.
//

#import "ZFBaseViewController.h"

@interface ZFBaseViewController ()
@property (nonatomic, strong) UIView    *againRequestView;
@property (nonatomic, strong) UIButton  *backButton;
@end

@implementation ZFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if (IOS7UP) {
        self.tabBarController.tabBar.translucent = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //防止控制器的title发生偏移
    [self setBackButtomTitleToEmpty];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

/** 场景: 部分子类是自定义导航, 在子页面请求时loading会盖住整个页面
 *  网络差时无法点击返回,因此子类懒加载一个返回按钮
 */
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor clearColor];
        CGFloat height = IPHONE_X_5_15 ? 94 : 64;
        _backButton.frame = CGRectMake(0, 0, 64, height);
        [_backButton addTarget:self action:@selector(popBackVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
    }
    return _backButton;
}

/**
 * 显示一个占位的返回按钮
 */
- (void)bringTempBackButtonToFront
{
    self.backButton.hidden = NO;
    [self.view bringSubviewToFront:self.backButton];
}

#pragma mark -===========导航按钮事件===========

/**
 * 导航左侧按钮
 */
- (void)leftSearchBtnClick:(UIButton *)button
{
    
}

/**
 * 导航右侧按钮
 */
- (void)rightSearchBtnClick:(UIButton *)button
{
    
}

/**
 *  此方法是为了防止控制器的title发生偏移，造成这样的原因是因为返回按钮的文字描述占位
 */
- (void)setBackButtomTitleToEmpty
{
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    
    if ([viewControllerArray containsObject:self]) {
        long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
        UIViewController *previous;
        if (previousViewControllerIndex >= 0) {
            previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]
                                         initWithTitle:@"" style:UIBarButtonItemStylePlain
                                         target:self
                                         action:nil];
            previous.navigationItem.backBarButtonItem = backItem;
        }
    }
}

/**
 *  返回上个控制器
 */
-(void)popBackVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
