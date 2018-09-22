//
//  GainProductListApi.h
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//  获取商品列表api

#import <YTKNetwork/YTKNetwork.h>

@interface GainProductListApi : YTKRequest

-(instancetype)initWithPageIndex:(NSString *)pageIndex
                      categoryid:(NSString *)categoryid
                       catalogid:(NSString *)catalogid;

@end
