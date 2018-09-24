//
//  LoginViewController.h
//  XProject
//
//  Created by MOMO on 2018/9/18.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLBaseViewController.h"

typedef void(^loginResult)(void);

@interface LoginViewController : XLBaseViewController

+(void)presentLoginViewController:(XLBaseViewController *)parentViewController complation:(loginResult)result;
@property (nonatomic, copy) loginResult result;

@end
