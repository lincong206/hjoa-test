//
//  OfficialDocumentViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/4/25.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  公文列表界面 Add 界面

#import "OfficialDocumentViewController.h"
#import "Header.h"
#import "ODListCell.h"
#import "AFNetworking.h"
#import "officeListModel.h"
#import "FormListViewController.h"

@interface OfficialDocumentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableList;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation OfficialDocumentViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"公文申请类型";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self startMonitorNetWork];

}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self loadDataSourceFromServers];
        }else {
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示"];
        }
    }];
}

- (void)loadDataSourceFromServers
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = [NSDictionary dictionary];
    
    [manager POST:officailDocumentListURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"rows"];
        for (NSDictionary *dic in arr) {
            officeListModel *oL = [[officeListModel alloc] init];
            [oL setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:oL];
        }
        [self.tableList reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"服务器请求失败！" andTitle:@"提示"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ODListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    officeListModel *ol = self.dataSource[indexPath.row];
    cell.nameLabel.text = ol.dtName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FormListViewController *flVC = [sb instantiateViewControllerWithIdentifier:@"flVC"];
    flVC.olModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:flVC animated:YES];
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
