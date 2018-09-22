//
//  ProductListParentViewController.m
//  XProject
//
//  Created by 610715 on 2018/9/22.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "ProductListParentViewController.h"
#import "WMPageController.h"
#import "XLProductListViewController.h"
#import "CategoryModel.h"
#import "UIViewController+CWLateralSlide.h"
#import "XLProductListSlideViewController.h"

@interface ProductListParentViewController ()
<
    WMPageControllerDelegate,
    WMPageControllerDataSource,
    XLProductListSlideViewControllerDelegate
>
@property (nonatomic, strong) WMPageController *pageController;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ProductListParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
    //more button
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNavBtn setFrame:CGRectMake(0, 0, NavBarButtonSize, NavBarButtonSize)];
    [rightNavBtn setBackgroundColor:[UIColor redColor]];
    [rightNavBtn addTarget:self action:@selector(rightSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItems = @[buttonItem];
}

- (void)requestData
{
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dataArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    CategoryModel *model = self.dataArray[index];
    return model.title;
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForContentView:(nonnull WMScrollView *)contentView {
    CGRect rect = CGRectMake(0, 44, self.view.mj_w, self.view.mj_h - 44);
    return rect;
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForMenuView:(nonnull WMMenuView *)menuView {
    return CGRectMake(0, 0, self.view.mj_w, 44);
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    XLProductListViewController *list = [[XLProductListViewController alloc] init];
    list.categoryid = @"10";
    return list;
}

#pragma mark - target

-(void)rightSearchBtnClick:(UIButton *)sender
{
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight;
    conf.showAnimDuration = .3f;
    
    XLProductListSlideViewController *vc = [[XLProductListSlideViewController alloc] init];
    vc.delegate = self;
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:conf];
}

-(void)XLProductListSlideViewControllerDidClick:(BranchModel *)model
{
    
}

-(WMPageController *)pageController
{
    if (!_pageController) {
        _pageController = [[WMPageController alloc] initWithViewControllerClasses:@[[XLProductListViewController class]] andTheirTitles:@[@"iphone6"]];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.titleSizeNormal    = 16.0f;
        _pageController.titleSizeSelected  = 16.0f;
        _pageController.menuViewStyle      = WMMenuViewStyleLine;
        _pageController.itemMargin         = 20.0f;
        _pageController.titleColorSelected = ZFCOLOR(183, 96, 42, 1.0);
        _pageController.titleColorNormal   = ZFCOLOR(51, 51, 51, 1.0);
        _pageController.progressColor      = ZFCOLOR(183, 96, 42, 1.0);
        _pageController.progressHeight     = 3.0f;
        _pageController.automaticallyCalculatesItemWidths = YES;
    }
    return _pageController;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        for (int i = 0; i < 10; i++) {
            NSString *title = [NSString stringWithFormat:@"iphone%d", i];
            CategoryModel *model = [[CategoryModel alloc] init];
            model.title = title;
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

@end
