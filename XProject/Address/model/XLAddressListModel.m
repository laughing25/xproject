//
//  XLAddressListModel.m
//  XProject
//
//  Created by MOMO on 2018/9/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLAddressListModel.h"

@implementation XLAddressListModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"cityId" : @"id"
             };
}

@end
