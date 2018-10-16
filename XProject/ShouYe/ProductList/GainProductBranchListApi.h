//
//  GainProductBranchListApi.h
//  XProject
//
//  Created by laughing on 2018/10/16.
//  Copyright © 2018年 610715. All rights reserved.
//  获取产品品牌列表

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface GainProductBranchListApi : YTKRequest

-(instancetype)initWithPid:(NSString *)pid;

@end

NS_ASSUME_NONNULL_END
