//
//  XLProductListTableViewCell.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLProductListTableViewCell.h"

@interface XLProductListTableViewCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) YYAnimatedImageView *productImageView;
@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation XLProductListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.productImageView];
        [self.backView addSubview:self.productLabel];
        [self.backView addSubview:self.priceLabel];
        
        CGFloat padding = 10;
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).mas_offset(UIEdgeInsetsMake(padding, padding, padding, padding));
            make.height.mas_offset(100);
        }];
        
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.backView);
            make.top.bottom.mas_equalTo(self.backView);
            make.width.mas_equalTo(self.productImageView.mas_height);
        }];
        
        [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.productImageView.mas_trailing).mas_offset(5);
            make.top.mas_equalTo(self.productImageView.mas_top);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.productImageView.mas_trailing).mas_offset(5);
            make.bottom.mas_equalTo(self.productImageView.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - setter and getter

-(UIView *)backView
{
    if (!_backView) {
        _backView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _backView;
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
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _productLabel;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _priceLabel;
}


@end
