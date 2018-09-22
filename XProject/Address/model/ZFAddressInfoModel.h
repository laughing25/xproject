//
//  ZFAddressInfoModel.h
//  Zaful
//
//  Created by liuxi on 2017/8/29.
//  Copyright © 2017年 Y001. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ZFAddressInfoModel : NSObject <NSMutableCopying>

@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *code;//区号
@property (nonatomic, copy) NSString *country_id;
@property (nonatomic, copy) NSString *country_str; // ????
@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *id_card;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *addressline1;
@property (nonatomic, copy) NSString *addressline2;
@property (nonatomic, copy) NSString *landmark;
@property (nonatomic, copy) NSString *telspare;
@property (nonatomic, copy) NSString *whatsapp;
@property (nonatomic, copy) NSString *supplier_number_spare;
@property (nonatomic, assign) BOOL    is_cod;
@property (nonatomic, strong) NSArray *supplier_number_list; //运营商号列表
@property (nonatomic, copy) NSString *supplier_number;      //当前运营商号

//手机号码最大位数 <V3.5.0废弃>
//@property (nonatomic, copy) NSString *number;
// 可支持的剩余号码最大长度, 多个长度 <V3.5.0新增>
@property (nonatomic, strong) NSArray *scut_number_list;
@property (nonatomic, strong) NSString *maxPhoneLength; //最大兼容数固定20位, 非服务端返回, 本地写死的

@property (nonatomic, assign) BOOL is_default;              //是否是默认邮寄地址 [0-否，1-是]
@property (nonatomic, assign) BOOL ownState;
@property (nonatomic, assign) BOOL ownCity;
@property (nonatomic, assign) BOOL configured_number;   //1 是后台设置的 判断就直接 =  0未设置的就是 <=
@property (nonatomic, copy) NSString    *google_longitude;//google_longitude:google地图经度
@property (nonatomic, copy) NSString    *google_latitude;//google_latitude:google地图纬度

@end
