//
//  ZFBottomToolView.h
//  Zaful
//
//  Created by liuxi on 2017/8/29.
//  Copyright © 2017年 Y001. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZFBottomButtonBlock)(void);

@interface ZFBottomToolView : UIView
@property (nonatomic, assign) BOOL                  showTopShadowline;
@property (nonatomic, strong) NSString              *bottomTitle;
@property (nonatomic, copy) ZFBottomButtonBlock     bottomButtonBlock;
@end
