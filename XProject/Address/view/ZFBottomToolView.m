//
//  ZFBottomToolView.m
//  Zaful
//
//  Created by liuxi on 2017/8/29.
//  Copyright © 2017年 Y001. All rights reserved.
//

#import "ZFBottomToolView.h"

@interface ZFBottomToolView ()
@property (nonatomic, strong) UIView            *topLine;
@property (nonatomic, strong) UIButton          *addAddressButton;
@end

@implementation ZFBottomToolView
#pragma mark - init methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self zfInitView];
        [self zfAutoLayoutView];
    }
    return self;
}

- (void)setBottomTitle:(NSString *)bottomTitle {
    _bottomTitle = bottomTitle;
    [self.addAddressButton setTitle:bottomTitle forState:UIControlStateNormal];
}

#pragma mark - action methods
- (void)addAddressButtonAction:(UIButton *)sender {
    if (self.bottomButtonBlock) {
        self.bottomButtonBlock();
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.showTopShadowline) {
//        [self addDropShadowWithOffset:CGSizeMake(0, -2)
//                               radius:2
//                                color:[UIColor blackColor]
//                              opacity:0.1];
    }
}

#pragma mark - <ZFInitViewProtocol>
- (void)zfInitView {
    self.backgroundColor = ZFCOLOR_WHITE;
    [self addSubview:self.topLine];
    [self addSubview:self.addAddressButton];
}

- (void)zfAutoLayoutView {
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 16, 10, 16));
    }];
}

- (UIView *)topLine {
    if(!_topLine){
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor blackColor];
    }
    return _topLine;
}

#pragma mark - getter
- (UIButton *)addAddressButton {
    if (!_addAddressButton) {
        _addAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addAddressButton.backgroundColor = ZFCOLOR(45, 45, 45, 1);
        [_addAddressButton setTitleColor:ZFCOLOR_WHITE forState:UIControlStateNormal];
        _addAddressButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _addAddressButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_addAddressButton addTarget:self action:@selector(addAddressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressButton;
}

@end
