//
//  XLDongTaiViewController.m
//  XProject
//
//  Created by 610715 on 2018/8/13.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLDongTaiViewController.h"
#import "XLDongTaiTableViewCell.h"
#import "HomeDataListApi.h"
#import "AdInfoModel.h"
#import "WKWebViewController.h"

@interface XLDongTaiViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation XLDongTaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locailModel.locailAddSelector(self.navigationItem, @selector(setTitle:), @"动态", nil);
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.pageIndex = 1;
    [self requestNewsData];
}

#pragma mark - request

- (void)requestNewsData
{
    HomeDataListApi *api = [[HomeDataListApi alloc] initWithPageIndex:[self gainPageIndex] pageSize:@"20"];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        if ([request requestSuccess]) {
            NSArray *adModelList = [request requestResponseArrayData:[AdInfoModel class]];
            if ([adModelList count]) {
                [self.dataList addObjectsFromArray:adModelList];
                [self.tableView reloadData];
                if ([self.tableView.mj_footer isRefreshing]) {
                    [self.tableView.mj_footer endRefreshing];
                }
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        [self reloadPageIndex];
    }];
}

#pragma mark - target

- (void)footRefreshAction
{
    self.pageIndex += 1;
    [self requestNewsData];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLDongTaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdInfoModel *model = self.dataList[indexPath.row];
    WKWebViewController *web = [[WKWebViewController alloc] init];
    web.url = model.link_url;
    [self.navigationController pushViewController:web animated:YES];
}

-(NSString *)gainPageIndex
{
    NSString *index = [NSString stringWithFormat:@"%ld", self.pageIndex];
    return index;
}

-(void)reloadPageIndex
{
    if (self.pageIndex <= 0) {
        self.pageIndex = 1;
    }
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
            tableView.delegate = self;
            tableView.dataSource = self;
            [tableView registerClass:[XLDongTaiTableViewCell class] forCellReuseIdentifier:@"Cell"];
            
            tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshAction)];
            
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
