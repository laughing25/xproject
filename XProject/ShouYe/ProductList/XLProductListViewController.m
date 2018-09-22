//
//  XLProductListViewController.m
//  XProject
//
//  Created by 610715 on 2018/9/10.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLProductListViewController.h"
#import "XLProductDetailViewController.h"
#import "XLProductCollectionViewCell.h"
#import "GainProductListApi.h"
#import "UIViewController+CWLateralSlide.h"
#import "XLProductListSlideViewController.h"

@interface XLProductListViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    XLProductListSlideViewControllerDelegate
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation XLProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locailModel.locailAddSelector(self, @selector(setTitle:), @"产品", nil);
    self.locailModel.locailKey = @"产品";
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    //more button
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNavBtn setFrame:CGRectMake(0, 0, NavBarButtonSize, NavBarButtonSize)];
    [rightNavBtn setBackgroundColor:[UIColor redColor]];
    [rightNavBtn addTarget:self action:@selector(rightSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItems = @[buttonItem];
}

#pragma mark - request

-(void)requestProductList
{
    GainProductListApi *api = [[GainProductListApi alloc] initWithPageIndex:@"1" categoryid:self.categoryid catalogid:self.catalogid];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    return [self.dataList count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLProductDetailViewController *detailVC = [[XLProductDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
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

-(void)XLProductListSlideViewControllerDidClick
{
    
}

#pragma mark - setter and getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(KScreenWidth - 30, 100);
            layout.minimumLineSpacing = 10;
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            collectionView.showsVerticalScrollIndicator = YES;
            collectionView.dataSource = self;
            collectionView.delegate = self;
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.contentInset = UIEdgeInsetsMake(20, 0, 10, 0);
            [collectionView registerClass:[XLProductCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
            collectionView;
        });
    }
    return _collectionView;
}


@end
