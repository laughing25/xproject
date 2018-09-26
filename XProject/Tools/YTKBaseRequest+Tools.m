//
//  YTKRequest+Tools.m
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "YTKBaseRequest+Tools.h"
#import <MBProgressHUD/MBProgressHUD.h>

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
    NSString *message = [params objectForKey:@"Info"];
    NSLog(@"request message %@", message);
    if (ZFToString(message).length) {
        [self showToaster:message];
    }
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

-(void)showToaster:(NSString *)message
{
    MBProgressHUD *hud = [WINDOW viewWithTag:1004];
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:WINDOW];
        hud.tag = 1004;
    }
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.textColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    hud.label.text = message;
    [WINDOW addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2];
}

@end
