//
//  YSEquilateralSquareViewModule.m
//  YoshopPro
//
//  Created by 610715 on 2018/5/30.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import "YSEquilateralSquareViewModule.h"

@interface YSEquilateralSquareViewModule ()

@property (nonatomic, assign) CGFloat bottomOffset;

@end

@implementation YSEquilateralSquareViewModule
@synthesize minimumInteritemSpacing = _minimumInteritemSpacing;
@synthesize sectionDataList = _sectionDataList;

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.sectionDataList = [[NSMutableArray alloc] init];
        self.customerColumn = 4;
    }
    return self;
}

-(NSArray *)childRowsCalculateFramesWithBottomOffset:(CGFloat)bottomoffset section:(NSInteger)section
{
    NSInteger rows = [self rowsNumInSection];
    
    NSMutableArray *attributeList = [NSMutableArray arrayWithCapacity:rows];

    CGFloat screenWidth = KScreenWidth;
    CGFloat width = screenWidth / self.customerColumn;
    
    BOOL rightToLeft = YES;
    
    //总行数
    int tempRow = 0;
    for (int i = 0; i < rows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        id<CollectionDatasourceProtocol>cellModel = self.sectionDataList[i];
        CGFloat height = [cellModel dataSourceSize].height;
        if (i % self.customerColumn == 0) {
            tempRow++;
        }
        float x = 0.0;
        if (tempRow * self.customerColumn <= rows) {
            NSInteger tempRowCount = rows <= self.customerColumn ? rows : self.customerColumn;
            x = screenWidth / 2.0 - (tempRowCount / 2.0 * width) + i % tempRowCount * width;
        }else{
            NSInteger tempRowCount = self.customerColumn - (tempRow * self.customerColumn - rows);
            x = screenWidth / 2.0 - (tempRowCount / 2.0 * width) + i % tempRowCount * width;
        }
        if (rightToLeft) {
            x = screenWidth - x - width;
        }
        attributes.frame = CGRectMake(x, (i / self.customerColumn) * height + bottomoffset, width, height);

        self.bottomOffset = CGRectGetMaxY(attributes.frame);
        [attributeList addObject:attributes];
    }
    
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
