//
//  ChangePasswordApi.h
//  XProject
//
//  Created by MOMO on 2018/9/29.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface ChangePasswordApi : YTKRequest

- (instancetype)initWithPassword:(NSString *)password;

@end
