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

#import "YSAsingleViewModule.h"
#import "YSEquilateralSquareViewModule.h"

#import "XLCollectionViewBannerCellModel.h"
#import "XLCollectionViewAsingleCellModel.h"

#import "XLProductListViewController.h"

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
    self.locailModel.locailAddSelector(self, @selector(setTitle:), @"Home", nil);
    self.locailModel.locailKey = @"Home";
    
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
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
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
    XLProductListViewController *listVC = [[XLProductListViewController alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark - layout datasource

-(id<CustomerLayoutSectionModuleProtocol>)customerLayoutDatasource:(UICollectionView *)collectionView sectionNum:(NSInteger)section
{
    id<CustomerLayoutSectionModuleProtocol>module = self.dataList[section];
    return module;
}

#pragma mark - cell delegate

-(void)ysCollectionViewBannerCell:(YSCollectionViewBannerCell *)cell jumpModel:(NSObject *)model
{
    
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
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView;
        });
    }
    return _collectionView;
}

-(NSMutableArray<id<CustomerLayoutSectionModuleProtocol>> *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
        
        XLCollectionViewBannerCellModel *model = [[XLCollectionViewBannerCellModel alloc] init];
        model.dataSource = @[@1,@2,@3,@4];
        YSAsingleViewModule *bannerModule = [[YSAsingleViewModule alloc] init];
        [bannerModule.sectionDataList addObject:model];
        [_dataList addObject:bannerModule];
        
        XLCollectionViewAsingleCellModel *asingleCellModel = [[XLCollectionViewAsingleCellModel alloc] init];
        asingleCellModel.specialIdentifier = [XLTitleCollectionViewCell cellIdentifierl];
        asingleCellModel.dataSource = @[@1];
        YSAsingleViewModule *asingleModule = [[YSAsingleViewModule alloc] init];
        [asingleModule.sectionDataList addObject:asingleCellModel];
        [_dataList addObject:asingleModule];
        
        YSEquilateralSquareViewModule *squareModule = [[YSEquilateralSquareViewModule alloc] init];
        [@[@1,@2,@3,@4,@5,@6,@7,@7] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XLCollectionViewAsingleCellModel *cellModel = [[XLCollectionViewAsingleCellModel alloc] init];
            cellModel.dataSource = obj;
            cellModel.specialIdentifier = [YSTopicCollectionViewCell cellIdentifierl];
            [squareModule.sectionDataList addObject:cellModel];
        }];
        [_dataList addObject:squareModule];
    }
    return _dataList;
}

@end
