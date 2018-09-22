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
        make.leading.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(self);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImage.mas_trailing).mas_offset(10);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.top.bottom.mas_equalTo(self);
    }];
}

-(UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = ({
            UIImageView *image = [[UIImageView alloc] init];
            image.backgroundColor = [UIColor redColor];
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
            textField;
        });
    }
    return _inputTextField;
}

@end
