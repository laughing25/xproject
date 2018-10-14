//
//  YSAsingleViewModule.m
//  YoshopPro
//
//  Created by 610715 on 2018/5/30.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import "YSAsingleViewModule.h"

@interface YSAsingleViewModule ()

@property (nonatomic, assign) CGFloat bottomOffset;

@end

@implementation YSAsingleViewModule
@synthesize minimumInteritemSpacing = _minimumInteritemSpacing;
@synthesize sectionDataList = _sectionDataList;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionDataList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)childRowsCalculateFramesWithBottomOffset:(CGFloat)bottomoffset section:(NSInteger)section
{
    NSMutableArray *attributeList = [NSMutableArray arrayWithCapacity:1];
    
    id<CollectionDatasourceProtocol>cellModel = self.sectionDataList[0];
    
    CGSize customerSize = [cellModel dataSourceSize];
    
    if (CGSizeEqualToSize(CGSizeZero, customerSize)) {
        customerSize = CGSizeMake(KScreenWidth, 160.0 * MIN_PIXEL);
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(0, bottomoffset, customerSize.width, customerSize.height);
    
    self.bottomOffset = CGRectGetMaxY(attributes.frame);
    
    [attributeList addObject:attributes];
    
    return [attributeList copy];
}

-(CGFloat)rowsNumInSection
{
    return [self.sectionDataList count];
}

-(CGFloat)sectionBottom
{
    return self.bottomOffset + self.minimumInteritemSpacing;
}
@end
