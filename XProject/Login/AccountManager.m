//
//  AccountManager.m
//  XProject
//
//  Created by MOMO on 2018/9/18.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static AccountManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[AccountManager alloc] init];
    });
    return manager;
}

-(nullable NSDictionary *)requestParams
{
    NSString *time = [NSStringUtils getCurrentMSimestamp];
    NSString *nonce = [NSString stringWithFormat:@"%ld", arc4random()%time.integerValue];
    NSString *appid = @"10000";
    return @{@"appid" : appid,
             @"timestamp" : time,
             @"nonce" : nonce,
             @"signture" : [NSString stringWithFormat:@"%@%@%@", time, nonce, appid]
             };
}

-(nullable NSDictionary *)requestHeaderParams:(NSDictionary *)requestParams
{
    NSMutableDictionary *mutRequestParams = [requestParams mutableCopy];
    NSMutableDictionary *publicParams = [[self requestParams] mutableCopy];
    NSString *signture = [publicParams objectForKey:@"signture"];
    NSString *sortString = [signture stringByAppendingString:[mutRequestParams yy_modelToJSONString]];
    sortString = [NSStringUtils sortAndCompress:sortString];
    NSString *signature = [NSStringUtils ZFNSStringMD5:sortString];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    
    [publicParams removeObjectForKey:@"signture"];
    [headerParams addEntriesFromDictionary:[publicParams copy]];
    [headerParams setObject:signature forKey:@"signture"];
    return [headerParams copy];
}

-(void)setAccountModel:(AccountModel *)accountModel
{
    _accountModel = accountModel;
    
    [[NSUserDefaults standardUserDefaults] setObject:accountModel.user_name forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setObject:accountModel.password forKey:kPassword];
}

-(NSString *)oldPassword
{
    NSString *pw = @"";
    pw = [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
    return ZFToString(pw);
}

-(NSString *)oldUserId
{
    NSString *un = @"";
    un = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    return ZFToString(un);
}

-(BOOL)isLogin
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    if (ZFToString(userName).length) {
        return YES;
    }
    return NO;
}

-(void)loginOut
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUserName];
}

@end
