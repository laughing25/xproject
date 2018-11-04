//
//  GainProductDetailApi.m
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainProductDetailApi.h"

@interface GainProductDetailApi()

@property (nonatomic, copy) NSString *productId;

@end

@implementation GainProductDetailApi

-(instancetype)initWithProductId:(NSString *)productId
{
    self = [super init];
    
    if (self) {
        self.productId = productId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/ProductInfo/getinfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"categoryId": self.productId
             };
}

@end
