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

@interface XLAddressDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) ZFBottomToolView *addAddressView;
@end

@implementation XLAddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locailModel.locailAddSelector(self, @selector(setTitle:), @"Mine", nil);
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
    XLAddressDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.model = self.dataList[indexPath.row];
    return cell;
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

- (ZFBottomToolView *)addAddressView {
    if (!_addAddressView) {
        _addAddressView = [[ZFBottomToolView alloc] initWithFrame:CGRectZero];
        _addAddressView.bottomTitle = @"Address_VC_Add_Address";
        _addAddressView.showTopShadowline = YES;
        _addAddressView.hidden = YES;
//        @weakify(self);
        _addAddressView.bottomButtonBlock = ^{
//            @strongify(self);
//            [self editAddressAction:nil];
        };
    }
    return _addAddressView;
}

-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];

        XLAddressDetailCellModel *cellModel = [[XLAddressDetailCellModel alloc] init];
        cellModel.title = @"名字";
        
        XLAddressDetailCellModel *cellModel1 = [[XLAddressDetailCellModel alloc] init];
        cellModel1.title = @"电话号码";
        
        XLAddressDetailCellModel *cellModel2 = [[XLAddressDetailCellModel alloc] init];
        cellModel2.title = @"地址";
        
        XLAddressDetailCellModel *cellModel3 = [[XLAddressDetailCellModel alloc] init];
        cellModel3.title = @"地址2";
        [_dataList addObject:cellModel];
        [_dataList addObject:cellModel1];
        [_dataList addObject:cellModel2];
        [_dataList addObject:cellModel3];
    }
    return _dataList;
}

@end
