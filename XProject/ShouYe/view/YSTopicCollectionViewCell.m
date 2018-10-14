//
//  YSTopicCollectionViewCell.m
//  YoshopPro
//
//  Created by 610715 on 2018/7/9.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import "YSTopicCollectionViewCell.h"

@interface YSTopicCollectionViewCell ()

@property (nonatomic, strong) YYAnimatedImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation YSTopicCollectionViewCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        [self addSubview:self.textLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@(10* DSCREEN_WIDTH_SCALE));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(41* DSCREEN_WIDTH_SCALE, 41* DSCREEN_WIDTH_SCALE));
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(@(-5* DSCREEN_WIDTH_SCALE));
            make.leading.mas_equalTo(@5);
            make.trailing.mas_equalTo(@(-5));
            make.top.equalTo(self.imageView.mas_bottom).mas_equalTo(3* DSCREEN_WIDTH_SCALE);
        }];
    }
    return self;
}

+(NSString *)cellIdentifierl
{
    return NSStringFromClass(self.class);
}

#pragma mark - setter and getter

-(void)setModel:(CategoryModel *)model
{
    _model = model;
    
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:_model.icoUrl]
                              placeholder:[UIImage imageNamed:@"placeholder_banner_pdf"]
                                  options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionIgnoreImageDecoding
                               completion:nil];
    self.textLabel.text = model.title;
}

- (YYAnimatedImageView *)imageView
{
    if (!_imageView) {
        _imageView = ({
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView;
        });
    }
    return _imageView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"test";
            label.textColor = ZFCOLOR_BLACK;
            label.font = [UIFont systemFontOfSize:11];
            label.numberOfLines = 0;
            label;
        });
    }
    return _textLabel;
}

@end
