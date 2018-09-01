//
//  ZFBaseViewController.h
//  Dezzal
//
//  Created by 7FD75 on 16/7/21.
//  Copyright © 2016年 7FD75. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFBaseViewController : UIViewController

/**
 *  此方法是为了防止控制器的title发生偏移，造成这样的原因是因为返回按钮的文字描述占位
 */
- (void)setBackButtomTitleToEmpty;

/**
 * 添加一个占位的返回按钮
 */
- (void)bringTempBackButtonToFront;

/**
 * 返回上个控制器
 */
- (void)popBackVC;

@property (nonatomic, assign) BOOL firstEnter;

@end
