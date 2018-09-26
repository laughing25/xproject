//
//  YSCollectionViewBannerCell.h
//  YoshopPro
//
//  Created by 610715 on 2018/5/30.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellProtocol.h"
#import "CollectionDatasourceProtocol.h"
#import "AdInfoModel.h"

@class YSCollectionViewBannerCell;

@protocol YSCollectionViewBannerCellDelegate<CollectionCellDelegate>
@optional
- (void)ysCollectionViewBannerCell:(YSCollectionViewBannerCell *)cell jumpModel:(AdInfoModel *)model;

@end

@interface YSCollectionViewBannerCell : UICollectionViewCell
<
    CollectionCellProtocol
>

@property (nonatomic, weak) id<YSCollectionViewBannerCellDelegate>delegate;

@end
