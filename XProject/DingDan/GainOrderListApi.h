//
//  GainOrderListApi.h
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//  获取订单列表信息

#import <YTKNetwork/YTKNetwork.h>

@interface GainOrderListApi : YTKRequest

-(instancetype)initWithOrderNum:(NSString *)orderNum;

@end
