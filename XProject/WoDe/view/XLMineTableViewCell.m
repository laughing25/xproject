//
//  XLMineTableViewCell.m
//  XProject
//
//  Created by MOMO on 2018/9/23.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLMineTableViewCell.h"

@interface XLMineTableViewCell ()

@end

@implementation XLMineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.icon];
        [self addSubview:self.titleLabel];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(28, 28));
            make.leading.mas_equalTo(self).mas_offset(12);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.leading.mas_equalTo(self.icon.mas_trailing).mas_offset(10);
        }];
    }
    return self;
}

#pragma mark - setter

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = ({
            UIImageView *image = [[UIImageView alloc] init];
            image;
        });
    }
    return _icon;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"test";
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _titleLabel;
}

@end
