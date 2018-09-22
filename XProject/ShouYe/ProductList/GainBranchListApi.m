//
//  GainBranchListApi.m
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainBranchListApi.h"

@implementation GainBranchListApi


- (NSString *)requestUrl {
    return @"api/brand/getbrandlist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{};
}
@end
