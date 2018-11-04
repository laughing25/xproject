//
//  CustomerBackgroundAttributes.h
//  XProject
//
//  Created by laughing on 2018/11/3.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerBackgroundAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, assign) CGFloat  bottomOffset;

@end

NS_ASSUME_NONNULL_END
