//
//  ProductModel.h
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductAttrItemModel : NSObject

@property (nonatomic, copy) NSString *AttrValue;
@property (nonatomic, copy) NSString *AttrPrice;

@end

@interface ProductAttrModel : NSObject
@property (nonatomic, copy) NSString *AttrName;
@property (nonatomic, strong) NSArray<ProductAttrItemModel *>*list;
@property (nonatomic, copy) NSString *AttrValue;
@end

@interface ProductModel : NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *brandid;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *shortDesc;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *focusImgUrl;
@property (nonatomic, copy) NSString *thumbnailsUrll;
@property (nonatomic, copy) NSString *costPrice;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *salePrice;
@property (nonatomic, strong) NSArray<ProductAttrModel *>*productattrlist;

@end
