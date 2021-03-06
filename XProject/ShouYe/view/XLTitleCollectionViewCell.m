//
//  XLTitleCollectionViewCell.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLTitleCollectionViewCell.h"

@interface XLTitleCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XLTitleCollectionViewCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.leading.mas_equalTo(self).mas_offset(10);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
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
    
    if (![_model.dataSource isKindOfClass:[TitleModel class]]) {
        return;
    }
    TitleModel *titleModel = (TitleModel *)model.dataSource;
    self.titleLabel.text = titleModel.title;
    self.titleLabel.textAlignment = titleModel.alignment;
    self.titleLabel.textColor = titleModel.titleColor;
    self.backgroundColor = titleModel.backgroundColor;
}

- (UILabel *)titleLabel
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

@implementation TitleModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleColor = [UIColor blackColor];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

@end
