//
//  CustomerMathTools.m
//  TestCollectionView
//
//  Created by 610715 on 2018/5/29.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "CustomerMathTools.h"

@implementation CustomerMathTools

+ (NSUInteger)shortestColumnIndex:(NSArray *)heights {
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;

    [heights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    
    return index;
}

+ (NSUInteger)longestColumnIndex:(NSArray *)heights {
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [heights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = idx;
        }
    }];
    
    return index;
}

@end
