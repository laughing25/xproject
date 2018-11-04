//
//  ProductDetailBottomView.h
//  XProject
//
//  Created by MOMO on 2018/9/23.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

typedef void(^buyNowBlock)(void);
@interface ProductDetailBottomView : UIView

@property (nonatomic, copy) buyNowBlock buyBlock;
@property (nonatomic, strong) ProductModel *model;

- (void)reloadPrice:(NSArray<ProductAttrItemModel*>*)list;

@end
