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
        
        self.imageView.frame = self.bounds;
    }
    return self;
}

#pragma mark - setter and getter

-(YYAnimatedImageView *)imageView
{
    if (!_imageView) {
        _imageView = ({
            YYAnimatedImageView *image = [[YYAnimatedImageView alloc] init];
            image.backgroundColor = [UIColor grayColor];
            image;
        });
    }
    return _imageView;
}

@end
