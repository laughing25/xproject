//
//  CheckOrderApi.m
//  XProject
//
//  Created by MOMO on 2018/9/26.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "CheckOrderApi.h"

@interface CheckOrderApi ()

@property (nonatomic, strong) NSArray *params;

@end

@implementation CheckOrderApi

-(instancetype)initWithProductId:(NSArray *)productparams
{
    self = [super init];
    
    if (self) {
        self.params = productparams;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/setorder/do";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid": [AccountManager shareInstance].accountModel.userId,
             @"productlist" : [self.params yy_modelToJSONString],
             @"order_amount" : @"150"
             };
}

@end
