//
//  ProductSelectNumCell.h
//  XProject
//
//  Created by MOMO on 2018/9/20.
//  Copyright © 2018年 610715. All rights reserved.
//  选择数量cell

#import <UIKit/UIKit.h>
#import "CollectionCellProtocol.h"

@protocol ProductSelectNumCellDelegate <CollectionCellDelegate>

- (void)ProductSelectNumCellSelectNums:(NSInteger)num;

@end

@interface ProductSelectNumCell : UICollectionViewCell
<
    CollectionCellProtocol
>

@property (nonatomic, weak) id<ProductSelectNumCellDelegate>delegate;

@end
