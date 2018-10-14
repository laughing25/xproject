//
//  XLDongTaiTableViewCell.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLDongTaiTableViewCell.h"

@interface XLDongTaiTableViewCell ()
@property (nonatomic, strong) YYAnimatedImageView *cellImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation XLDongTaiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.cellImageView];
        [self addSubview:self.titleLabel];
        
        [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
            make.top.mas_equalTo(self.mas_top).mas_equalTo(15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-15);
            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
            make.height.mas_equalTo(self.cellImageView.mas_width).multipliedBy(.75);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cellImageView.mas_top);
            make.trailing.mas_equalTo(self.cellImageView.mas_leading).mas_offset(-10);
            make.leading.mas_equalTo(self.mas_leading).mas_offset(10);
        }];
    }
    return self;
}

#pragma mark - setter and getter

-(void)setModel:(AdInfoModel *)model
{
    _model = model;
    
    if (model.img_url.length) {
        self.cellImageView.backgroundColor = [UIColor whiteColor];
        [self.cellImageView yy_setImageWithURL:[NSURL URLWithString:model.img_url] placeholder:nil];
    }
    self.titleLabel.text = model.title;
}

-(YYAnimatedImageView *)cellImageView
{
    if (!_cellImageView) {
        _cellImageView = ({
            YYAnimatedImageView *image = [[YYAnimatedImageView alloc] init];
            image.backgroundColor = [UIColor groupTableViewBackgroundColor];
            image;
        });
    }
    return _cellImageView;
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
