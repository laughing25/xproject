//
//  YSCustomerThemeMultipleModule.m
//  YoshopPro
//
//  Created by 610715 on 2018/6/8.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import "YSCustomerThemeMultipleModule.h"

@interface YSCustomerThemeMultipleModule ()

@property (nonatomic, assign) CGFloat bottomOffset;

@end

@implementation YSCustomerThemeMultipleModule
@synthesize minimumInteritemSpacing = _minimumInteritemSpacing;
@synthesize sectionDataList = _sectionDataList;

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.sectionDataList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)childRowsCalculateFramesWithBottomOffset:(CGFloat)bottomoffset section:(NSInteger)section
{
    NSInteger rows = [self rowsNumInSection];
    
    NSMutableArray *attributeList = [NSMutableArray arrayWithCapacity:rows];
    
    CGFloat width = 0.0;
    CGFloat height = 0.0;
    CGFloat screenWidth = KScreenWidth;
    
    for (int i = 0; i < rows; i++) {
        id<CollectionDatasourceProtocol>cellmodel = self.sectionDataList[i];
        CGSize size = [cellmodel dataSourceSize];
        width = width + size.width;
        height = size.height;
    }
    
    CGFloat widhtHeightScale = screenWidth / width;
    CGFloat heightScale = height * widhtHeightScale;
    
    BOOL rightToLeft = YES;
    
    CGFloat totalWidth = 0.0;
    for (int i = 0; i < rows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        id<CollectionDatasourceProtocol>cellmodel = self.sectionDataList[i];
        CGSize size = [cellmodel dataSourceSize];
        
        CGFloat reallyWidth = (size.width / width) * screenWidth;
        if (i == rows - 1 && rows > 1) {
            reallyWidth = screenWidth - totalWidth;
        }
        totalWidth += reallyWidth;
        CGFloat reallyHeight = heightScale;
        
        CGFloat x = 0.0;
        if (i == 0) {
            x = 0;
            if (rightToLeft) {
                x = screenWidth - reallyWidth;
            }
        }else{
            UICollectionViewLayoutAttributes *lastattributes = attributeList[i - 1];
            x = CGRectGetMaxX(lastattributes.frame);
            if (rightToLeft) {
                x = screenWidth - totalWidth;
            }
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(x, bottomoffset, reallyWidth, floorf(reallyHeight));
        self.bottomOffset = floorf(CGRectGetMaxY(attributes.frame));
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
