//
//  CityListViewController.m
//  XProject
//
//  Created by MOMO on 2018/9/28.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "CityListViewController.h"
#import "GainAddressListApi.h"

@interface CityListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    GainAddressListApi *listApi = [[GainAddressListApi alloc] init];
    [listApi addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [listApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        if ([request requestSuccess]) {
            NSArray *cityList = [request requestResponseArrayData:[XLAddressListModel class]];
            self.dataList = cityList;
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    XLAddressListModel *model = self.dataList[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CityListViewControllerDidSelectCity:)]) {
        XLAddressListModel *model = self.dataList[indexPath.row];
        [self.delegate CityListViewControllerDidSelectCity:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

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
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
            tableView;
        });
    }
    return _tableView;
}

@end
