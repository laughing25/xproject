//
//  XLAddressDetailCellModel.h
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    AddressDetailCellType_CanEdit,
    AddressDetailCellType_UnEdit
}AddressDetailCellType;

@interface XLAddressDetailCellModel : NSObject

@property (nonatomic, assign) AddressDetailCellType type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end
