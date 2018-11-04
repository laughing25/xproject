//
//  CustomerBackgroundReusableView.m
//  XProject
//
//  Created by laughing on 2018/11/3.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "CustomerBackgroundReusableView.h"
#import "CustomerBackgroundAttributes.h"

@interface CustomerBackgroundReusableView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation CustomerBackgroundReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[CustomerBackgroundAttributes class]]) {
        CustomerBackgroundAttributes *attr = (CustomerBackgroundAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
        self.backgroundImageView.image = attr.backgroundImage;
    }
}

-(UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = ({
            UIImageView *img = [[UIImageView alloc] init];
            img.contentMode = UIViewContentModeScaleToFill;
            img;
        });
    }
    return _backgroundImageView;
}

@end
