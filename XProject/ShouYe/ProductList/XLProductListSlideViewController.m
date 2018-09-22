
//
//  XLProductListSlideViewController.m
//  XProject
//
//  Created by MOMO on 2018/9/21.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLProductListSlideViewController.h"
#import "GainBranchListApi.h"

@interface XLProductListSlideViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UIView *tableHeaderView;
@end

@implementation XLProductListSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self requestBranchData];
}

- (void)requestBranchData
{
    GainBranchListApi *api = [[GainBranchListApi alloc] init];
    [api addAccessory:[[YSRequestAccessory alloc] initWithApperOnView:self.view]];
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        if ([request requestSuccess]) {
            NSArray *list = [request requestResponseArrayData:[BranchModel class]];
            if ([list count]) {
                [self.dataList addObjectsFromArray:list];
                [self.tableview reloadData];
            }
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
    cell.backgroundColor = tableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    BranchModel *model = self.dataList[indexPath.row];
    cell.textLabel.text = model.cTitle;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XLProductListSlideViewControllerDidClick:)]) {
        BranchModel *model = self.dataList[indexPath.row];
        [self.delegate XLProductListSlideViewControllerDidClick:model];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.backgroundColor = [UIColor purpleColor];
            tableView.showsVerticalScrollIndicator = NO;
            tableView.showsHorizontalScrollIndicator = NO;
            tableView.estimatedSectionFooterHeight = UITableViewAutomaticDimension;
            tableView.sectionFooterHeight = UITableViewAutomaticDimension;
            tableView.rowHeight = 44;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableHeaderView = self.tableHeaderView;
            tableView.tableFooterView = [UIView new];
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
            tableView;
        });
    }
    return _tableview;
}

-(UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = _tableview.backgroundColor;
            view.frame = CGRectMake(0, 0, KScreenWidth * 0.75, 100);
            
            UILabel *text = [[UILabel alloc] init];
            text.frame = CGRectMake(20, 0, view.mj_w - 20, view.mj_h);
            text.text = @"品牌选择";
            text.font = [UIFont systemFontOfSize:14];
            text.textColor = [UIColor whiteColor];
            [view addSubview:text];
            
            view;
        });
    }
    return _tableHeaderView;
}

-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
