//
//  WKWebViewController.m
//  XProject
//
//  Created by MOMO on 2018/9/24.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface WKWebViewController ()
<
    WKNavigationDelegate
>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态详情";
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.url = @"https://www.baidu.com";
    if (ZFToString(self.url).length) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
        request.timeoutInterval = 30;
        [self.webView loadRequest:request];
    }
    [self.view addSubview:self.progressHUD];
}

#pragma mark - delegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.progressHUD showAnimated:YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [self.progressHUD hideAnimated:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.progressHUD hideAnimated:YES];
}

- (MBProgressHUD *)loadingHUD
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    return hud;
}

#pragma mark - setter

-(WKWebView *)webView
{
    if (!_webView) {
        _webView = ({
            WKWebView *webview = [[WKWebView alloc] init];
            webview.navigationDelegate = self;
            webview;
        });
    }
    return _webView;
}

-(MBProgressHUD *)progressHUD
{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.userInteractionEnabled = NO;
        _progressHUD.bezelView.frame = CGRectMake(0, 0, 30, 30);
    }
    return _progressHUD;
}

@end
