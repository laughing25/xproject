//
//  ProductDetailModel.h
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *shortDesc;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *thumbnailsUrll;
@property (nonatomic, copy) NSString *costPrice;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *salePrice;
@property (nonatomic, copy) NSString *AttrName;
@property (nonatomic, copy) NSString *AttrValue;

@end
