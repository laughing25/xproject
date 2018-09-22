//
//  YSAsingleCollectionViewCell.h
//  YoshopPro
//
//  Created by 610715 on 2018/5/31.
//  Copyright © 2018年 yoshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionDatasourceProtocol.h"
#import "CollectionCellProtocol.h"

@interface YSAsingleCollectionViewCell : UICollectionViewCell
<
    CollectionCellProtocol
>
@end
