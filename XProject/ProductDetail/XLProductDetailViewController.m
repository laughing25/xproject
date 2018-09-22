//
//  XLProductDetailViewController.m
//  XProject
//
//  Created by 610715 on 2018/9/10.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLProductDetailViewController.h"
#import "CustomerLayout.h"
#import "GainProductDetailApi.h"

#import "YSAsingleViewModule.h"

#import "XLCollectionViewBannerCellModel.h"
#import "ProductDetailCellModel.h"

@interface XLProductDetailViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    CustomerLayoutDatasource,
    YSCollectionViewBannerCellDelegate
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<id<CustomerLayoutSectionModuleProtocol>>*dataList;
@end

@implementation XLProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locailModel.locailAddSelector(self, @selector(setTitle:), @"Home", nil);
    self.locailModel.locailKey = @"Home";
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - request

-(void)requestProductDetail
{
    GainProductDetailApi *api = [[GainProductDetailApi alloc] initWithProductId:self.productId];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
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
        
        YSAsingleViewModule *nameModule = [[YSAsingleViewModule alloc] init];
        ProductDetailCellModel *detailCellModel = [[ProductDetailCellModel alloc] init];
        detailCellModel.specialIdentifier = [ProductDetailNameCell cellIdentifierl];
        [nameModule.sectionDataList addObject:detailCellModel];
        [_dataList addObject:nameModule];
        
        YSAsingleViewModule *skuModule = [[YSAsingleViewModule alloc] init];
        skuModule.minimumInteritemSpacing = 2;
        ProductDetailCellModel *skuCellModel = [[ProductDetailCellModel alloc] init];
        skuCellModel.specialIdentifier = [ProductSKUCell cellIdentifierl];
        [skuModule.sectionDataList addObject:skuCellModel];
        [_dataList addObject:skuModule];
        
        YSAsingleViewModule *selectModule = [[YSAsingleViewModule alloc] init];
        ProductDetailCellModel *selectCellModel = [[ProductDetailCellModel alloc] init];
        selectCellModel.specialIdentifier = [ProductSelectNumCell cellIdentifierl];
        [selectModule.sectionDataList addObject:selectCellModel];
        [_dataList addObject:selectModule];
    }
    return _dataList;
}

@end
