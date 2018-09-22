//
//  LoginApi.h
//  XProject
//
//  Created by MOMO on 2018/9/18.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface LoginApi : YTKRequest

-(instancetype)initWithlogin:(NSString *)userName password:(NSString *)password;

@end
