//
//  XLWoDeViewController.m
//  XProject
//
//  Created by 610715 on 2018/8/13.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLWoDeViewController.h"
#import "XLWodeTableHeaderView.h"
#import "XLAddressViewController.h"
#import "MyOrderListViewController.h"
#import "LoginViewController.h"
#import "XLMineTableViewCell.h"
#import "XLAddressDetailViewController.h"
#import "ChangePasswordViewController.h"
#import "XLTabBarController.h"

@interface XLWoDeViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XLWodeTableHeaderView *tableHeaderView;
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation XLWoDeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locailModel.locailAddSelector(self.navigationItem, @selector(setTitle:), @"我的", nil);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *title = self.dataList[indexPath.row];
    cell.titleLabel.text = title;
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"r%ld", indexPath.row+1]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        MyOrderListViewController *myOrderList = [[MyOrderListViewController alloc] init];
        [self.navigationController pushViewController:myOrderList animated:YES];
    }else if (indexPath.row == 1){
        XLAddressDetailViewController *detail = [[XLAddressDetailViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.row == 2){
        ChangePasswordViewController *changepw = [[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:changepw animated:YES];
//        @weakify(self)
//        [LoginViewController presentLoginViewController:self complation:^{
//            @strongify(self)
//            self.tableHeaderView.nameLabel.text = [AccountManager shareInstance].accountModel.user_name;
//        }];
    }
}

- (void)loginout
{
    //退出登录
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AccountManager *manager = [AccountManager shareInstance];
        [manager loginOut];
        XLTabBarController *tabbar = (XLTabBarController *)WINDOW.rootViewController;
        [tabbar setSelectedIndex:0];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
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
            tableView.rowHeight = 52;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableHeaderView = self.tableHeaderView;
            tableView.tableFooterView = [UIView new];
            [tableView registerClass:[XLMineTableViewCell class] forCellReuseIdentifier:@"Cell"];
            tableView.tableFooterView = ({
                UIView *footView = [[UIView alloc] init];
                footView.frame = CGRectMake(0, 0, KScreenWidth, 80);
                footView.backgroundColor = [UIColor whiteColor];
                
                UIButton *loginoutButton = [[UIButton alloc] init];
                [footView addSubview:loginoutButton];
                [loginoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
                loginoutButton.layer.cornerRadius = 5;
                [loginoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                loginoutButton.backgroundColor = [UIColor colorWithHexColorString:@"276ecd"];
                [loginoutButton addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
                [loginoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.mas_equalTo(footView.mas_leading).mas_offset(25);
                    make.trailing.mas_equalTo(footView.mas_trailing).mas_offset(-25);
                    make.height.mas_offset(44);
                    make.centerY.mas_equalTo(footView);
                }];
                
                footView;
            });
            tableView;
        });
    }
    return _tableView;
}

-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
        
//        [_dataList addObject:@"个人信息"];
        [_dataList addObject:@"我的订单"];
        [_dataList addObject:@"地址管理"];
        [_dataList addObject:@"修改密码"];
    }
    return _dataList;
}

- (XLWodeTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[XLWodeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth * 0.5)];
    }
    return _tableHeaderView;
}


@end
