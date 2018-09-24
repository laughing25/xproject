//
//  LoginInputTextView.m
//  XProject
//
//  Created by MOMO on 2018/9/21.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "LoginInputTextView.h"

@interface LoginInputTextView ()
@end

@implementation LoginInputTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    [self addSubview:self.iconImage];
    [self addSubview:self.inputTextField];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.mas_equalTo(self);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImage.mas_trailing).mas_offset(20);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.top.bottom.mas_equalTo(self);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputTextField.mas_bottom);
        make.leading.trailing.mas_equalTo(self.inputTextField);
        make.height.mas_offset(0.5);
    }];
}

-(UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = ({
            UIImageView *image = [[UIImageView alloc] init];
            image;
        });
    }
    return _iconImage;
}

-(UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.font = [UIFont systemFontOfSize:12];
            textField.textColor = [UIColor whiteColor];
            textField;
        });
    }
    return _inputTextField;
}

@end
