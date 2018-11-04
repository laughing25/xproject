//
//  CustomerBackgroundReusableView.m
//  XProject
//
//  Created by laughing on 2018/11/3.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "CustomerBackgroundReusableView.h"
#import "CustomerBackgroundAttributes.h"

@implementation CustomerBackgroundReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[CustomerBackgroundAttributes class]]) {
        CustomerBackgroundAttributes *attr = (CustomerBackgroundAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}

@end
