
//
//  XLProductListSlideViewController.m
//  XProject
//
//  Created by MOMO on 2018/9/21.
//  Copyright © 2018年 610715. All rights reserved.
//

#import "XLProductListSlideViewController.h"

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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *title = self.dataList[indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.imageView.backgroundColor = [UIColor redColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(XLProductListSlideViewControllerDidClick)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate XLProductListSlideViewControllerDidClick];
    }
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
            text.frame = CGRectMake(0, 0, view.mj_w, view.mj_h);
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
        
        _dataList = [@[@"苹果", @"三星", @"诺基亚", @"飞利浦", @"微软"] mutableCopy];
    }
    return _dataList;
}

@end
