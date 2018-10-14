//
//  ChangePasswordApi.m
//  XProject
//
//  Created by MOMO on 2018/9/29.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ChangePasswordApi.h"

@interface ChangePasswordApi ()

@property (nonatomic, copy) NSString *password;

@end

@implementation ChangePasswordApi

- (instancetype)initWithPassword:(NSString *)password
{
    self = [super init];
    
    if (self) {
        self.password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/changepass/do";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid" : ZFToString([AccountManager shareInstance].accountModel.userId),
             @"newpass" : ZFToString(self.password)
             };
}

@end
