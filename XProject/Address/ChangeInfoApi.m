//
//  ChangeInfoApi.m
//  XProject
//
//  Created by MOMO on 2018/9/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ChangeInfoApi.h"

@interface ChangeInfoApi ()

@property (nonatomic, strong) XLAddressDetailInfoModel *model;

@end

@implementation ChangeInfoApi

- (instancetype)initWithModel:(XLAddressDetailInfoModel *)model
{
    self = [super init];
    
    if (self) {
        self.model = model;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/ChangeAddress/do";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid" : ZFToString([AccountManager shareInstance].accountModel.userId),
             @"countryid" : ZFToString(self.model.countryId),
             @"address" : ZFToString(self.model.address)
             };
}

@end
