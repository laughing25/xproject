//
//  ProductBranchModel.h
//  XProject
//
//  Created by laughing on 2018/10/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductBranchModel : NSObject

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *class_list;
@property (nonatomic, copy) NSString *class_layer;
@property (nonatomic, copy) NSString *sort_id;
@property (nonatomic, copy) NSString *link_url;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *class_content;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *seo_title;
@property (nonatomic, copy) NSString *seo_keywords;
@property (nonatomic, copy) NSString *seo_description;
@property (nonatomic, copy) NSString *wid;
@property (nonatomic, copy) NSString *ico_url;

@end

NS_ASSUME_NONNULL_END
