//
//  AccountModel.m
//  XProject
//
//  Created by MOMO on 2018/9/18.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "AccountModel.h"
#import <YYModel/NSObject+YYModel.h>

@implementation AccountModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"userId":@"id"};
}


@end
