//
//  GainProductListApi.m
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainProductListApi.h"

@interface GainProductListApi ()
@property (nonatomic, copy) NSString *pageIndex;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *categoryid;
@property (nonatomic, copy) NSString *catalogid;
@end

@implementation GainProductListApi
-(instancetype)initWithPageIndex:(NSString *)pageIndex
                      categoryid:(NSString *)categoryid
                       catalogid:(NSString *)catalogid
{
    self = [super init];
    
    if (self) {
        self.pageIndex = pageIndex;
        self.pageSize = @"20";
        self.categoryid = categoryid;
        self.catalogid = catalogid;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/product/getproductlist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"pageindex": self.pageIndex,
             @"pagesize": self.pageSize,
             @"catalogid": self.catalogid,
             @"categoryid": self.categoryid
             };
}

@end
