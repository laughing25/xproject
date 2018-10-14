//
//  WebViewCollectionViewCell.h
//  TestCollectionView
//
//  Created by 610715 on 2018/9/30.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellProtocol.h"

@protocol WebViewCollectionViewCellDelegate <CollectionCellDelegate>

- (void)WebViewCollectionViewCellReloadHeight:(UICollectionViewCell *)cell height:(CGFloat)height;

@end

@interface WebViewCollectionViewCell : UICollectionViewCell
<
    CollectionCellProtocol
>

@property (nonatomic, weak) id<WebViewCollectionViewCellDelegate>delegate;

@end

