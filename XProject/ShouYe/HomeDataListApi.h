//
//  HomeDataListApi.h
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//  首页数据api

#import <YTKNetwork/YTKNetwork.h>

@interface HomeDataListApi : YTKRequest

-(instancetype)initWithPageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize;

@end
