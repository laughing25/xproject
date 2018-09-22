//
//  LoginViewController.m
//  XProject
//
//  Created by MOMO on 2018/9/18.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginApi.h"
#import "AccountManager.h"
#import "LoginInputTextView.h"

@interface LoginViewController ()
@property (nonatomic, strong) LoginInputTextView *accountTextView;
@property (nonatomic, strong) LoginInputTextView *passwordTextView;
@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) LoginApi *loginApi;
@end

@implementation LoginViewController

+(void)presentLoginViewController:(XLBaseViewController *)parentViewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [parentViewController presentViewController:loginVC animated:YES completion:nil];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.backgroundImage];
    [self.view addSubview:self.accountTextView];
    [self.view addSubview:self.passwordTextView];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).mas_offset(50);
        make.trailing.mas_equalTo(self.view.mas_trailing).mas_offset(-50);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-60);
        make.height.mas_offset(44);
    }];
    
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.accountTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(30);
        make.trailing.mas_equalTo(self.view.mas_trailing).mas_offset(-30);
        make.height.mas_offset(50);
        make.bottom.mas_equalTo(self.passwordTextView.mas_top).mas_offset(-15);
    }];
    
    [self.passwordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(30);
        make.trailing.mas_equalTo(self.view.mas_trailing).mas_offset(-30);
        make.height.mas_equalTo(self.accountTextView);
        make.bottom.mas_equalTo(self.loginButton.mas_bottom).mas_offset(-50);
    }];
    
    UIButton *closeButton = [[UIButton alloc] init];
    closeButton.backgroundColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).mas_offset(60);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(60);
        make.width.height.mas_offset(40);
    }];
    
    self.accountTextView.inputTextField.text = @"xiaokou";
    self.passwordTextView.inputTextField.text = @"123";
}

- (void)loginButtonAction
{
    NSString *account = self.accountTextView.inputTextField.text;
    NSString *password = self.passwordTextView.inputTextField.text;
    LoginApi *loginApi = [[LoginApi alloc] initWithlogin:account password:password];
    @weakify(self)
    [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        if ([request requestSuccess]) {
            AccountModel *accountModel = [AccountModel yy_modelWithJSON:[request requestResponseData]];
            AccountManager *manager = [AccountManager shareInstance];
            manager.accountModel = accountModel;
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"fail %@", request.error);
    }];
}

- (void)closeButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = ({
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _loginButton;
}

-(UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        _backgroundImage = ({
            UIImageView *image = [[UIImageView alloc] init];
            image.backgroundColor = [UIColor grayColor];
            image;
        });
    }
    return _backgroundImage;
}

-(LoginInputTextView *)accountTextView
{
    if (!_accountTextView) {
        _accountTextView = ({
            LoginInputTextView *view = [[LoginInputTextView alloc] init];
            view.inputTextField.placeholder = @"请输入账号";
            view;
        });
    }
    return _accountTextView;
}

-(LoginInputTextView *)passwordTextView
{
    if (!_passwordTextView) {
        _passwordTextView = ({
            LoginInputTextView *view = [[LoginInputTextView alloc] init];
            view.inputTextField.placeholder = @"请输入密码";
            view;
        });
    }
    return _passwordTextView;
}

@end
