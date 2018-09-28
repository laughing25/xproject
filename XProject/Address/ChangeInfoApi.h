//
//  ChangeInfoApi.h
//  XProject
//
//  Created by MOMO on 2018/9/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "XLAddressDetailInfoModel.h"

@interface ChangeInfoApi : YTKRequest

- (instancetype)initWithModel:(XLAddressDetailInfoModel *)model;

@end
