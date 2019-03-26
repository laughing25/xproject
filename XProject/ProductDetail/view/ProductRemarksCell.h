//
//  ProductRemarksCell.h
//  XProject
//
//  Created by laughing on 2019/3/26.
//  Copyright © 2019年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductRemarksCell : UICollectionViewCell
<
    CollectionCellProtocol
>
@end

@interface ProductRemarksModel : NSObject

@property (nonatomic, copy) NSString *remakrContent;

@end

NS_ASSUME_NONNULL_END
