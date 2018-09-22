//
//  ProductDetailCellModel.m
//  XProject
//
//  Created by MOMO on 2018/9/19.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductDetailCellModel.h"

@implementation ProductDetailCellModel
@synthesize dataSource = _dataSource;
@synthesize specialIdentifier = _specialIdentifier;

-(NSString *)CollectionDatasourceCellIdentifier:(NSIndexPath *)indexPath
{
    return NSStringFromClass([self CollectionDatasourceClass]);
}

-(Class)CollectionDatasourceClass
{
    if (self.specialIdentifier && self.specialIdentifier.length) {
        return NSClassFromString(self.specialIdentifier);
    }
    return ProductDetailNameCell.class;
}

-(CGSize)dataSourceSize
{
    NSString *klassString = NSStringFromClass([self CollectionDatasourceClass]);
    if ([klassString isEqualToString:@"ProductDetailNameCell"]) {
        return CGSizeMake(KScreenWidth, 80);
    }else if ([klassString isEqualToString:@"ProductSKUCell"]){
        return CGSizeMake(KScreenWidth, 44);
    }else if ([klassString isEqualToString:@"ProductSelectNumCell"]){
        return CGSizeMake(KScreenWidth, 44);
    }
    return CGSizeMake(KScreenWidth, 60);
}

-(void)registerCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath specialIdentifier:(NSString *)specialIdentifier
{
    [collectionView registerClass:[self CollectionDatasourceClass] forCellWithReuseIdentifier:[self CollectionDatasourceCellIdentifier:indexPath]];
}

@end
