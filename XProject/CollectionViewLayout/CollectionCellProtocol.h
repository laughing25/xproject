//
//  CollectionCellProtocol.h
//  TestCollectionView
//
//  Created by 610715 on 2018/5/30.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionDatasourceProtocol.h"

@protocol CollectionCellDelegate <NSObject>

@end

@protocol CollectionCellProtocol <NSObject>

@property (nonatomic, strong) id<CollectionDatasourceProtocol> model;
@property (nonatomic, weak) id<CollectionCellDelegate>delegate;

+(NSString *)cellIdentifierl;

@end
