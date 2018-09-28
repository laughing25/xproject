//
//  CityListViewController.h
//  XProject
//
//  Created by MOMO on 2018/9/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLBaseViewController.h"
#import "XLAddressListModel.h"

@protocol CityListViewControllerDelegate <NSObject>

- (void)CityListViewControllerDidSelectCity:(XLAddressListModel *)model;

@end

@interface CityListViewController : XLBaseViewController

@property (nonatomic, weak) id<CityListViewControllerDelegate>delegate;

@end
