//
//  ProductSelectNumCell.m
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductSelectNumCell.h"

@interface ProductSelectNumCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UITextField *numTextField;
@property (nonatomic, strong) UIButton *minButton;
@property (nonatomic, strong) UIView *backView;
@end

@implementation ProductSelectNumCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.backView];
        [self.backView addSubview:self.plusButton];
        [self.backView addSubview:self.numTextField];
        [self.backView addSubview:self.minButton];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(self).mas_offset(10);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];

        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(self).multipliedBy(0.2);
            make.height.mas_equalTo(self).multipliedBy(0.8);
        }];
        
        [self.minButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.bottom.mas_equalTo(self.backView);
            make.width.mas_equalTo(self.backView).multipliedBy(0.3);
        }];
        
        [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.minButton.mas_trailing);
            make.trailing.mas_equalTo(self.plusButton.mas_leading);
            make.top.bottom.mas_equalTo(self.backView);
        }];
        
        [self.plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.top.bottom.mas_equalTo(self.backView);
            make.width.mas_equalTo(self.backView).multipliedBy(0.3);
        }];
    
    }
    return self;
}

-(void)plusButtonAction
{
    
}

-(void)minButtonAction
{
    
}

+(NSString *)cellIdentifierl
{
    return NSStringFromClass(self.class);
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _nameLabel;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            view.layer.borderWidth = 1;
            view.layer.cornerRadius = 5;
            view;
        });
    }
    return _backView;
}

-(UIButton *)plusButton
{
    if (!_plusButton) {
        _plusButton = ({
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:@"+" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(plusButtonAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _plusButton;
}

-(UIButton *)minButton
{
    if (!_minButton) {
        _minButton = ({
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:@"-" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(minButtonAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _minButton;
}

-(UITextField *)numTextField
{
    if (!_numTextField) {
        _numTextField = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.text = @"1";
            textField.enabled = NO;
            textField.textAlignment = NSTextAlignmentCenter;
            textField;
        });
    }
    return _numTextField;
}

@end
