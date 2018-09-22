//
//  ProductDetailNameCell.m
//  XProject
//
//  Created by MOMO on 2018/9/19.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductDetailNameCell.h"

@interface ProductDetailNameCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation ProductDetailNameCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [whiteView addSubview:self.nameLabel];
        [whiteView addSubview:self.priceLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(whiteView).mas_offset(10);
            make.trailing.mas_equalTo(whiteView.mas_trailing).mas_offset(-10);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(whiteView.mas_bottom).mas_offset(-5);
            make.leading.trailing.mas_equalTo(self.nameLabel);
        }];
    }
    return self;
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
