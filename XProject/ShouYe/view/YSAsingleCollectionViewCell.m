//
//  YSAsingleCollectionViewCell.m
//  YoshopPro
//
//  Created by 610715 on 2018/5/31.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import "YSAsingleCollectionViewCell.h"

@interface YSAsingleCollectionViewCell ()
@property (nonatomic, strong) YYAnimatedImageView *prodcutImage;
@end

@implementation YSAsingleCollectionViewCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.prodcutImage];
        
        [self.prodcutImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

+(NSString *)cellIdentifierl
{
    return NSStringFromClass(self.class);
}

#pragma mark - setter and getter

- (void)setModel:(id<CollectionDatasourceProtocol>)model
{
    _model = model;
    
//    if ([_model.dataSource isKindOfClass:[JumpModel class]]) {
//        JumpModel *model = (JumpModel *)_model.dataSource;
//        [self.prodcutImage yy_setImageWithURL:[NSURL URLWithString:model.imageURL]
//                                  placeholder:[UIImage imageNamed:@"placeholder_banner_pdf"]
//                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionIgnoreImageDecoding
//                                   completion:nil];
//    }
//    if ([_model.dataSource isKindOfClass:[JumpModelV454 class]]) {
//        JumpModelV454 *model = (JumpModelV454 *)_model.dataSource;
//        [self.prodcutImage yy_setImageWithURL:[NSURL URLWithString:model.images]
//                                  placeholder:[UIImage imageNamed:@"placeholder_banner_pdf"]
//                                      options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionIgnoreImageDecoding
//                                   completion:nil];
//    }
}

-(YYAnimatedImageView *)prodcutImage
{
    if (!_prodcutImage) {
        _prodcutImage = ({
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView;
        });
    }
    return _prodcutImage;
}

@end
