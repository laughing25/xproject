//
//  XLAddressDetailInfoModel.m
//  XProject
//
//  Created by MOMO on 2018/9/24.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLAddressDetailInfoModel.h"

@implementation XLAddressDetailInfoModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"userId" : @"id"
             };
}

@end
