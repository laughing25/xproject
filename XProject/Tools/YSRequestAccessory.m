//
//  YSRequestAccessory.m
//  Yoshop
//
//  Created by zhaowei on 16/5/28.
//  Copyright © 2016年 yoshop. All rights reserved.
//

#import "YSRequestAccessory.h"
#import "MBProgressHUD.h"

@interface YSRequestAccessory ()

@property (nonatomic,weak) MBProgressHUD *hud;

///因为这里能获取到的view,一般都是来自于UIViewController的view, controller的view是被controller强引用的，所以当controller不被释放，这个视图是不会被释放的
@property (nonatomic,weak) UIView *view;

@end

@implementation YSRequestAccessory

- (instancetype)initWithApperOnView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
    }
    return self;
}

- (void)requestWillStart:(id)request {
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view ? self.view : [UIApplication sharedApplication].keyWindow animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        self.hud = hud;
        [hud showAnimated:YES];
    });
}

- (void)requestDidStop:(id)request {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
    });
}
@end
