//
//  XLAddressDetailTableViewCell.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLAddressDetailTableViewCell.h"

@interface XLAddressDetailTableViewCell ()
<
    UITextFieldDelegate
>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation XLAddressDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
        
        CGFloat padding = 12;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).mas_offset(12);
            make.top.bottom.mas_equalTo(self);
            make.width.mas_offset(80);
            make.height.mas_offset(48);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.titleLabel.mas_trailing).mas_offset(padding);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-padding);
            make.top.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.content = textField.text;
}

#pragma mark - setter and getter

-(void)setModel:(XLAddressDetailCellModel *)model
{
    _model = model;
    
    if (_model.type == AddressDetailCellType_CanEdit) {
        self.textField.enabled = YES;
    }else{
        self.textField.enabled = NO;
    }
    self.textField.keyboardType = model.keyboardType;
    self.titleLabel.text = model.title;
    self.textField.text = model.content;
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
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.delegate = self;
            textField;
        });
    }
    return _textField;
}

@end
