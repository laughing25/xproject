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
#import "ProductModel.h"
#import "XLProductListSlideViewController.h"
#import "UIViewController+CWLateralSlide.h"

@interface XLProductListViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    XLProductListSlideViewControllerDelegate
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation XLProductListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.categoryid = @"";
        self.catalogid = @"";
        self.pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    //more button
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNavBtn setFrame:CGRectMake(0, 0, NavBarButtonSize, NavBarButtonSize)];
    [rightNavBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    rightNavBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [rightNavBtn addTarget:self action:@selector(rightSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItems = @[buttonItem];
    
    [self requestProductList];
}

#pragma mark - request

-(void)requestProductList
{
    NSString *index = [NSString stringWithFormat:@"%ld", self.pageIndex];
    GainProductListApi *api = [[GainProductListApi alloc] initWithPageIndex:index categoryid:self.categoryid catalogid:self.catalogid];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        NSArray *dataList = [request requestResponseArrayData:[ProductModel class]];
        if ([dataList count]) {
            self.pageIndex++;
            if ([self.collectionView.mj_header isRefreshing]) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:dataList];
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
        }else{
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLProductDetailViewController *detailVC = [[XLProductDetailViewController alloc] init];
    ProductModel *model = self.dataList[indexPath.row];
    detailVC.productId = model.productId;
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

-(void)XLProductListSlideViewControllerDidClick:(BranchModel *)model
{
    self.categoryid = model.wid;
    self.catalogid = model.branchId;
    [self requestProductList];
}

-(void)headerRefresh:(MJRefreshHeader *)header
{
    self.pageIndex = 1;
    [self requestProductList];
}

-(void)footerRefresh:(MJRefreshFooter *)footer
{
    [self requestProductList];
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
            collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            collectionView.contentInset = UIEdgeInsetsMake(20, 0, 10, 0);
            collectionView.showsVerticalScrollIndicator = NO;
            [collectionView registerClass:[XLProductCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
            
            collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
            
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
            header.ignoredScrollViewContentInsetTop = 15;
            collectionView.mj_header = header;
            
            collectionView;
        });
    }
    return _collectionView;
}

-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
