//
//  ProductDetailSkuCellModel.m
//  XProject
//
//  Created by laughing on 2018/11/1.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductDetailSkuCellModel.h"

@implementation ProductDetailSkuCellModel
@synthesize dataSource = _dataSource;
@synthesize specialIdentifier = _specialIdentifier;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nameFont = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(NSString *)CollectionDatasourceCellIdentifier:(NSIndexPath *)indexPath
{
    return NSStringFromClass([self CollectionDatasourceClass]);
}

-(Class)CollectionDatasourceClass
{
    if (self.specialIdentifier && self.specialIdentifier.length) {
        return NSClassFromString(self.specialIdentifier);
    }
    return ProductSkuCollectionViewCell.class;
}

-(CGSize)dataSourceSize
{
    if (self.skuName) {
        CGFloat height = 35;
        CGFloat width = [self.skuName boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[self sizeAttributes] context:nil].size.width + 10 + 10;
        return CGSizeMake(width, height);
    }
    return CGSizeMake(KScreenWidth, 60);
}

-(void)registerCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath specialIdentifier:(NSString *)specialIdentifier
{
    [collectionView registerClass:[self CollectionDatasourceClass] forCellWithReuseIdentifier:[self CollectionDatasourceCellIdentifier:indexPath]];
}

- (NSDictionary *)sizeAttributes
{
    NSDictionary *params = @{
                             NSFontAttributeName : self.nameFont
                             };
    return params;
}

@end
