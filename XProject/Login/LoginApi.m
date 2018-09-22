//
//  LoginApi.m
//  XProject
//
//  Created by MOMO on 2018/9/18.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "LoginApi.h"

@interface LoginApi ()

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@implementation LoginApi

-(instancetype)initWithlogin:(NSString *)userName password:(NSString *)password
{
    self = [super init];
    if (self) {
        self.username = userName;
        self.password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/user/login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"username": _username,
             @"pass": _password
             };
}

//-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
//{
//    NSDictionary *params = [[AccountManager shareInstance] requestHeaderParams:[self requestArgument]];
//    return [params copy];
//}

@end
