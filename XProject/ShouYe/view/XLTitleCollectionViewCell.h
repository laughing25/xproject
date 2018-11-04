//
//  XLTitleCollectionViewCell.h
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellProtocol.h"
#import "CollectionDatasourceProtocol.h"

@interface XLTitleCollectionViewCell : UICollectionViewCell
<
    CollectionCellProtocol
>
@end

@interface TitleModel : NSObject

@property (nonatomic, assign) NSTextAlignment alignment;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
