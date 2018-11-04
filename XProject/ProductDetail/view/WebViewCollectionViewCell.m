//
//  WebViewCollectionViewCell.m
//  TestCollectionView
//
//  Created by 610715 on 2018/9/30.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "WebViewCollectionViewCell.h"
#import <WebKit/WebKit.h>
#import "ProductModel.h"
#import "ProductDetailCellModel.h"

@interface WebViewCollectionViewCell ()
<
    WKNavigationDelegate
>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@end

@implementation WebViewCollectionViewCell
@synthesize model = _model;
@synthesize delegate = _delegate;


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.webView];
        [self addSubview:self.activityView];
        self.activityView.frame = CGRectMake((frame.size.width - 30) / 2, 20, 30, 30);
        [self.activityView startAnimating];
//        [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
//        NSString *htmlString = @"<p class=\"attr-list-hd tm-clear\" style=\"color:#999999;font-family:tahoma, arial, 微软雅黑, sans-serif;background-color:#FFFFFF;\">\r\n\t<span style=\"font-weight:700;\">产品参数：</span> \r\n</p>\r\n<ul id=\"J_AttrUL\" style=\"color:#404040;font-family:tahoma, arial, 微软雅黑, sans-serif;background-color:#FFFFFF;\">\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t证书编号：2014011606717032\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t证书状态：有效\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t申请人名称：美国苹果公司\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t制造商名称：美国苹果公司\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t产品名称：TD-LTE 数字移动电话机\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t3C产品型号：A1586（电源适配器：A1443,输出:5.0VDC,1.0A）（电源适配器为可选部件）\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t3C规格型号：A1586（电源适配器：A1443,输出:5.0VDC,1.0A）（电源适配器为可选部件）\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t产品名称：Apple/苹果 iPhone 6\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\tCPU型号:&nbsp;其他\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\tApple型号:&nbsp;iPhone 6\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t机身颜色:&nbsp;金色&nbsp;深空灰色\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t运行内存RAM:&nbsp;1GB\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t存储容量:&nbsp;32GB\r\n\t</li>\r\n\t<li style=\"vertical-align:top;color:#666666;\">\r\n\t\t网络模式:&nbsp;无需合约版\r\n\t</li>\r\n</ul>";
//        htmlString = @"<p>\r\n\t测试商品测试商品测试商品测试商品测试商品测试商品测试商品测试商品测试\r\n</p>\r\n<p>\r\n\t<br />\r\n</p>\r\n<p>\r\n\t新手机iPhone\r\n</p>\r\n<p>\r\n\t测试商品测试商品测试商品测试商<img src=\"http://testadmin.fnwcm.com/upload/201809/30/201809300943050038.jpg\" alt=\"\" /><img src=\"http://testadmin.fnwcm.com/upload/201809/30/201809300943218948.jpg\" alt=\"\" /><img src=\"http://testadmin.fnwcm.com/upload/201809/30/201809300943380203.jpg\" alt=\"\" />\r\n</p>";
//        [self.webView loadHTMLString:htmlString baseURL:nil];
    }
    return self;
}

+(NSString *)cellIdentifierl
{
    return NSStringFromClass(self.class);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.body.scrollHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {

        NSString *heightStr = [NSString stringWithFormat:@"%@",any];

        NSLog(@"height - %@", heightStr);
        [webView evaluateJavaScript:@"document.body.scrollWidth;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {

            NSString *widthStr = [NSString stringWithFormat:@"%@",any];
            NSLog(@"width - %@", heightStr);

            CGFloat rotia = webView.frame.size.width / widthStr.floatValue;

            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(WebViewCollectionViewCellReloadHeight:height:)]) {
                    [self.activityView stopAnimating];
                    self.webView.frame = CGRectMake(0, 0, self.webView.frame.size.width, heightStr.floatValue);
                    [self.delegate WebViewCollectionViewCellReloadHeight:self height:heightStr.floatValue * rotia];
                }
            });
            
        }];
    }];
}

-(void)setModel:(id<CollectionDatasourceProtocol>)model
{
    _model = model;
    if ([_model.dataSource isKindOfClass:[ProductModel class]]) {
        if ([_model isKindOfClass:[ProductDetailCellModel class]]) {
            ProductDetailCellModel *cellModel = _model;
            if (!cellModel.isReload) {
                ProductModel *product = (ProductModel *)_model.dataSource;
                [self.webView loadHTMLString:product.descriptions baseURL:nil];
            }
        }
    }
}

-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

-(UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] init];
        _activityView.hidesWhenStopped = YES;
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _activityView;
}

@end
