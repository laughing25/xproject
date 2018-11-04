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
#import "CheckOrderApi.h"
#import "ProductModel.h"

#import "YSAsingleViewModule.h"
#import "ProductDetailSkuModule.h"

#import "XLCollectionViewBannerCellModel.h"
#import "ProductDetailCellModel.h"
#import "XLCollectionViewAsingleCellModel.h"
#import "ProductDetailSkuCellModel.h"

#import "WebViewCollectionViewCell.h"
#import "ProductDetailBottomView.h"
#import "LoginViewController.h"

@interface XLProductDetailViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    CustomerLayoutDatasource,
    YSCollectionViewBannerCellDelegate,
    ProductSelectNumCellDelegate,
    WebViewCollectionViewCellDelegate
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<id<CustomerLayoutSectionModuleProtocol>>*dataList;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) ProductDetailBottomView *bottomView;
@property (nonatomic, assign) NSInteger selectNums;
@property (nonatomic, strong) CustomerLayout *layout;
@end

@implementation XLProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.locailModel.locailAddSelector(self, @selector(setTitle:), @"商品详情", nil);
    self.locailModel.locailKey = @"Home";
    self.selectNums = 1;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-49);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.leading.trailing.mas_equalTo(self.view);
    }];

    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(25);
        make.leading.mas_equalTo(self.view).mas_offset(10);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self requestProductDetail];
}

-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - request

-(void)requestProductDetail
{
    self.productId = @"27";
    GainProductDetailApi *api = [[GainProductDetailApi alloc] initWithProductId:self.productId];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        if ([request requestSuccess]) {
            id params = [request requestResponseData];
            if ([params isKindOfClass:[NSArray class]]) {
                NSArray *list = (NSArray *)params;
                params = list.firstObject;
            }
            
            ProductModel *productModel = [ProductModel yy_modelWithJSON:params];
            self.bottomView.model = productModel;

            [self.dataList removeAllObjects];
            
            XLCollectionViewBannerCellModel *model = [[XLCollectionViewBannerCellModel alloc] init];
            model.dataSource = productModel;
            YSAsingleViewModule *bannerModule = [[YSAsingleViewModule alloc] init];
            [bannerModule.sectionDataList addObject:model];
            [self.dataList addObject:bannerModule];
            
            YSAsingleViewModule *nameModule = [[YSAsingleViewModule alloc] init];
            ProductDetailCellModel *detailCellModel = [[ProductDetailCellModel alloc] init];
            detailCellModel.dataSource = productModel;
            detailCellModel.specialIdentifier = [ProductDetailNameCell cellIdentifierl];
            [nameModule.sectionDataList addObject:detailCellModel];
            [self.dataList addObject:nameModule];
            
//            YSAsingleViewModule *skuModule = [[YSAsingleViewModule alloc] init];
//            skuModule.minimumInteritemSpacing = 1;
//            ProductDetailCellModel *skuCellModel = [[ProductDetailCellModel alloc] init];
//            skuCellModel.dataSource = productModel;
//            skuCellModel.specialIdentifier = [ProductSKUCell cellIdentifierl];
//            [skuModule.sectionDataList addObject:skuCellModel];
//            [self.dataList addObject:skuModule];
            
//            YSAsingleViewModule *selectModule = [[YSAsingleViewModule alloc] init];
//            ProductDetailCellModel *selectCellModel = [[ProductDetailCellModel alloc] init];
//            selectCellModel.dataSource = productModel;
//            selectCellModel.specialIdentifier = [ProductSelectNumCell cellIdentifierl];
//            [selectModule.sectionDataList addObject:selectCellModel];
//            [self.dataList addObject:selectModule];
            for (int i = 0; i < 5; i++) {
                ProductDetailSkuModule *skuModule = [[ProductDetailSkuModule alloc] init];
                skuModule.minimumInteritemSpacing = 10;
                for (int j = 0; j < 5; j++) {
                    NSInteger random = arc4random()%10 + 5;
                    ProductDetailSkuCellModel *cellModel = [[ProductDetailSkuCellModel alloc] init];
                    cellModel.specialIdentifier = NSStringFromClass(ProductSkuCollectionViewCell.class);
                    NSString *sku = @"这是一个SKU这是一个SKU这是一个SKU这是一个SKU这是一个SKU这是一个SKU";
                    cellModel.skuName = [sku substringWithRange:NSMakeRange(0, random)];
                    [skuModule.sectionDataList addObject:cellModel];
                }
                [self.dataList addObject:skuModule];
            }

            XLCollectionViewAsingleCellModel *asingleCellModel = [[XLCollectionViewAsingleCellModel alloc] init];
            asingleCellModel.specialIdentifier = [XLTitleCollectionViewCell cellIdentifierl];
            TitleModel *titleModel = [[TitleModel alloc] init];
            titleModel.title = @"详情描述";
            titleModel.alignment = NSTextAlignmentCenter;
            asingleCellModel.dataSource = titleModel;
            YSAsingleViewModule *asingleModule = [[YSAsingleViewModule alloc] init];
            [asingleModule.sectionDataList addObject:asingleCellModel];
            [self.dataList addObject:asingleModule];
            
            YSAsingleViewModule *webModule = [[YSAsingleViewModule alloc] init];
            ProductDetailCellModel *webCellModel = [[ProductDetailCellModel alloc] init];
            webCellModel.specialIdentifier = NSStringFromClass([WebViewCollectionViewCell class]);
            webCellModel.dataSource = productModel;
            [webModule.sectionDataList addObject:webCellModel];
            [self.dataList addObject:webModule];
            
            [self.collectionView reloadData];
        }else{
            NSLog(@"%@", [request requestResponseData]);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)buyNow
{
    if ([[AccountManager shareInstance] isLogin]) {
        NSArray *list = @[@{@"ProductID":self.bottomView.model.productId,
                            @"Price":self.bottomView.model.salePrice,
                            @"Quantity":[NSString stringWithFormat:@"%ld", self.selectNums]}];
        CheckOrderApi *api = [[CheckOrderApi alloc] initWithProductId:list];
        [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            if ([request requestSuccess]) {
                [request showToaster:@"下单成功"];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }else{
        [LoginViewController presentLoginViewController:self complation:^{}];
    }
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
    if ([cellModel isKindOfClass:[ProductDetailSkuCellModel class]]) {
        [sectionModule.sectionDataList enumerateObjectsUsingBlock:^(id<CollectionDatasourceProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductDetailSkuCellModel *skuModel = (ProductDetailSkuCellModel *)obj;
            if (idx == indexPath.row) {
                skuModel.isSelect = YES;
            }else{
                skuModel.isSelect = NO;
            }
        }];
        [self.layout reloadSection:indexPath.section];
        [collectionView reloadData];
        return;
    }
}

#pragma mark - layout datasource

-(id<CustomerLayoutSectionModuleProtocol>)customerLayoutDatasource:(UICollectionView *)collectionView sectionNum:(NSInteger)section
{
    id<CustomerLayoutSectionModuleProtocol>module = self.dataList[section];
    return module;
}

#pragma mark - cell delegate

-(void)ProductSelectNumCellSelectNums:(NSInteger)num
{
    self.selectNums = num;
}

-(void)WebViewCollectionViewCellReloadHeight:(UICollectionViewCell *)cell height:(CGFloat)height
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    id<CustomerLayoutSectionModuleProtocol>sectionModule = self.dataList[indexPath.section];
    id<CollectionDatasourceProtocol>cellModel = sectionModule.sectionDataList[indexPath.row];
    if ([cellModel isKindOfClass:[ProductDetailCellModel class]]) {
        ProductDetailCellModel *productCellModel = (ProductDetailCellModel *)cellModel;
        productCellModel.modelSize = CGSizeMake(KScreenWidth, height);
        [self.layout reloadSection:indexPath.section];
        [self.collectionView reloadData];
    }    
}

#pragma mark - setter and getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = ({
            CustomerLayout *layout = [[CustomerLayout alloc] init];
            layout.dataSource = self;
            self.layout = layout;
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            collectionView.showsVerticalScrollIndicator = YES;
            collectionView.dataSource = self;
            collectionView.delegate = self;
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
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

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = ({
            UIButton *button = [[UIButton alloc] init];
            [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            button;
        });
    }
    return _backButton;
}

-(ProductDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[ProductDetailBottomView alloc] init];
        _bottomView.hidden = YES;
        @weakify(self)
        _bottomView.buyBlock = ^{
            @strongify(self)
            [self buyNow];
        };
    }
    return _bottomView;
}

@end
