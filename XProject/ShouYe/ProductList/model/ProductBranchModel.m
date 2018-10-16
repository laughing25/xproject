//
//  ProductBranchModel.m
//  XProject
//
//  Created by laughing on 2018/10/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductBranchModel.h"

@implementation ProductBranchModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"pid":@"id"
             };
}

@end
