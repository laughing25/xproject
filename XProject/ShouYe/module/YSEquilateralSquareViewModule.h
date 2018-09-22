//
//  YSEquilateralSquareViewModule.h
//  YoshopPro
//
//  Created by 610715 on 2018/5/30.
//  Copyright © 2018年 yoshop. All rights reserved.
//  等分正方形视图布局类

#import "CustomerLayoutSectionModuleProtocol.h"

@interface YSEquilateralSquareViewModule : NSObject
<
    CustomerLayoutSectionModuleProtocol
>

/**
 *  自定义列
 *  默认 = 4
 */
@property (nonatomic, assign) NSInteger customerColumn;

@end
