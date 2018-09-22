//
//  GainProductDetailApi.h
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GainProductDetailApi : YTKRequest

-(instancetype)initWithProductId:(NSString *)productId;

@end
