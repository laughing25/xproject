//
//  XLAddressDetailViewController.m
//  XProject
//
//  Created by 610715 on 2018/8/16.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLAddressDetailViewController.h"
#import "XLAddressDetailTableViewCell.h"
#import "ZFBottomToolView.h"
#import "GainUserInfoApi.h"
#import "ChangeInfoApi.h"
#import "XLAddressDetailInfoModel.h"
#import "XLAddressListModel.h"
#import "CityListViewController.h"

@interface XLAddressDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    CityListViewControllerDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <XLAddressDetailCellModel *>*dataList;
@property (nonatomic, strong) ZFBottomToolView *addAddressView;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) XLAddressDetailInfoModel *infoModel;
@property (nonatomic, strong) NSArray *cityList;
@property (nonatomic, strong) UIPickerView *pickerView;
@end

@implementation XLAddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locailModel.locailAddSelector(self, @selector(setTitle:), @"我的信息", nil);
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];
    self.cityList = [[NSArray alloc] init];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomButton.mas_top);
    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_offset(44);
    }];
    
    [self requestUserInfoData];
}

#pragma mark - request

-(void)requestUserInfoData
{
    GainUserInfoApi *api = [[GainUserInfoApi alloc] init];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        if ([request requestSuccess]) {
            XLAddressDetailInfoModel *infoModel = [XLAddressDetailInfoModel yy_modelWithJSON:[request requestResponseData]];
            self.infoModel = infoModel;
            XLAddressDetailCellModel *cellModel = [[XLAddressDetailCellModel alloc] init];
            cellModel.title = @"名字";
            cellModel.content = infoModel.user_name;
            cellModel.type = AddressDetailCellType_CanEdit;
            cellModel.keyboardType = UIKeyboardTypeDefault;
            
//            XLAddressDetailCellModel *cellModel1 = [[XLAddressDetailCellModel alloc] init];
//            cellModel1.title = @"电话号码";
//            cellModel1.content = infoModel.userId;
//            cellModel1.type = AddressDetailCellType_CanEdit;
//            cellModel1.keyboardType = UIKeyboardTypePhonePad;
            
            XLAddressDetailCellModel *cellModel2 = [[XLAddressDetailCellModel alloc] init];
            cellModel2.title = @"城市";
            cellModel2.content = infoModel.city;
            cellModel2.type = AddressDetailCellType_UnEdit;
            
            XLAddressDetailCellModel *cellModel3 = [[XLAddressDetailCellModel alloc] init];
            cellModel3.title = @"地址";
            cellModel3.content = infoModel.address;
            cellModel3.type = AddressDetailCellType_CanEdit;
            cellModel3.keyboardType = UIKeyboardTypeDefault;
            
            [self.dataList addObject:cellModel];
//            [self.dataList addObject:cellModel1];
            [self.dataList addObject:cellModel2];
            [self.dataList addObject:cellModel3];
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLAddressDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        CityListViewController *city = [[CityListViewController alloc] init];
        city.delegate = self;
        [self.navigationController pushViewController:city animated:YES];
    }
}

-(void)CityListViewControllerDidSelectCity:(XLAddressListModel *)model
{
    XLAddressDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    XLAddressDetailCellModel *cellModel = self.dataList[2];
    cellModel.content = model.name;
    cell.model = cellModel;
    self.infoModel.countryId = model.cityId;
}

#pragma mark - target

- (void)changeUserInfo
{
    self.infoModel.user_name = self.dataList[0].content;
    self.infoModel.address = self.dataList[2].content;
    ChangeInfoApi *api = [[ChangeInfoApi alloc] initWithModel:self.infoModel];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *message = request.responseJSONObject[@"Info"];
        [request showToaster:message];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [request showToaster:@"修改失败"];
    }];
}

#pragma mark - setter and getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.backgroundColor = ZFCOLOR(247, 247, 247, 1);
            tableView.showsVerticalScrollIndicator = NO;
            tableView.showsHorizontalScrollIndicator = NO;
            tableView.estimatedSectionFooterHeight = UITableViewAutomaticDimension;
            tableView.sectionFooterHeight = UITableViewAutomaticDimension;
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView.estimatedRowHeight = 100;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableFooterView = [UIView new];
            [tableView registerClass:[XLAddressDetailTableViewCell class] forCellReuseIdentifier:@"Cell"];
            tableView;
        });
    }
    return _tableView;
}

//- (ZFBottomToolView *)addAddressView {
//    if (!_addAddressView) {
//        _addAddressView = [[ZFBottomToolView alloc] initWithFrame:CGRectZero];
//        _addAddressView.bottomTitle = @"Address_VC_Add_Address";
//        _addAddressView.showTopShadowline = YES;
//        _addAddressView.hidden = YES;
////        @weakify(self);
//        _addAddressView.bottomButtonBlock = ^{
////            @strongify(self);
////            [self editAddressAction:nil];
//        };
//    }
//    return _addAddressView;
//}

-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

-(UIButton *)bottomButton
{
    if (!_bottomButton) {
        _bottomButton = ({
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor colorWithHexColorString:@"276ecd"];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:@"修改" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(changeUserInfo) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _bottomButton;
}

@end
