//
//  ProductRemarksCell.h
//  XProject
//
//  Created by laughing on 2019/3/26.
//  Copyright © 2019年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellProtocol.h"

@protocol ProductRemarksCellDelegate <CollectionCellDelegate>

- (void)ProductRemarksCellDidDoneInputText:(NSString *)text;

@end

@interface ProductRemarksCell : UICollectionViewCell
<
    CollectionCellProtocol
>
@property (nonatomic, weak) id<ProductRemarksCellDelegate>delegate;
@end

@interface ProductRemarksModel : NSObject

@property (nonatomic, copy) NSString *remakrContent;

@end

