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
        [self addSubview:self.imageView];
        [self addSubview:self.textLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@(10* MIN_PIXEL));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(41* MIN_PIXEL, 41* MIN_PIXEL));
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(@(-5* MIN_PIXEL));
            make.leading.mas_equalTo(@5);
            make.trailing.mas_equalTo(@(-5));
            make.top.equalTo(self.imageView.mas_bottom).mas_equalTo(3* MIN_PIXEL);
        }];
    }
    return self;
}

#pragma mark - setter and getter

-(void)setModel:(id<CollectionDatasourceProtocol>)model
{
    _model = model;
    
//    if ([_model.dataSource isKindOfClass:[JumpModel class]]) {
//        JumpModel *model = (JumpModel *)_model.dataSource;
//        [self.imageView yy_setImageWithURL:[NSURL URLWithString:model.imageURL]
//                                  placeholder:[UIImage imageNamed:@"placeholder_banner_pdf"]
//                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionIgnoreImageDecoding
//                                   completion:nil];
//        self.textLabel.text = model.name;
//    }
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
