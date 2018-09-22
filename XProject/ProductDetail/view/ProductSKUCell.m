//
//  ProductSKUCell.m
//  XProject
//
//  Created by MOMO on 2018/9/19.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductSKUCell.h"

@interface ProductSKUCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *SKULabel;
@end

@implementation ProductSKUCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.SKULabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(self).mas_offset(10);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];
        
        [self.SKULabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.nameLabel);
            make.leading.mas_equalTo(self.nameLabel.mas_trailing).mas_offset(10);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
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

-(UILabel *)SKULabel
{
    if (!_SKULabel) {
        _SKULabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _SKULabel;
}
@end
