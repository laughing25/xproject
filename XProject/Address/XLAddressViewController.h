//
//  ZFAddressViewController.h
//  Zaful
//
//  Created by liuxi on 2017/8/29.
//  Copyright © 2017年 Y001. All rights reserved.
//

#import "XLBaseViewController.h"
#import "ZFAddressInfoModel.h"

typedef NS_ENUM(NSInteger, AddressInfoShowType) {
    AddressInfoShowTypeAccount = 0,
    AddressInfoShowTypeCart
};

typedef void(^AddressChooseCompletionHandler)(ZFAddressInfoModel *model);

@interface XLAddressViewController : XLBaseViewController

@property (nonatomic, copy) AddressChooseCompletionHandler      addressChooseCompletionHandler;

@property (nonatomic, assign) AddressInfoShowType               showType;

@end
