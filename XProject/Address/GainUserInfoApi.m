//
//  GainUserInfoApi.m
//  XProject
//
//  Created by MOMO on 2018/9/24.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainUserInfoApi.h"

@implementation GainUserInfoApi

- (NSString *)requestUrl {
    return @"api/getuserinfo/do";
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
