//
//  CustomerWaterFallSectionModule.m
//  TestCollectionView
//
//  Created by 610715 on 2018/5/29.
//  Copyright © 2018年 610715. All rights reserved.
//
#import "CustomerWaterFallSectionModule.h"

#define padding 10
#define bottomPadding 10

@interface CustomerWaterFallSectionModule ()

@property (nonatomic, strong) NSMutableArray *columnHeights;

@end

@implementation CustomerWaterFallSectionModule
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

-(NSArray *)childRowsCalculateFramesWithBottomOffset:(CGFloat)bottomoffset section:(NSInteger)section rows:(NSInteger)rows
{
    NSMutableArray *attributeList = [NSMutableArray arrayWithCapacity:rows];
    
    [self.columnHeights removeAllObjects];
    
    for (int i = 0; i < 2; i++) {
        [self.columnHeights addObject:@(bottomoffset + padding)];
    }
    CGFloat width = ([[UIScreen mainScreen]bounds].size.width - padding*3) / 2;
    for (int i = 0; i < rows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        CGFloat height = arc4random()%150 + 50;
        
        NSUInteger columnIndex = [CustomerMathTools shortestColumnIndex:self.columnHeights];

        CGFloat xOffset = padding + (width + padding) * columnIndex;
        
        CGFloat yOffset = [self.columnHeights[columnIndex] floatValue];
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(xOffset, yOffset, width, height);
        self.columnHeights[columnIndex] = @(CGRectGetMaxY(attributes.frame) + bottomPadding);
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
    NSUInteger columnIndex = [CustomerMathTools longestColumnIndex:self.columnHeights];
    return [self.columnHeights[columnIndex] floatValue];
}

#pragma mark - setter and getter

-(NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [[NSMutableArray alloc] init];
    }
    return _columnHeights;
}

@end
