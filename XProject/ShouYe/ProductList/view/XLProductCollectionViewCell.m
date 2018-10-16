//
//  XLProductCollectionViewCell.m
//  XProject
//
//  Created by 610715 on 2018/9/10.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLProductCollectionViewCell.h"

@interface XLProductCollectionViewCell()

@property (nonatomic, strong) YYAnimatedImageView *productImage;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *productPriceLabel;

@end

@implementation XLProductCollectionViewCell
#pragma mark - init methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.productImage];
        [self addSubview:self.productNameLabel];
        [self addSubview:self.productPriceLabel];
        
        [self.productImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self.productImage.mas_height);
        }];
        
        [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.productImage.mas_top).mas_offset(5);
            make.leading.mas_equalTo(self.productImage.mas_trailing).mas_offset(10);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(10);
        }];
        
        [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.productImage.mas_bottom).mas_offset(-5);
            make.leading.mas_equalTo(self.productImage.mas_trailing).mas_offset(10);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(10);
        }];
    }
    return self;
}

#pragma mark - setter and getter

-(void)setModel:(ProductBranchModel *)model
{
    _model = model;
    [self.productImage yy_setImageWithURL:[NSURL URLWithString:_model.ico_url] placeholder:nil];
    self.productNameLabel.text = _model.title;
}

-(YYAnimatedImageView *)productImage
{
    if (!_productImage) {
        _productImage = ({
            YYAnimatedImageView *image = [[YYAnimatedImageView alloc] init];
            image;
        });
    }
    return _productImage;
}

-(UILabel *)productNameLabel
{
    if (!_productNameLabel) {
        _productNameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _productNameLabel;
}

-(UILabel *)productPriceLabel
{
    if (!_productPriceLabel) {
        _productPriceLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _productPriceLabel;
}

@end
