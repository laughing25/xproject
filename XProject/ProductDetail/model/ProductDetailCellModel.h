//
//  ProductDetailCellModel.h
//  XProject
//
//  Created by MOMO on 2018/9/19.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionDatasourceProtocol.h"
#import "ProductDetailNameCell.h"
#import "ProductSKUCell.h"
#import "ProductSelectNumCell.h"

@interface ProductDetailCellModel : NSObject
<
    CollectionDatasourceProtocol
>

@property (nonatomic, assign) CGSize modelSize;
@property (nonatomic, assign) BOOL isReload;

@end
