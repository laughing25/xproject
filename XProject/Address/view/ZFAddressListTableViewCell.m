
//
//  ZFAddressListTableViewCell.m
//  Zaful
//
//  Created by liuxi on 2017/8/29.
//  Copyright © 2017年 Y001. All rights reserved.
//

#import "ZFAddressListTableViewCell.h"
#import "ZFAddressInfoModel.h"

@interface ZFAddressListTableViewCell ()

@property (nonatomic, strong) UIView                 *informView;
@property (nonatomic, strong) UIView                 *eventView;
@property (nonatomic, strong) UIView                 *lineView;
@property (nonatomic, strong) UIView                 *bottomLineView;

@property (nonatomic, strong) UILabel                *nameLabel;
@property (nonatomic, strong) UILabel                *telphoneLabel;
@property (nonatomic, strong) UILabel                *addressInfoLabel;

@property (nonatomic, strong) UIImageView            *defaultImgView;
@property (nonatomic, strong) UILabel                *defaultAddress;
@property (nonatomic, strong) UIButton               *defaultButton;

@property (nonatomic, strong) UIButton               *editButton;
@property (nonatomic, strong) UIButton               *deleteButton;

@end

@implementation ZFAddressListTableViewCell

#pragma mark - init methods
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.isEdit = YES;
        
        [self zfInitView];
        [self zfAutoLayoutView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)tapAction
{
    if (self.addressEditSelectCompletionHandler) {
        self.addressEditSelectCompletionHandler(self.model, ZFAddressListCellEventSelect);
    }
}

- (void)updateInfoModel:(ZFAddressInfoModel *)model edit:(BOOL)isEdit {
    self.isEdit = isEdit;
    self.model = model;
}

#pragma mark - <ZFInitViewProtocol>
- (void)zfInitView {

    [self.contentView addSubview:self.informView];
    [self.contentView addSubview:self.eventView];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.telphoneLabel];
    [self.contentView addSubview:self.addressInfoLabel];
    
    [self.contentView addSubview:self.defaultImgView];
    [self.contentView addSubview:self.defaultAddress];
    [self.contentView addSubview:self.defaultButton];
    
    [self.contentView addSubview:self.editButton];
    [self.contentView addSubview:self.deleteButton];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.bottomLineView];
}

- (void)zfAutoLayoutView {
    
    [self.informView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.informView.mas_leading).offset(16);
        make.top.mas_equalTo(self.informView.mas_top).offset(16);
        make.width.mas_offset(100);
    }];
    
    [self.telphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel);
        make.leading.mas_equalTo(self.nameLabel.mas_trailing).mas_offset(10);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-16);
    }];
    
    [self.addressInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel.mas_leading);
        make.trailing.mas_equalTo(self.informView.mas_trailing).offset(-16);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8);
        make.bottom.mas_equalTo(self.informView.mas_bottom).offset(-16);
    }];
    
    [self.eventView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.informView.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(44);
    }];

    
    [self.defaultImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.eventView.mas_leading).mas_offset(16);
        make.centerY.mas_equalTo(self.eventView.mas_centerY);
    }];
    
    [self.defaultAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.defaultImgView.mas_trailing).mas_offset(8);
        make.centerY.mas_equalTo(self.defaultImgView.mas_centerY);
    }];
    
    [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.defaultImgView.mas_leading);
        make.trailing.mas_equalTo(self.defaultAddress.mas_trailing);
        make.top.bottom.mas_equalTo(self.eventView);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.eventView.mas_trailing).mas_offset(-24);
        make.centerY.mas_equalTo(self.defaultImgView.mas_centerY);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.deleteButton.mas_trailing).mas_offset(-64);
        make.centerY.mas_equalTo(self.defaultImgView.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.eventView.mas_top);
        make.leading.trailing.mas_equalTo(self.eventView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.eventView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - 响应方法

- (void)defaultAction:(UIButton *)sender {
    if (self.addressEditSelectCompletionHandler) {
        self.addressEditSelectCompletionHandler(self.model, ZFAddressListCellEventDefault);
    }
}

- (void)editAction:(UIButton *)sender {
    if (self.addressEditSelectCompletionHandler) {
        self.addressEditSelectCompletionHandler(self.model, ZFAddressListCellEventEdit);
    }
}

- (void)deleteAction:(UIButton *)sender {
    if (self.addressEditSelectCompletionHandler) {
        self.addressEditSelectCompletionHandler(self.model, ZFAddressListCellEventDelete);
    }
}

#pragma mark - setter
- (void)setModel:(ZFAddressInfoModel *)model {
    _model = model;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",model.firstname,model.lastname];
    CGFloat width = [self.nameLabel.text textSizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].width;
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(width + 5);
    }];
    
    if([NSStringUtils isEmptyString:model.code] && [NSStringUtils isEmptyString:model.supplier_number]) {
        self.telphoneLabel.text = [NSString stringWithFormat:@"%@",model.tel];
    } else {
        self.telphoneLabel.text = [NSString stringWithFormat:@"+%@ %@%@",[NSStringUtils isEmptyString:model.code withReplaceString:@""],[NSStringUtils isEmptyString:model.supplier_number withReplaceString:@""],model.tel];
    }
    self.addressInfoLabel.text = [NSString stringWithFormat:@"%@ %@,\n%@ %@/%@ %@",model.addressline1,model.addressline2,model.province,model.country_str,model.city,model.zipcode];
    
    self.defaultImgView.image = [UIImage imageNamed:(model.is_default ? @"address_choose" : @"address_unchoose")];
    
    self.deleteButton.hidden = !self.isEdit;
    [self.editButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.deleteButton.mas_trailing).mas_offset(self.isEdit ? -64 : 0);
    }];
}

#pragma mark - getter

- (UIView *)informView {
    if (!_informView) {
        _informView = [[UIView alloc] initWithFrame:CGRectZero];
        _informView.backgroundColor = ZFCOLOR_WHITE;
    }
    return _informView;
}

- (UIView *)eventView {
    if (!_eventView) {
        _eventView = [[UIView alloc] initWithFrame:CGRectZero];
        _eventView.backgroundColor = ZFCOLOR_WHITE;
    }
    return _eventView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _nameLabel.textColor = ColorHex_Alpha(0x2D2D2D, 1);
    }
    return _nameLabel;
}

- (UILabel *)telphoneLabel {
    if (!_telphoneLabel) {
        _telphoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _telphoneLabel.textColor = ColorHex_Alpha(0x2D2D2D, 1);
        _telphoneLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _telphoneLabel;
}

- (UILabel *)addressInfoLabel {
    if (!_addressInfoLabel) {
        _addressInfoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressInfoLabel.numberOfLines = 0;
        _addressInfoLabel.textColor = ColorHex_Alpha(0x999999, 1);;
        _addressInfoLabel.font =  [UIFont systemFontOfSize:14.0];
    }
    return _addressInfoLabel;
}

- (UIImageView *)defaultImgView {
    if (!_defaultImgView) {
        _defaultImgView = [[UIImageView alloc] init];
        _defaultImgView.image = [UIImage imageNamed:@"address_unchoose"];
    }
    return _defaultImgView;
}

- (UILabel *)defaultAddress {
    if (!_defaultAddress) {
        _defaultAddress = [[UILabel alloc] initWithFrame:CGRectZero];
        _defaultAddress.textColor = ColorHex_Alpha(0x2D2D2D, 1);
        _defaultAddress.font = [UIFont systemFontOfSize:14.0];
        //occ 测试数据
        _defaultAddress.text = @"默认地址";
    }
    return _defaultAddress;
}

- (UIButton *)defaultButton {
    if (!_defaultButton) {
        _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultButton addTarget:self action:@selector(defaultAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultButton;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_editButton setImage:[UIImage imageNamed:@"address_edit"] forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_deleteButton setImage:[UIImage imageNamed:@"address_delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = ColorHex_Alpha(0xDDDDDD, 1.0);
    }
    return _lineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = ColorHex_Alpha(0xDDDDDD, 1.0);
    }
    return _bottomLineView;
}




@end
