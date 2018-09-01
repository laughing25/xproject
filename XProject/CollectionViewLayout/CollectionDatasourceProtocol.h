//
//  CollectionDatasourceProtocol.h
//  TestCollectionView
//
//  Created by 610715 on 2018/7/26.
//  Copyright © 2018年 610715. All rights reserved.
//  数据源模型实现的接口

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CollectionDatasourceProtocol <NSObject>

///可以在这里定制特殊的不重用的identifier
-(NSString *)CollectionDatasourceCellIdentifier:(NSIndexPath *)indexPath;

///这个地方可以自定义返回视图大小， CollectionCell 布局的时候，如果这个参数不为CGSizeZero就会使用这个宽高布局
-(CGSize)dataSourceSize;

///collectionCell 的注册方法
-(void)registerCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

///collectionCell 的注册方法
-(Class)CollectionDatasourceClass;

@end
