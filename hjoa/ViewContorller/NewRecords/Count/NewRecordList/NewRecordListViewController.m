//
//  NewRecordListViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/11/6.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  项目管控 -> 详情页面 (另外的详情页面跳入审批详情查看)

#import "NewRecordListViewController.h"
#import "AFNetworking.h"
#import "Header.h"

#import "ListVCModel.h"
#import "RecordListCell.h"

#import "MonthCalendarViewController.h"

@interface NewRecordListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *headerButName;       // 顶部按钮名称
@property (strong, nonatomic) UIImageView *headerImage;     // 顶部选择
@property (strong, nonatomic) UIButton *headerBut;          // 顶部按钮
@property (strong, nonatomic) UILabel *titleLabel;          // 顶部文字

@property (strong, nonatomic) UITableView *listTable;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation NewRecordListViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)listTable
{
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _listTable.delegate = self;
        _listTable.dataSource = self;
    }
    return _listTable;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = self.name;
    self.listTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.listTable];
    
    [self startMonitorNetWork];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self loadRecordListFromCountWithUrl:self.url andParas:self.paras];
        }else {
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示" andIsPre:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.listTable registerNib:[UINib nibWithNibName:@"RecordListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"recordListCell"];
}

- (void)loadRecordListFromCountWithUrl:(NSString *)url andParas:(NSMutableDictionary *)paras
{
    // 删除数据源。重新加载
    [self.dataSource removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"rows"]) {
            ListVCModel *model = [[ListVCModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [self.listTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"请求失败" andTitle:@"提示" andIsPre:NO];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = self.name;
    if (self.dataSource.count > 0) {
        [cell refreshCellWithModel:self.dataSource[indexPath.row]];
    }
    return cell;
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsPre:(BOOL)isP;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isP) {
            // 回到上个页面
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}
@end
