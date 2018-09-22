//
//  XLProductListSlideViewController.h
//  XProject
//
//  Created by MOMO on 2018/9/21.
//  Copyright © 2018年 610715. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BranchModel.h"

@protocol XLProductListSlideViewControllerDelegate <NSObject>

-(void)XLProductListSlideViewControllerDidClick:(BranchModel *)model;

@end

@interface XLProductListSlideViewController : UIViewController

@property (nonatomic, weak) id<XLProductListSlideViewControllerDelegate>delegate;

@end
