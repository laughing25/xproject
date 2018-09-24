//
//  YTKRequest+Tools.m
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "YTKBaseRequest+Tools.h"

@implementation YTKBaseRequest (Tools)

- (BOOL)requestSuccess
{
    id params = self.responseJSONObject;
    if (![params isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    NSInteger status = [[params objectForKey:@"StatusCode"] integerValue];
    if (status == 200) {
        return YES;
    }
    NSLog(@"request message %@", [params objectForKey:@"Info"]);
    return NO;
}

- (NSArray *)requestResponseArrayData:(Class)klass
{
    if ([self requestSuccess]) {
        id data = [self.responseJSONObject objectForKey:@"Data"];
        if ([data isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray yy_modelArrayWithClass:klass json:data];
            return array;
        }
        return @[];
    }
    return @[];
}

- (id)requestResponseData
{
    id data = [self.responseJSONObject objectForKey:@"Data"];
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *list = (NSArray *)data;
        data = list.firstObject;
    }
    if (data) {
        return data;
    }
    return @{};
}
    


@end
