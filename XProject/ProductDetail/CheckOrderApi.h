//
//  CheckOrderApi.h
//  XProject
//
//  Created by MOMO on 2018/9/26.
//  Copyright © 2018年 610715. All rights reserved.
//  下单接口

#import <YTKNetwork/YTKNetwork.h>

@interface CheckOrderApi : YTKRequest

-(instancetype)initWithProductId:(NSArray *)productparams remarkes:(NSString *)remark;

@end
