//
//  YSAsingleViewModule.h
//  YoshopPro
//
//  Created by 610715 on 2018/5/30.
//  Copyright © 2018年 yoshop. All rights reserved.
//  简单完整一行的视图计算模块,宽度为屏幕宽度,高度自定义, 默认高度 160.0 * DSCREEN_WIDTH_SCALE

#import "CustomerLayoutSectionModuleProtocol.h"
#import "CollectionDatasourceProtocol.h"

@interface YSAsingleViewModule : NSObject
<
    CustomerLayoutSectionModuleProtocol
>
@end
