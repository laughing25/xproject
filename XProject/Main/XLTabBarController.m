//
//  YSTabBarController.h
//  Yoshop
//
//  Created by zhaowei on 16/5/25.
//  Copyright © 2016年 yoshop. All rights reserved.
//

#import "XLTabBarController.h"
#import "XLNavigationController.h"
#import "XLShouYeViewController.h"
#import "XLPeiJianViewController.h"
#import "XLDongTaiViewController.h"
#import "XLFaXianViewController.h"
#import "XLWoDeViewController.h"
#import "LoginViewController.h"
#import "UIColor+Extend.h"
#import "UIImage+Color.h"
#define TAG_HINTDOT 999

@interface XLTabBarController ()
<
    UITabBarControllerDelegate,
    UIActionSheetDelegate,
    UIImagePickerControllerDelegate,
    UIAlertViewDelegate,
    UINavigationControllerDelegate
>
@property (nonatomic, strong) YYAnimatedImageView *itemView;
@property (nonatomic, assign) NSInteger indexFlag;
@property (nonatomic, strong) XLShouYeViewController *homeVC;
@property (nonatomic, strong) XLPeiJianViewController *catagoryVC;
@property (nonatomic, strong) XLDongTaiViewController *communityVC;
@property (nonatomic, strong) XLFaXianViewController *cartVC;
@property (nonatomic, strong) XLWoDeViewController *accountVC;

@end

@implementation XLTabBarController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)sharedInstance {
    static XLTabBarController *instance;
    static dispatch_once_t tabOnceToken;
    dispatch_once(&tabOnceToken, ^{
        instance = [[XLTabBarController alloc] init];
    });
    return instance;
}

+ (void)initialize {
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexColorString:@"666666"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexColorString:@"155bbb"]} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor =  [UIColor whiteColor];
    self.tabBar.translucent = NO; // 设置不半透明
    self.delegate = self;
 
    [self setupControllers];
}

- (void)setupControllers {
    _homeVC = [[XLShouYeViewController alloc] init];
    [self setupChildViewController:_homeVC title:@"首页"
                         imageName:@"tabbar_homeDisable"
                 selectedImageName:@"tabbar_homeEnable"];

    _communityVC = [[XLDongTaiViewController alloc] init];
    [self setupChildViewController:_communityVC
                             title:@"动态"
                         imageName:@"tabbar_topicDisable"
                 selectedImageName:@"tabbar_topicEnable"];

    _accountVC = [[XLWoDeViewController alloc] init];
    [self setupChildViewController:_accountVC title:@"我的"
                         imageName:@"tabbar_mineDisable"
                 selectedImageName:@"tabbar_mineEnable"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc  需要初始化的子控制器
 *  @param title  标题
 *  @param imageName 图标
 *  @param selectedImageName 选中的图标
 *  @最后一步将子控制器包装成导航栏控制器
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    XLNavigationController *nav = [[XLNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
////    NSInteger index = [self.tabBar.items indexOfObject:item];
////    if (self.indexFlag != index) {
////        [self animationWithIndex:index];
////    }
//}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    XLNavigationController *navi = (XLNavigationController *)viewController;
    if ([navi.topViewController isKindOfClass:[XLWoDeViewController class]]) {
        if (![[AccountManager shareInstance] isLogin]) {
            [LoginViewController presentLoginViewController:tabBarController.viewControllers.firstObject complation:^{
                tabBarController.selectedIndex = [tabBarController.viewControllers count] - 1;
            }];
            return NO;
        }
    }
    return YES;
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    
    // 阿语
//    if (![SystemConfigUtils isRightToLeftShow]) {
        // 这里的操作主要让tabar上自定义的view也进行缩放效果和tabbar其他按钮保持一致动画
        if (index  == 2) {
            [[_itemView layer] addAnimation:pulse forKey:nil];
        }
//    }
    
    /*
    //这里的操作主要是防止缩放的时候没被遮住显示底部的文字
    if (index ==  2) {
        return;
    }
     */
    
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
    self.indexFlag = index;
}

//- (void)notificationCenter {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:kCartBadgeNotification object:nil]; // 刷新购物车
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:kLoginNotification object:nil]; // 登录
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:kLogoutNotification object:nil]; // 退出
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOrHiddenAccountDot) name:kChangeAccountDotNotification object:nil]; // 消息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTabbarIcon:) name:kLoadFinishTabbarIconNotification object:nil]; // 下载完成首页气氛消息通知
//}

//- (void)changeValue:(NSNotification *)notify {
//    UITabBarItem * tabBarItem;
//    // 阿语
////    if ([SystemConfigUtils isRightToLeftShow]) {
////        tabBarItem =  [self.viewControllers[2] tabBarItem];
////    } else {
//        tabBarItem =  [self.viewControllers[3] tabBarItem];
////    }
//
//    // 购物车数量
//    NSInteger goodsCount = [[CartOperationManager sharedManager] cartValidGoodsCount];
//    if (goodsCount > 0) {
//        tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)goodsCount];
//    } else {
//        tabBarItem.badgeValue = nil;
//    }
//
//    if ([notify.name isEqualToString:@"kLoginNotification"] || [notify.name isEqualToString:@"kLogoutNotification"]) {
//        [self showOrHiddenAccountDot];
//    }
//}

//- (void)updateTabbarIcon:(NSNotification *)nofi
//{
//    NSDictionary *dict = [nofi userInfo];
//    YSTabbarModel *model = [dict objectForKey:@"model"];
//    YSTabbarManager *manager = [YSTabbarManager sharedInstance];
//    YYImageCache *imageCahce = [YYImageCache sharedCache];
//
//    if (!manager.model.isDownLoadTabbarIcon) {
//        return;
//    }
//
//    NSString *bgUrl = @"";
//    if (manager.type == YSDeviceImageTypeIphoneX || manager.type == YSDeviceImageType3X)
//    {
//        bgUrl = model.body.backgroup_url_3x;
//    }
//    else
//    {
//        bgUrl = model.body.backgroup_url_2x;
//    }
//    UIImage *bgCacheImage = [imageCahce getImageForKey:bgUrl withType:YYImageCacheTypeDisk];
//    if (bgCacheImage) {
//        self.tabBar.backgroundImage = bgCacheImage;
//    }
//
//    NSArray *vcArray = [NSArray arrayWithObjects:_homeVC,_catagoryVC,_communityVC,_cartVC,_accountVC,nil];
//    for (NSInteger i = 0 ;i < model.body.imgs_url_3x.count; i ++) {
//        NSString *normalUrl = @"";
//        NSString *selectedUrl = @"";
//        if (manager.type == YSDeviceImageTypeIphoneX || manager.type == YSDeviceImageType3X )
//        {
//            normalUrl = [model.body.imgs_url_3x objectAtIndex:i];
//            selectedUrl = [model.body.imgs_url_selected_3x objectAtIndex:i];
//        }
//        else
//        {
//            normalUrl = [model.body.imgs_url_2x objectAtIndex:i];
//            selectedUrl = [model.body.imgs_url_selected_2x objectAtIndex:i];
//        }
//        UIViewController *vc = vcArray[i];
//        UIImage *iconImage = [imageCahce getImageForKey:normalUrl withType:YYImageCacheTypeDisk];
//        if (iconImage) {
//            vc.tabBarItem.image = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        }
//        UIImage *selectImage = [imageCahce getImageForKey:selectedUrl withType:YYImageCacheTypeDisk];
//        if (selectImage) {
//            vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        }
//    }
//    UIColor *normalColor = model.body.text_color_normal.length ? [UIColor colorWithHexColorString:model.body.text_color_normal] : YSCOLOR_153_153_153;
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : normalColor} forState:UIControlStateNormal];
//    UIColor *selectColor = model.body.text_color_selected.length ? [UIColor colorWithHexColorString:model.body.text_color_selected] : YSBlACK_COLOR;
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : selectColor} forState:UIControlStateSelected];
//}
@end
