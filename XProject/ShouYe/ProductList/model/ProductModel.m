//
//  ProductModel.m
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"descriptions":@"description",
             @"productId":@"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"productattrlist" : [ProductAttrModel class]
             };
}

@end


@implementation ProductAttrModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ProductAttrItemModel class]
             };
}

@end


@implementation ProductAttrItemModel


@end
