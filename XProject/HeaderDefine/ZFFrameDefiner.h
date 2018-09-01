//
//  ZFFrameDefiner.h
//  Zaful
//
//  Created by maowangxin on 2018/3/30.
//  Copyright © 2018年 Y001. All rights reserved.
//

#ifndef ZFFrameDefiner_h
#define ZFFrameDefiner_h

#pragma mark -===========================屏幕分辨率大小=============================
// 屏幕大小
#define KScale                          [UIScreen mainScreen].scale
#define MIN_PIXEL                       (1.0 / KScale)
#define KScreenWidth                    [UIScreen mainScreen].bounds.size.width
#define KScreenHeight                   [UIScreen mainScreen].bounds.size.height
#define ScreenHeight_SCALE              (KScreenHeight / 568.0)
#define ScreenWidth_SCALE               (KScreenWidth / 375.0)

#define KImage_SCALE                    0.75
#define KImageFadeDuration              0.5

#define IPHONE_4X_3_5                   (KScreenHeight==480.0f)
#define IPHONE_5X_4_0                   (KScreenHeight==568.0f)
#define IPHONE_6X_4_7                   (KScreenHeight==667.0f)
#define IPHONE_6P_5_5                   (KScreenHeight==736.0f || KScreenWidth==414.0f)
#define IPHONE_7P_5_5                   (KScreenHeight==736.0f)
#define IPHONE_X_5_15                   (KScreenWidth == 375.0f && KScreenHeight == 812.0f)

#define NAVBARHEIGHT                    self.navigationController.navigationBar.frame.size.height
#define STATUSHEIGHT                    [UIApplication sharedApplication].statusBarFrame.size.height
#define TabBarHeight                    self.tabBarController.tabBar.bounds.size.height
/** 判断iphoneX 底部间距*/
#define kiphoneXHomeBarHeight            (IPHONE_X_5_15 ? 34 : 0)
/** <#name#> */
#define kiphoneXHomeBarHeight1           (IPHONE_X_5_15 ? 110 : 0)
/** 判断iphoneX 顶部间距*/
#define kiphoneXTopOffsetY              (IPHONE_X_5_15 ? 44.0f : 20.0f)

#define NavBarButtonSize                (36.0)


#define EmptyViewTag                    8870


#endif /* ZFFrameDefiner_h */
