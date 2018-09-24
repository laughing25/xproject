//
//  XLWodeTableHeaderView.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLWodeTableHeaderView.h"

@interface XLWodeTableHeaderView()

@property (nonatomic, strong) YYAnimatedImageView *imageView;

@end

@implementation XLWodeTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.nameLabel];
        
        self.imageView.frame = self.bounds;
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
            make.leading.mas_equalTo(self).mas_equalTo(12);
        }];
        
        self.nameLabel.text = ZFToString([AccountManager shareInstance].accountModel.user_name);
    }
    return self;
}

#pragma mark - setter and getter

-(YYAnimatedImageView *)imageView
{
    if (!_imageView) {
        _imageView = ({
            YYAnimatedImageView *image = [[YYAnimatedImageView alloc] init];
            image.image = [UIImage imageNamed:@"my_bgimg"];
            image;
        });
    }
    return _imageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:24];
            label;
        });
    }
    return _nameLabel;
}

@end
