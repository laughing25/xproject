//
//  ProductDetailBottomView.m
//  XProject
//
//  Created by MOMO on 2018/9/23.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductDetailBottomView.h"

@interface ProductDetailBottomView ()

@property (nonatomic, strong) UILabel *numsLabel;
@property (nonatomic, strong) UIButton *buyButton;

@end

@implementation ProductDetailBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.numsLabel];
        [self addSubview:self.buyButton];
        
        [self.numsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).mas_offset(12);
            make.top.bottom.mas_equalTo(self);
        }];
        
        [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing);
            make.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self.mas_width).multipliedBy(0.35);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_offset(1);
        }];
    }
    return self;
}

-(void)buyButtonAction
{
    if (self.buyBlock) {
        self.buyBlock();
    }
}

-(void)setModel:(ProductModel *)model
{
    _model = model;
    if (_model) {
        self.hidden = NO;
    }
    self.numsLabel.text = [NSString stringWithFormat:@"数量:100个"];
}

-(UILabel *)numsLabel
{
    if (!_numsLabel) {
        _numsLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"数量";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _numsLabel;
}

-(UIButton *)buyButton
{
    if (!_buyButton) {
        _buyButton = ({
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor redColor];
            [button setTitle:@"立即订购" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _buyButton;
}

@end
