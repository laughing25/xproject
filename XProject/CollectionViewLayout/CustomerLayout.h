//
//  CustomerLayout.h
//  TestCollectionView
//
//  Created by 610715 on 2018/5/26.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerLayoutSectionModuleProtocol.h"

@protocol CustomerLayoutDatasource <NSObject>

-(id<CustomerLayoutSectionModuleProtocol>)customerLayoutDatasource:(UICollectionView *)collectionView sectionNum:(NSInteger)section;

@optional;
-(CGFloat)customerLayoutSectionHeight:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout indexPath:(NSIndexPath *)indexPath;

-(void)customerLayoutContentSizeHeight:(CGFloat)height;

@end

@interface CustomerLayout : UICollectionViewLayout

@property (nonatomic, weak) id<CustomerLayoutDatasource>dataSource;

-(CGFloat)maxContentOffsetY;

@end
