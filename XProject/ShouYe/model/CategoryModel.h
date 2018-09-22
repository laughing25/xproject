#import <UIKit/UIKit.h>
#import "CollectionDatasourceProtocol.h"

@interface CategoryModel : NSObject
<
    CollectionDatasourceProtocol
>
@property (nonatomic, copy) NSString * classContent;
@property (nonatomic, assign) NSInteger classLayer;
@property (nonatomic, copy) NSString * classList;
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * icoUrl;
@property (nonatomic, copy) NSString *idField;
@property (nonatomic, copy) NSString * imgUrl;
@property (nonatomic, copy) NSString * linkUrl;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * seoDescription;
@property (nonatomic, copy) NSString * seoKeywords;
@property (nonatomic, copy) NSString * seoTitle;
@property (nonatomic, assign) NSInteger sortId;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) NSInteger wid;
@end
