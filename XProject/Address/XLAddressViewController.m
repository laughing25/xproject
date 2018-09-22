//
//  ZFAddressViewController.m
//  Zaful
//
//  Created by liuxi on 2017/8/29.
//  Copyright © 2017年 Y001. All rights reserved.
//

#import "XLAddressViewController.h"
#import "ZFBottomToolView.h"
//#import "ZFAddressEditViewController.h"
#import "ZFAddressListTableViewCell.h"
#import "XLAddressDetailViewController.h"
//#import "ZFAddressInfoModel.h"
//#import "ZFAddressViewModel.h"
//#import "UIView+Subviews.h"

static NSString *const kZFAddressListTableViewCellIdentifier = @"kZFAddressListTableViewCellIdentifier";

@interface XLAddressViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger                             currentSelectIndex;
@property (nonatomic, strong) UITableView                           *tableView;
@property (nonatomic, strong) ZFBottomToolView                      *addAddressView;
//@property (nonatomic, strong) ZFAddressViewModel                    *viewModel;
@property (nonatomic, strong) NSMutableArray<ZFAddressInfoModel *>  *dataArray;
@end

@implementation XLAddressViewController

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self zfInitView];
    [self zfAutoLayoutView];
    [self requestLocalLocationInfoOption];
}


#pragma mark -===========UI 相关===========

#pragma mark  <ZFInitViewProtocol>
- (void)zfInitView {
    self.title = @"Address_VC_Title";
    self.view.backgroundColor = ColorHex_Alpha(0xF7F7F7, 1.0);
    
    if (self.showType == AddressInfoShowTypeCart) {
        
        //关闭按钮
        NSString *close = @"CartOrderInfo_Address_List_Close";
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:close style:UIBarButtonItemStyleDone target:self action:@selector(closeButtonAction:)];
        self.navigationItem.leftBarButtonItem = closeItem;
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addAddressView];
}

- (void)zfAutoLayoutView {
    
    [self.addAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kiphoneXHomeBarHeight);
        make.height.mas_equalTo(64);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.addAddressView.mas_top);
    }];
}

- (void)updateAddAddressLayoutWithCanAdd:(BOOL)canAdd {
    self.addAddressView.hidden = YES;
    if (canAdd) {
        self.addAddressView.hidden = NO;
        [self.addAddressView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(64);
        }];
        
//        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.addAddressView.mas_top).mas_offset(-10);
//        }];
        
    } else {
        [self.addAddressView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
//        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.addAddressView.mas_top);
//        }];
    }
}

#pragma mark - ===========编辑操作===========

#pragma mark  action methods

- (void)closeButtonAction:(id)sender {
//    @weakify(self);
//    if (self.dataArray.count <= self.currentSelectIndex) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//        return;
//    }
//
//    ZFAddressInfoModel *model = self.dataArray[self.currentSelectIndex];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.currentSelectIndex];
//    [self selectDefaulAddressWithAddressId:model.address_id andIndexPath:indexPath completion:^(BOOL success){
//        @strongify(self);
//        // 退出时不管成功失败都返回
//        if (self.addressChooseCompletionHandler) {
//            self.addressChooseCompletionHandler(self.dataArray[indexPath.section]);
//        }
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
}

/**
 * 进入编辑地址页面
 */
- (void)editAddressAction:(ZFAddressInfoModel *)model{
//    @weakify(self)
//    ZFAddressEditViewController *addressEditVC = [[ZFAddressEditViewController alloc] init];
//    if (model) {
//        addressEditVC.title = ZFLocalizedString(@"ModifyAddress_Edit_VC_title",nil);
//        addressEditVC.model = model;
//    } else {
//        addressEditVC.title = ZFLocalizedString(@"Modify_Address_VC_Title",nil);
//    }
//
//    addressEditVC.addressEditSuccessCompletionHandler = ^{
//        @strongify(self);
//        [self.tableView.mj_header beginRefreshing];
//    };
//    [self.navigationController pushViewController:addressEditVC animated:YES];
}


#pragma mark - ===========请求地址数据===========

- (void)requestLocalLocationInfoOption {
//    [self.viewModel requestAddressLocationInfoNetwork:nil completion:nil];
}

- (void)selectDefaulAddressWithAddressId:(NSString *)addressId
                            andIndexPath:(NSIndexPath *)indexPath
                              completion:(void (^)(BOOL success))completion
{
//    NSDictionary *dict = @{@"address_id" : addressId,
//                           kLoadingView  : self.view };
//    @weakify(self);
//    [self.viewModel requestsetDefaultAddressNetwork:dict completion:^(BOOL isOK) {
//        @strongify(self);
//        if (!isOK) {
//            if (completion) {
//                completion(NO);
//            }
//            return ;
//        }
//        ZFAddressInfoModel *selectModel = self.dataArray[indexPath.section];
//        selectModel.is_default = YES;
//        self.dataArray[indexPath.section] = selectModel;
//        ZFAddressInfoModel *currentSelectModel = self.dataArray[self.currentSelectIndex];
//        currentSelectModel.is_default = NO;
//        self.dataArray[self.currentSelectIndex] = currentSelectModel;
//        self.currentSelectIndex = indexPath.section;
//        [self.tableView reloadData];
//        if (completion) {
//            completion(YES);
//        }
//    }];
}

- (void)requestDeleteAddressData:(ZFAddressInfoModel *)model dalteindexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *dict = @{@"address_id" : model.address_id,
//                           kLoadingView  : self.view };
//    @weakify(self);
//    [self.viewModel requestDeleteAddressNetwork:dict completion:^(BOOL isOK) {
//        @strongify(self);
//        if (isOK && indexPath.section < self.dataArray.count) {
//            [self.dataArray removeObjectAtIndex:indexPath.section];
//            [self updateAddAddressLayoutWithCanAdd:(self.dataArray.count < 5)];
//        }
//        [self.tableView showRequestTip:@{}];
//        [self.tableView reloadData];
//
//        // 每次删除地址后重新请求地址列表
//        [self.tableView.mj_header beginRefreshing];
//    }];
}

- (void)dealWithAddressEditSelectCompletion:(ZFAddressInfoModel *)model event:(ZFAddressListCellEvent)event indexPath:(NSIndexPath *)indexPath {
    XLAddressDetailViewController *vc = [[XLAddressDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    if (self.showType == AddressInfoShowTypeCart
//        && event == ZFAddressListCellEventSelect) { //结算页 选择地址
//        @weakify(self)
//        [self selectDefaulAddressWithAddressId:model.address_id
//                                  andIndexPath:indexPath
//                                    completion:^(BOOL success){
//                                        @strongify(self);
//                                        if (success) {
//                                            if (self.addressChooseCompletionHandler) {
//                                                self.addressChooseCompletionHandler(self.dataArray[indexPath.section]);
//                                            }
//                                            [self dismissViewControllerAnimated:YES completion:nil];
//                                        }
//                                    }];
//
//    } else if(event == ZFAddressListCellEventDefault
//              && self.showType != AddressInfoShowTypeCart
//              && !model.is_default) {//默认地址,不能取消
//        @weakify(self)
//        [self selectDefaulAddressWithAddressId:model.address_id
//                                  andIndexPath:indexPath
//                                    completion:^(BOOL success){
//                                        @strongify(self)
//                                        //occ测试数据
//                                        ShowToastToViewWithText(self.view, ZFLocalizedString(@"Edited successfully",nil));
//                                    }];
//
//    } else if(event == ZFAddressListCellEventEdit) {//编辑地址
//        [self editAddressAction:model];
//
//    } else if(event == ZFAddressListCellEventDelete) {//删除地址
//
//        if (self.dataArray.count > 1) {
//
//            //occ测试数据
//            NSString *title = ZFLocalizedString(@"Are you sure to delete this item?",nil);
//            NSArray *btnArr = @[ZFLocalizedString(@"Account_VC_SignOut_Alert_Yes",nil)];
//            NSString *cancelTitle = ZFLocalizedString(@"Account_VC_SignOut_Alert_No",nil);
//
//            ShowAlertView(title, nil, btnArr, ^(NSInteger buttonIndex, id title) {
//                [self requestDeleteAddressData:model dalteindexPath:indexPath];
//            }, cancelTitle, nil);
//
//        } else {
//
//            //occ测试数据
//            NSString *title = ZFLocalizedString(@"You can’t delete all dress.You need an address to accept your goods",nil);
//            NSString *cancelTitle = ZFLocalizedString(@"SettingViewModel_Cache_Alert_OK",nil);
//            ShowAlertSingleBtnView(nil, title, cancelTitle);
//        }
//    }
}

- (void)requestAddressListData {
//    @weakify(self)
//    [self.viewModel requestAddressListNetwork:nil completion:^(id obj) {
//        @strongify(self);
//        self.dataArray = obj;
//        [self updateAddAddressLayoutWithCanAdd:(self.dataArray.count < 5)];
//        [self.tableView reloadData];
//        [self.tableView showRequestTip:@{}];
//
//    } failure:^(id obj) {
//        @strongify(self);
//        [self.tableView reloadData];
//        [self.tableView showRequestTip:nil];
//    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] init];
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFAddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kZFAddressListTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BOOL isEdit = self.showType == AddressInfoShowTypeCart ? NO : YES;
    [cell updateInfoModel:self.dataArray[indexPath.section] edit:isEdit];
    
    if (self.dataArray[indexPath.section].is_default) {
        self.currentSelectIndex = indexPath.section;
    }
    
    @weakify(self);
    cell.addressEditSelectCompletionHandler = ^(ZFAddressInfoModel *model, ZFAddressListCellEvent event) {
        @strongify(self);
        [self dealWithAddressEditSelectCompletion:model event:event indexPath:indexPath];
    };
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == self.dataArray.count - 1 ? 10 : CGFLOAT_MIN;
}


#pragma mark - setter
- (void)setShowType:(AddressInfoShowType)showType {
    _showType = showType;
}

#pragma mark - getter
- (NSMutableArray<ZFAddressInfoModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        ZFAddressInfoModel *model = [[ZFAddressInfoModel alloc] init];
        model.firstname = @"张三";
        model.tel = @"1231231";
        model.addressline1 = @"fklsjfkl sdfjklsfjsafjkl fjlk sa";
        model.province = @"province";
        model.city = @"city";
        model.is_default = YES;
        
        [_dataArray addObject:model];
        [_dataArray addObject:model];
        [_dataArray addObject:model];
        [_dataArray addObject:model];
        [_dataArray addObject:model];
    }
    return _dataArray;
}

//- (ZFAddressViewModel *)viewModel {
//    if (!_viewModel) {
//        _viewModel = [[ZFAddressViewModel alloc] init];
//    }
//    return _viewModel;
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 120;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZFAddressListTableViewCell class] forCellReuseIdentifier:kZFAddressListTableViewCellIdentifier];
//        _tableView.emptyDataImage = [UIImage imageNamed:@"blankPage_noAddress"];
        //occ 测试数据
//        _tableView.emptyDataTitle = ZFLocalizedString(@"Oh, you don’t have an address, adding an address now.Only five addresses can be added at most", nil);
//        _tableView.blankPageViewCenter = CGPointMake(KScreenWidth/2, KScreenHeight/3);
        
        //添加刷新控件,请求数据
//        @weakify(self);
//        [_tableView addHeaderRefreshBlock:^{
//            @strongify(self);
//            [self requestAddressListData];
//        } footerRefreshBlock:nil startRefreshing:YES];
    }
    return _tableView;
}

- (ZFBottomToolView *)addAddressView {
    if (!_addAddressView) {
        _addAddressView = [[ZFBottomToolView alloc] initWithFrame:CGRectZero];
        _addAddressView.bottomTitle = @"Address_VC_Add_Address";
        _addAddressView.showTopShadowline = YES;
        _addAddressView.hidden = YES;
        @weakify(self);
        _addAddressView.bottomButtonBlock = ^{
            @strongify(self);
            [self editAddressAction:nil];
        };
    }
    return _addAddressView;
}
@end
