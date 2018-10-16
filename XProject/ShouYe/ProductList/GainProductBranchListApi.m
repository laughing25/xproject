//
//  GainProductBranchListApi.m
//  XProject
//
//  Created by laughing on 2018/10/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "GainProductBranchListApi.h"

@interface GainProductBranchListApi ()

@property (nonatomic, copy) NSString *pid;

@end

@implementation GainProductBranchListApi

- (instancetype)initWithPid:(NSString *)pid
{
    self = [super init];
    
    if (self) {
        self.pid = pid;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/categorytype/getcategorylist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"pid" : self.pid
             };
}

@end
