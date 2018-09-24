//
//  AccountManager.h
//  XProject
//
//  Created by MOMO on 2018/9/18.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

#define kLoginKey @"kLoginKey"

@interface AccountManager : NSObject

+(instancetype)shareInstance;

-(nullable NSDictionary *)requestParams;

-(nullable NSDictionary *)requestHeaderParams:(NSDictionary *)requestParams;

-(BOOL)isLogin;

@property (nonatomic, strong) AccountModel *accountModel;

@end
