//
//  CustomerMathTools.h
//  TestCollectionView
//
//  Created by 610715 on 2018/5/29.
//  Copyright © 2018年 610715. All rights reserved.
//  一些简单的计算合计

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomerMathTools : NSObject

///从高度集合里面找出最短的那一个
+ (NSUInteger)shortestColumnIndex:(NSArray *)heights;

///从高度集合里面找出最长的那一个
+ (NSUInteger)longestColumnIndex:(NSArray *)heights;

@end
