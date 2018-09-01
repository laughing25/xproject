//
//  XLAddressDetailTableViewCell.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLAddressDetailTableViewCell.h"

@interface XLAddressDetailTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation XLAddressDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
    }
    return self;
}

#pragma mark - setter and getter

-(void)setModel:(XLAddressDetailCellModel *)model
{
    _model = model;
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

- (UITextField *)textField
{
    if (!_textField) {
        _textField = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.placeholder = @"plcae holder";
            textField.font = [UIFont systemFontOfSize:12];
            textField.borderStyle = UITextBorderStyleNone;
            textField;
        });
    }
    return _textField;
}

@end
