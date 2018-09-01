//
//  ZFAddressListTableViewCell.h
//  Zaful
//
//  Created by liuxi on 2017/8/29.
//  Copyright © 2017年 Y001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFAddressInfoModel;

typedef NS_ENUM(NSInteger, ZFAddressListCellEvent){
    ZFAddressListCellEventDefault,
    ZFAddressListCellEventEdit,
    ZFAddressListCellEventDelete,
    ZFAddressListCellEventSelect
};

typedef void(^AddressEditSelectCompletionHandler)(ZFAddressInfoModel *model,ZFAddressListCellEvent event);

@interface ZFAddressListTableViewCell : UITableViewCell

@property (nonatomic, strong) ZFAddressInfoModel        *model;

@property (nonatomic, assign) BOOL                      isEdit;

- (void)updateInfoModel:(ZFAddressInfoModel *)model edit:(BOOL)isEdit;

@property (nonatomic, copy) AddressEditSelectCompletionHandler          addressEditSelectCompletionHandler;

@end
