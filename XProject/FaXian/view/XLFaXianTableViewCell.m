//
//  XLFaXianTableViewCell.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLFaXianTableViewCell.h"

@interface XLFaXianTableViewCell ()

@property (nonatomic, strong) YYAnimatedImageView *productImageView;
@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *conteLabel;

@end

@implementation XLFaXianTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.productLabel];
        [self.contentView addSubview:self.conteLabel];
        
        CGFloat padding = 10;
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView).mas_offset(padding);
            make.trailing.mas_equalTo(self.contentView).mas_offset(-padding);
            make.top.mas_equalTo(self.contentView).mas_offset(padding);
            make.height.mas_equalTo(self.productImageView.mas_width).multipliedBy(0.5);
        }];
        
        [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self.productImageView);
            make.top.mas_equalTo(self.productImageView.mas_bottom).mas_offset(10);
        }];
        
        [self.conteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self.productImageView);
            make.top.mas_equalTo(self.productLabel.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5);
        }];
    }
    return self;
}

#pragma mark - setter and getter

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
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label;
        });
    }
    return _conteLabel;
}
@end
