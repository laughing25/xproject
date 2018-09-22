//
//  GainCategoryListApi.m
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainCategoryListApi.h"

@implementation GainCategoryListApi

- (NSString *)requestUrl {
    return @"api/category/getcategorylist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             
             };
}

@end
