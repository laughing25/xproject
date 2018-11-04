//
//  XLShouYeViewController.m
//  XProject
//
//  Created by 610715 on 2018/8/13.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLShouYeViewController.h"
#import "CustomerLayout.h"
#import "HomeDataListApi.h"
#import "GainCategoryListApi.h"

#import "AdInfoModel.h"
#import "CategoryModel.h"

#import "YSAsingleViewModule.h"
#import "YSEquilateralSquareViewModule.h"

#import "XLCollectionViewBannerCellModel.h"
#import "XLCollectionViewAsingleCellModel.h"

//#import "ProductListParentViewController.h"
#import "XLProductListViewController.h"
#import "WKWebViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface XLShouYeViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    CustomerLayoutDatasource,
    YSCollectionViewBannerCellDelegate
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<id<CustomerLayoutSectionModuleProtocol>>*dataList;
@end

@implementation XLShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self requestHomeData];
}

#pragma mark - request

-(void)requestHomeData
{
    HomeDataListApi *api = [[HomeDataListApi alloc] initWithPageIndex:@"1" pageSize:@"5"];
    
    GainCategoryListApi *categoryApi = [[GainCategoryListApi alloc] init];
    
    YTKChainRequest *chainRequest = [[YTKChainRequest alloc] init];
    [chainRequest addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [chainRequest addRequest:api callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        @strongify(self)
        NSArray *adModelList = [baseRequest requestResponseArrayData:[AdInfoModel class]];
        XLCollectionViewBannerCellModel *model = [[XLCollectionViewBannerCellModel alloc] init];
        model.dataSource = adModelList;
        YSAsingleViewModule *bannerModule = [[YSAsingleViewModule alloc] init];
        bannerModule.minimumInteritemSpacing = 14;
        [bannerModule.sectionDataList addObject:model];
        [self.dataList addObject:bannerModule];
        
        XLCollectionViewAsingleCellModel *asingleCellModel = [[XLCollectionViewAsingleCellModel alloc] init];
        asingleCellModel.specialIdentifier = [XLHeaderCollectionViewCell cellIdentifierl];
        asingleCellModel.dataSource = @"选择配件";
        YSAsingleViewModule *asingleModule = [[YSAsingleViewModule alloc] init];
        asingleModule.minimumInteritemSpacing = 1;
        [asingleModule.sectionDataList addObject:asingleCellModel];
        [self.dataList addObject:asingleModule];
    }];
    
    [chainRequest addRequest:categoryApi callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        @strongify(self)
        NSArray *categoryList = [baseRequest requestResponseArrayData:[CategoryModel class]];
        YSEquilateralSquareViewModule *squareModule = [[YSEquilateralSquareViewModule alloc] init];
        [squareModule.sectionDataList addObjectsFromArray:categoryList];
        [self.dataList addObject:squareModule];
        [self.collectionView reloadData];
    }];
    
    [chainRequest start];
}

#pragma mark - data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataList count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<CustomerLayoutSectionModuleProtocol>module = self.dataList[section];
    return [module.sectionDataList count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<CustomerLayoutSectionModuleProtocol>sectionModule = self.dataList[indexPath.section];
    id<CollectionDatasourceProtocol>cellModel = sectionModule.sectionDataList[indexPath.row];
    [cellModel registerCollectionView:collectionView indexPath:indexPath specialIdentifier:cellModel.specialIdentifier];
    id<CollectionCellProtocol>cell = [collectionView dequeueReusableCellWithReuseIdentifier:[cellModel CollectionDatasourceCellIdentifier:indexPath] forIndexPath:indexPath];
    cell.model = cellModel;
    cell.delegate = self;
    return (UICollectionViewCell *)cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<CustomerLayoutSectionModuleProtocol>sectionModule = self.dataList[indexPath.section];
    id<CollectionDatasourceProtocol>cellModel = sectionModule.sectionDataList[indexPath.row];
    if ([cellModel isKindOfClass:[CategoryModel class]]) {
        CategoryModel *model = (CategoryModel *)cellModel;
        XLProductListViewController *listVC = [[XLProductListViewController alloc] init];
        listVC.categoryid = [NSString stringWithFormat:@"%@", model.idField];
        listVC.title = model.title;
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

#pragma mark - layout datasource

-(id<CustomerLayoutSectionModuleProtocol>)customerLayoutDatasource:(UICollectionView *)collectionView sectionNum:(NSInteger)section
{
    id<CustomerLayoutSectionModuleProtocol>module = self.dataList[section];
    return module;
}

#pragma mark - cell delegate

-(void)ysCollectionViewBannerCell:(YSCollectionViewBannerCell *)cell jumpModel:(AdInfoModel *)model
{
    WKWebViewController *web = [[WKWebViewController alloc] init];
    web.url = model.link_url;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark - setter and getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = ({
            CustomerLayout *layout = [[CustomerLayout alloc] init];
            layout.dataSource = self;
            
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            collectionView.showsVerticalScrollIndicator = YES;
            collectionView.dataSource = self;
            collectionView.delegate = self;
            collectionView.alwaysBounceVertical = YES;
            collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            collectionView;
        });
    }
    return _collectionView;
}

-(NSMutableArray<id<CustomerLayoutSectionModuleProtocol>> *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
