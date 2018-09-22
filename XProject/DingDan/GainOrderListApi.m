//
//  GainOrderListApi.m
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainOrderListApi.h"

@interface GainOrderListApi ()
@property (nonatomic, copy) NSString *orderNum;
@end

@implementation GainOrderListApi
-(instancetype)initWithOrderNum:(NSString *)orderNum;
{
    self = [super init];
    if (self) {
        self.orderNum = orderNum;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/order/getorderlist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid": @"38",//[AccountManager shareInstance].accountModel.userId,
             @"orderno": _orderNum
             };
}

//-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
//{
//    NSDictionary *params = [[AccountManager shareInstance] requestHeaderParams:[self requestArgument]];
//    return [params copy];
//    return @{@"Content-Type" : @"application/json; charset=utf-8"};
//}

@end
