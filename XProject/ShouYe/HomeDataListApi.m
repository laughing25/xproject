//
//  HomeDataListApi.m
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "HomeDataListApi.h"

@interface HomeDataListApi ()
@property (nonatomic, copy) NSString *pageIndex;
@property (nonatomic, copy) NSString *pageSize;
@end

@implementation HomeDataListApi

-(instancetype)initWithPageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
    self = [super init];
    
    if (self) {
        self.pageSize = pageSize;
        self.pageIndex = pageIndex;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/ad/getdalist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"pageindex": self.pageIndex,
             @"pagesize": self.pageSize
             };
}

//-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
//{
//    NSDictionary *params = [[AccountManager shareInstance] requestHeaderParams:[self requestArgument]];
//    return [params copy];
//}

@end
