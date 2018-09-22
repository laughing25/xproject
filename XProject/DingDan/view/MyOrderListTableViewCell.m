//
//  MyOrderListTableViewCell.m
//  XProject
//
//  Created by 610715 on 2018/9/3.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "MyOrderListTableViewCell.h"

@interface MyOrderListTableViewCell ()

@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *orderStatusLabel;

@property (nonatomic, strong) UIView *middleContentView;
@property (nonatomic, strong) YYAnimatedImageView *productImageView;
@property (nonatomic, strong) UILabel *productLabel;


@property (nonatomic, strong) UILabel *conteLabel;

@end

@implementation MyOrderListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.orderTimeLabel];
        [self.contentView addSubview:self.orderStatusLabel];
        
        [self.contentView addSubview:self.middleContentView];
        [self.middleContentView addSubview:self.productImageView];
        [self.middleContentView addSubview:self.productLabel];
        
        [self.contentView addSubview:self.conteLabel];
        
        CGFloat padding = 10;
        UIView *contentView = self.contentView;
        [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(contentView.mas_leading).mas_offset(padding);
            make.top.mas_equalTo(contentView.mas_top).mas_offset(padding);
        }];
        
        [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(contentView.mas_trailing).mas_offset(-padding);
            make.centerY.mas_equalTo(self.orderTimeLabel.mas_centerY);
        }];
        
        [self.middleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).mas_offset(padding);
            make.leading.trailing.mas_equalTo(contentView);
        }];
        
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.middleContentView).mas_offset(padding);
            make.top.mas_equalTo(self.middleContentView).mas_offset(padding);
            make.bottom.mas_equalTo(self.middleContentView.mas_bottom).mas_offset(-padding);
            make.height.mas_offset(50);
            make.width.mas_equalTo(self.productImageView.mas_height);
        }];
        
        [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.middleContentView.mas_trailing).mas_offset(padding/2);
            make.top.mas_equalTo(self.productImageView.mas_top);
        }];
        
        [self.conteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(contentView.mas_trailing).mas_offset(-padding);
            make.top.mas_equalTo(self.middleContentView.mas_bottom).mas_offset(padding);
            make.bottom.mas_equalTo(contentView.mas_bottom).mas_offset(-padding);
        }];
    }
    return self;
}

#pragma mark - setter and getter

-(UILabel *)orderTimeLabel
{
    if (!_orderTimeLabel) {
        _orderTimeLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:16];
            label;
        });
    }
    return _orderTimeLabel;
}

-(UILabel *)orderStatusLabel
{
    if (!_orderStatusLabel) {
        _orderStatusLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:16];
            label;
        });
    }
    return _orderStatusLabel;
}

-(UIView *)middleContentView
{
    if (!_middleContentView) {
        _middleContentView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            view;
        });
    }
    return _middleContentView;
}

-(YYAnimatedImageView *)productImageView
{
    if (!_productImageView) {
        _productImageView = ({
            YYAnimatedImageView *image = [[YYAnimatedImageView alloc] init];
            image.layer.borderWidth = 1;
            image.layer.borderColor = [UIColor blackColor].CGColor;
            image;
        });
    }
    return _productImageView;
}

-(UILabel *)productLabel
{
    if (!_productLabel) {
        _productLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:16];
            label;
        });
    }
    return _productLabel;
}

-(UILabel *)conteLabel
{
    if (!_conteLabel) {
        _conteLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label;
        });
    }
    return _conteLabel;
}

@end
