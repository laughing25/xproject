//
//  GainAddressListApi.m
//  XProject
//
//  Created by MOMO on 2018/9/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainAddressListApi.h"

@implementation GainAddressListApi

- (NSString *)requestUrl {
    return @"api/address/getaddresslist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid" : ZFToString([AccountManager shareInstance].accountModel.userId)
             };
}

@end
