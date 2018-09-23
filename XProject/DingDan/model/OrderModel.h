

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString * orderNo;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, copy) NSString * addDate;
@property (nonatomic, assign) NSInteger brandid;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString * costPrice;
@property (nonatomic, copy) NSString * descriptionField;
@property (nonatomic, copy) NSString * focusImgUrl;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, copy) NSString * marketPrice;
@property (nonatomic, copy) NSString * productName;
@property (nonatomic, strong) NSArray <ProductAttrModel *>*productattrlist;
@property (nonatomic, copy) NSString * salePrice;
@property (nonatomic, copy) NSString * shortDesc;
@property (nonatomic, copy) NSString * sku;
@property (nonatomic, copy) NSString * specialOffer;
@property (nonatomic, copy) NSString * thumbnailsUrll;

@end