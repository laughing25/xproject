//
//  ChangePasswordViewController.m
//  XProject
//
//  Created by MOMO on 2018/9/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordApi.h"

@interface ChangePasswordViewController ()
@property (nonatomic, strong) UITextField *newpassword;
@property (nonatomic, strong) UITextField *newpassword2;
@property (nonatomic, strong) UIButton *changeButton;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    [self.view addSubview:self.newpassword];
    [self.view addSubview:self.newpassword2];
    [self.view addSubview:self.changeButton];
    
    [self.newpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(25);
        make.trailing.mas_equalTo(self.view).mas_offset(-25);
        make.top.mas_equalTo(self.view).mas_offset(15);
        make.height.mas_offset(44);
    }];
    
    [self.newpassword2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(25);
        make.trailing.mas_equalTo(self.view).mas_offset(-25);
        make.top.mas_equalTo(self.newpassword.mas_bottom).mas_offset(15);
        make.height.mas_offset(44);
    }];
    
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.newpassword2.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.5);
        make.height.mas_offset(44);
    }];
}

- (void)changeButtonAction
{
    NSString *pass1 = self.newpassword.text;
    NSString *pass2 = self.newpassword2.text;
    if (![pass1 isEqualToString:pass2]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入密码不一致，请检查" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    ChangePasswordApi *api = [[ChangePasswordApi alloc] initWithPassword:self.newpassword2.text];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        NSString *message = request.responseJSONObject[@"Info"];
        [request showToaster:message];
        if ([request requestSuccess]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *message = @"请检查网络";
        [request showToaster:message];
    }];
}

-(UITextField *)newpassword
{
    if (!_newpassword) {
        _newpassword = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.placeholder = @"请输入新密码";
            textField.font = [UIFont systemFontOfSize:12];
            textField.borderStyle = UITextBorderStyleNone;
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.layer.cornerRadius = 2;
            textField.layer.borderWidth = 1;
            textField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            textField;
        });
    }
    return _newpassword;
}

-(UITextField *)newpassword2
{
    if (!_newpassword2) {
        _newpassword2 = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.placeholder = @"请再次输入密码";
            textField.font = [UIFont systemFontOfSize:12];
            textField.borderStyle = UITextBorderStyleNone;
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.layer.cornerRadius = 2;
            textField.layer.borderWidth = 1;
            textField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            textField;
        });
    }
    return _newpassword2;
}

-(UIButton *)changeButton
{
    if (!_changeButton) {
        _changeButton = ({
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor colorWithHexColorString:@"276ecd"];
            [button setTitle:@"修改密码" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.cornerRadius = 5;
            [button addTarget:self action:@selector(changeButtonAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _changeButton;
}

@end
