//
//  ProductDetailCellModel.m
//  XProject
//
//  Created by MOMO on 2018/9/19.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductDetailCellModel.h"
#import "ProductModel.h"

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
        ProductModel *model = (ProductModel *)self.dataSource;
        if (model.productName) {
            CGFloat height = [model.productName boundingRectWithSize:CGSizeMake(KScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[self sizeAttributes] context:nil].size.height + 10 + 10 + 10;
            return CGSizeMake(KScreenWidth, height);
        }
        return CGSizeMake(KScreenWidth, 50);
    }else if ([klassString isEqualToString:@"ProductSKUCell"]){
        return CGSizeMake(KScreenWidth, 44);
    }else if ([klassString isEqualToString:@"ProductSelectNumCell"]){
        return CGSizeMake(KScreenWidth, 44);
    }else if ([klassString isEqualToString:@"WebViewCollectionViewCell"]){
        if (CGSizeEqualToSize(self.modelSize, CGSizeZero)) {
            return CGSizeMake(KScreenWidth, 80);
        }
        return self.modelSize;
    } else if ([klassString isEqualToString:@"ProductRemarksCell"]) {
        return CGSizeMake(KScreenWidth, 45);
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
                             NSFontAttributeName : [UIFont systemFontOfSize:14]
                             };
    return params;
}

@end
