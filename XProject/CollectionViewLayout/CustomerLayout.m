//
//  CustomerLayout.m
//  TestCollectionView
//
//  Created by 610715 on 2018/5/26.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "CustomerLayout.h"

@interface CustomerLayout ()

///按分区存放的attributes
@property (nonatomic, strong) NSMutableArray *attributesList;

///所有的attributes
@property (nonatomic, strong) NSMutableArray *allAttributesItemList;

///存储每个section最终bottom
@property (nonatomic, strong) NSMutableArray *columnHeights;

///需要显示在屏幕上的
@property (nonatomic, strong) NSMutableArray *visibleItems;

@property (nonatomic, strong) NSMutableDictionary *headerSectionHeight;
@property (nonatomic, strong) NSMutableDictionary *footerSectionHeight;
@end

@implementation CustomerLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    [self.attributesList removeAllObjects];
    [self.allAttributesItemList removeAllObjects];
    [self.columnHeights removeAllObjects];
    [self.visibleItems removeAllObjects];
    [self.headerSectionHeight removeAllObjects];
    [self.footerSectionHeight removeAllObjects];
    
    NSInteger sections = [self.collectionView numberOfSections];

    if (self.dataSource && [self.dataSource respondsToSelector:@selector(customerLayoutDatasource:sectionNum:)]) {
        for (int i = 0; i < sections; i++) {
            
            id <CustomerLayoutSectionModuleProtocol> sectionModule = [self.dataSource customerLayoutDatasource:self.collectionView sectionNum:i];

            CGFloat sectionHeight = 0;
            NSMutableArray *sectionAttributes = [[NSMutableArray alloc] init];
            if ([self.dataSource respondsToSelector:@selector(customerLayoutSectionHeight:layout:indexPath:)]) {
                sectionHeight = [self.dataSource customerLayoutSectionHeight:self.collectionView layout:self indexPath:[NSIndexPath indexPathForRow:0 inSection:sections]];
                if (sectionHeight) {
                    //section header
                    UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:CustomerLayoutHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
                    CGFloat lastSectionHeight = [[self.columnHeights lastObject] floatValue];
                    headerAttributes.frame = CGRectMake(0, lastSectionHeight, self.collectionView.frame.size.width, sectionHeight);
                    [self.allAttributesItemList addObject:headerAttributes];
                    self.headerSectionHeight[@(i)] = @(sectionHeight);
                }
            }
            
            NSInteger rows = [self.collectionView numberOfItemsInSection:i];
            
            //获取上一个section的bottom
            CGFloat lastSectionHeight = MAX(sectionHeight, [[self.columnHeights lastObject] floatValue]);
            
            NSArray *sectionAttributelist = [sectionModule childRowsCalculateFramesWithBottomOffset:lastSectionHeight section:i rows:rows];
            [sectionAttributes addObjectsFromArray:sectionAttributelist];
            
            self.columnHeights[i] = @([sectionModule sectionBottom]);
            [self.attributesList addObject:sectionAttributes];
            [self.allAttributesItemList addObjectsFromArray:sectionAttributes];
        }
    }
    
    NSInteger idx = 0;
    NSInteger itemCounts = [self.allAttributesItemList count];
    while (idx < itemCounts) {
        CGRect rect1 = ((UICollectionViewLayoutAttributes *)self.allAttributesItemList[idx]).frame;
        idx = MIN(idx + 20, itemCounts) - 1;
        CGRect rect2 = ((UICollectionViewLayoutAttributes *)self.allAttributesItemList[idx]).frame;
        [self.visibleItems addObject:[NSValue valueWithCGRect:CGRectUnion(rect1, rect2)]];
        idx++;
    }
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSInteger i;
    NSInteger begin = 0, end = self.visibleItems.count;
    NSMutableArray *attrs = [NSMutableArray array];
    
    for (i = 0; i < self.visibleItems.count; i++) {
        if (CGRectIntersectsRect(rect, [self.visibleItems[i] CGRectValue])) {
            begin = i * 20;
            break;
        }
    }
    for (i = self.visibleItems.count - 1; i >= 0; i--) {
        if (CGRectIntersectsRect(rect, [self.visibleItems[i] CGRectValue])) {
            end = MIN((i + 1) * 20, self.allAttributesItemList.count);
            break;
        }
    }
    for (i = begin; i < end; i++) {
        UICollectionViewLayoutAttributes *attr = self.allAttributesItemList[i];
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }
    
    return [NSArray arrayWithArray:attrs];
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= [self.attributesList count]) {
        return nil;
    }
    if (indexPath.item >= [self.attributesList[indexPath.section] count]) {
        return nil;
    }
    UICollectionViewLayoutAttributes *attributes = self.attributesList[indexPath.section][indexPath.item];
    return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = nil;
    if ([elementKind isEqualToString:CustomerLayoutHeader]) {
        attributes = self.headerSectionHeight[@(indexPath.section)];
    }
    if ([elementKind isEqualToString:CustomerLayoutFooter]) {
        attributes = self.footerSectionHeight[@(indexPath.section)];
    }
    return attributes;
}

// 返回collectionView的ContentSize
- (CGSize)collectionViewContentSize
{
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.bounds.size;
    contentSize.height = [[self.columnHeights lastObject] floatValue];
    
    if ([self.dataSource respondsToSelector:@selector(customerLayoutContentSizeHeight:)]) {
        [self.dataSource customerLayoutContentSizeHeight:contentSize.height];
    }
    
    return contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds) ||
        CGRectGetHeight(newBounds) != CGRectGetHeight(oldBounds)) {
        return YES;
    }
    return NO;
}

-(CGFloat)maxContentOffsetY
{
    CGFloat height = [[self.columnHeights lastObject] floatValue];
    return height;
}


-(NSMutableArray *)attributesList
{
    if (!_attributesList) {
        _attributesList = [[NSMutableArray alloc] init];
    }
    return _attributesList;
}

-(NSMutableArray *)allAttributesItemList
{
    if (!_allAttributesItemList) {
        _allAttributesItemList = [[NSMutableArray alloc] init];
    }
    return _allAttributesItemList;
}

-(NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [[NSMutableArray alloc] init];
    }
    return _columnHeights;
}

-(NSMutableArray *)visibleItems
{
    if (!_visibleItems) {
        _visibleItems = [[NSMutableArray alloc] init];
    }
    return _visibleItems;
}

-(NSMutableDictionary *)headerSectionHeight
{
    if (!_headerSectionHeight) {
        _headerSectionHeight = [[NSMutableDictionary alloc] init];
    }
    return _headerSectionHeight;
}

-(NSMutableDictionary *)footerSectionHeight
{
    if (!_footerSectionHeight) {
        _footerSectionHeight = [[NSMutableDictionary alloc] init];
    }
    return _footerSectionHeight;
}

@end