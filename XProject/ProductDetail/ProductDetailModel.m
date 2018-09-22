//
//  ProductDetailModel.m
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"descriptions":@"description",
             @"productId":@"id"
             };
}

@end
