//
//  ProductDetailSkuModule.m
//  XProject
//
//  Created by laughing on 2018/11/1.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductDetailSkuModule.h"

#define padding 10
#define bottomPadding 10

@interface ProductDetailSkuModule ()

@property (nonatomic, assign) CGFloat bottomOffset;

@end

@implementation ProductDetailSkuModule
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
    NSInteger rows = [self.sectionDataList count];
    NSMutableArray *attributeList = [NSMutableArray arrayWithCapacity:rows];

    CGFloat screenWidth = KScreenWidth;
    
    BOOL isWarp = NO;
    CGFloat warpMaxWidth = 0;
    int warpIndex = 0;
    
    for (int i = 0; i < rows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        
        id<CollectionDatasourceProtocol>model = self.sectionDataList[i];
        
        CGSize customerSize = [model dataSourceSize];
        
        if (CGSizeEqualToSize(customerSize, CGSizeZero)) {
            customerSize = CGSizeMake(screenWidth / 3, 50);
        }
        
        CGFloat xOffset = padding;
        CGFloat yOffset = padding + bottomoffset;
        CGFloat width = customerSize.width;
        CGFloat height = customerSize.height;
        warpIndex ++;
        
        if (i > 0) {
            UICollectionViewLayoutAttributes *lastAttributes = attributeList[i - 1];
            yOffset = lastAttributes.frame.origin.y;

            warpMaxWidth += ceilf(CGRectGetMaxX(lastAttributes.frame));
            
            CGFloat maxWidth = warpMaxWidth + ceilf(width) + (padding * warpIndex);
            
            if (maxWidth > screenWidth) {
                isWarp = YES;
                warpMaxWidth = 0;
                warpIndex = 0;
            }
            
            xOffset = padding + warpMaxWidth;
            
            if (isWarp) {
                yOffset = CGRectGetMaxY(lastAttributes.frame) + bottomPadding;
                isWarp = NO;
            }
        }
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(xOffset, yOffset, width, height);
        [attributeList addObject:attributes];
        self.bottomOffset = CGRectGetMaxY(attributes.frame);
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

