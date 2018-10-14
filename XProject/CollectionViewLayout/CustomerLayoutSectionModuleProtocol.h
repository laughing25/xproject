//
//  CustomerLayoutSectionModuleProtocol.h
//  TestCollectionView
//
//  Created by 610715 on 2018/5/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomerMathTools.h"
#import "CollectionDatasourceProtocol.h"

static NSString * const CustomerLayoutHeader = @"CustomerLayoutHeader";
static NSString * const CustomerLayoutFooter = @"CustomerLayoutFooter";

///布局底部对齐方式
typedef NS_ENUM(NSInteger) {
    AlignBottom_Horizontal,
    AlignBottom_Waterfail
}AlignBottom;

@protocol CustomerLayoutSectionModuleProtocol <NSObject>

///section 的底部最小间距
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

///数据源
@property (nonatomic, strong) NSMutableArray <id<CollectionDatasourceProtocol>>*sectionDataList;

@optional;

-(UICollectionViewLayoutAttributes *)headerFooterKind:(NSString *)kind bottomOffset:(CGFloat)bottomOffset section:(NSUInteger)section;

-(NSArray *)childRowsCalculateFramesWithBottomOffset:(CGFloat)bottomoffset section:(NSInteger)section;

-(CGFloat)rowsNumInSection;

-(CGFloat)sectionBottom;


@end
