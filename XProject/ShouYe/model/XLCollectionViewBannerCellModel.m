//
//  XLCollectionViewBannerCellModel.m
//  XProject
//
//  Created by 610715 on 2018/9/3.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLCollectionViewBannerCellModel.h"

@implementation XLCollectionViewBannerCellModel
@synthesize dataSource = _dataSource;
@synthesize specialIdentifier = _specialIdentifier;

-(NSString *)CollectionDatasourceCellIdentifier:(NSIndexPath *)indexPath
{
    return [YSCollectionViewBannerCell cellIdentifierl];
}

-(Class)CollectionDatasourceClass
{
    return YSCollectionViewBannerCell.class;
}

-(CGSize)dataSourceSize
{
    if ([NSStringFromClass(self.dataSource.class) isEqualToString:@"ProductModel"]) {
        return CGSizeMake(KScreenWidth, KScreenWidth);
    }
    return CGSizeMake(KScreenWidth, 160.0 * DSCREEN_WIDTH_SCALE);
}

-(void)registerCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath specialIdentifier:(NSString *)specialIdentifier
{
    NSString *identifier = [self CollectionDatasourceCellIdentifier:indexPath];
    if (specialIdentifier && specialIdentifier.length) {
        identifier = [identifier stringByAppendingString:specialIdentifier];
    }
    [collectionView registerClass:[self CollectionDatasourceClass] forCellWithReuseIdentifier:[self CollectionDatasourceCellIdentifier:indexPath]];
}

@end
