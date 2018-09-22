//
//  YTKRequest+Tools.h
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YTKBaseRequest (Tools)

- (BOOL)requestSuccess;

- (NSArray *)requestResponseArrayData:(Class)klass;

- (id)requestResponseData;

@end
