//
//  MyOrderListViewController.m
//  XProject
//
//  Created by 610715 on 2018/9/3.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "MyOrderListTableViewCell.h"
#import "GainOrderListApi.h"
#import "OrderModel.h"

@interface MyOrderListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation MyOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locailModel.locailAddSelector(self, @selector(setTitle:), @"订单列表", nil);
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self requestData];
}

#pragma mark - reuqest

- (void)requestData
{
    GainOrderListApi *api = [[GainOrderListApi alloc] initWithOrderNum:@"201809161459245924112"];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        NSArray *orderList = [request requestResponseArrayData:[OrderModel class]];
        NSLog(@"%@", orderList);
        if ([orderList count]) {
            [self.dataList addObjectsFromArray:orderList];
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - target

- (void)footerRefresh:(MJRefreshFooter *)footer
{
    
}

#pragma mark - datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.orderModel = self.dataList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CellHeader"];
    headerView.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return headerView;
}

#pragma mark - setter and getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            tableView.showsVerticalScrollIndicator = NO;
            tableView.showsHorizontalScrollIndicator = NO;
            tableView.estimatedRowHeight = 140;
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView.estimatedSectionFooterHeight = 0.01;
            tableView.estimatedSectionHeaderHeight = 10;
            tableView.sectionFooterHeight = 0.01;
            tableView.sectionHeaderHeight = 10;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableFooterView = [UIView new];
            [tableView registerClass:[MyOrderListTableViewCell class] forCellReuseIdentifier:@"Cell"];
            [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"CellHeader"];
            
            tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
            
            tableView;
        });
    }
    return _tableView;
}

-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
