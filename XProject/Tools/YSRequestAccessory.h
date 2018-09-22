//
//  YSRequestAccessory.h
//  Yoshop
//
//  Created by zhaowei on 16/5/28.
//  Copyright © 2016年 yoshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSRequestAccessory : NSObject<YTKRequestAccessory>

@property (nonatomic,copy) NSString *title;

- (instancetype)initWithApperOnView:(UIView *)view;

@end
