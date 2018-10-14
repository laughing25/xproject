//
//  XLHeaderCollectionViewCell.m
//  XProject
//
//  Created by MOMO on 2018/9/26.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLHeaderCollectionViewCell.h"

@interface XLHeaderCollectionViewCell ()

@property (nonatomic, strong) UIView *padderView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XLHeaderCollectionViewCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.padderView];
        [self addSubview:self.titleLabel];
        
        [self.padderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).mas_offset(12);
            make.width.mas_offset(4);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.leading.mas_equalTo(self.padderView.mas_trailing).mas_offset(5);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-5);
        }];
        
        self.padderView.layer.cornerRadius = 2;
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
    
    if ([_model.dataSource isKindOfClass:[NSString class]]) {
        self.titleLabel.text = (NSString *)_model.dataSource;
    }
}

-(UIView *)padderView
{
    if (!_padderView) {
        _padderView = [[UIView alloc] init];
        _padderView.backgroundColor = [UIColor redColor];
    }
    return _padderView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label;
        });
    }
    return _titleLabel;
}

@end
