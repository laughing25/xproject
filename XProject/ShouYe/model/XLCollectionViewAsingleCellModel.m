//
//  XLCollectionViewAsingleCellModel.m
//  XProject
//
//  Created by 610715 on 2018/9/4.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLCollectionViewAsingleCellModel.h"

@implementation XLCollectionViewAsingleCellModel
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
    return YSAsingleCollectionViewCell.class;
}

-(CGSize)dataSourceSize
{
    NSString *klassString = NSStringFromClass([self CollectionDatasourceClass]);
    if ([klassString isEqualToString:@"YSAsingleCollectionViewCell"]) {
        return CGSizeMake(KScreenWidth, 180);
    }else if ([klassString isEqualToString:@"XLTitleCollectionViewCell"]){
        return CGSizeMake(KScreenWidth, 44);
    }else if ([klassString isEqualToString:@"YSTopicCollectionViewCell"]){
        ///传0,在module里面做了特殊的运算
        return CGSizeMake(0, 80);
    }else if ([klassString isEqualToString:@"XLHeaderCollectionViewCell"]){
        return CGSizeMake(KScreenWidth, 44);
    }
    return CGSizeMake(KScreenWidth, 60);
}

-(void)registerCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath specialIdentifier:(NSString *)specialIdentifier
{
    [collectionView registerClass:[self CollectionDatasourceClass] forCellWithReuseIdentifier:[self CollectionDatasourceCellIdentifier:indexPath]];
}

@end
