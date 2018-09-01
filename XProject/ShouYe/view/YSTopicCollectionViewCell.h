//
//  YSTopicCollectionViewCell.h
//  YoshopPro
//
//  Created by 610715 on 2018/7/9.
//  Copyright © 2018年 yoshop. All rights reserved.
//  多个分类的cell

#import <UIKit/UIKit.h>
#import "CollectionCellProtocol.h"
#import "CollectionDatasourceProtocol.h"

@interface YSTopicCollectionViewCell : UICollectionViewCell
<
    CollectionCellProtocol
>
@end
