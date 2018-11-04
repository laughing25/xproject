//
//  ProductDetailSkuCellModel.h
//  XProject
//
//  Created by laughing on 2018/11/1.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionDatasourceProtocol.h"
#import "ProductSkuCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailSkuCellModel : NSObject
<
    CollectionDatasourceProtocol
>

@property (nonatomic, copy) NSString *skuName;
@property (nonatomic, strong) UIFont *nameFont;
@property (nonatomic, assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
