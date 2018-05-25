//
//  FormListViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/4/27.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  创建公文申请界面  可以复用ApproveUICell 用一个标记区分

#import "FormListViewController.h"
#import "FormListModel.h"
#import "Header.h"
#import "AFNetworking.h"
#import "FormCell.h"

@interface FormListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataUI;
@property (strong, nonatomic) UITableView *tableUI;
@end

@implementation FormListViewController

- (NSMutableArray *)dataUI
{
    if (!_dataUI) {
        _dataUI = [NSMutableArray array];
    }
    return _dataUI;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startMonitorNetWork];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = self.olModel.dtName;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"%@",self.olModel.dtIdtype);
    
    self.tableUI = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableUI registerClass:[FormCell class] forCellReuseIdentifier:@"fCell"];
    self.tableUI.delegate = self;
    self.tableUI.dataSource = self;
    self.tableUI.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableUI];
}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self loadDataSourceFromServersFromType:self.olModel.dtIdtype];
        }else {
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示" andAction:YES];
        }
    }];
}

- (void)loadDataSourceFromServersFromType:(NSString *)type
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:type  forKey:@"fnIdtype"];
    [manager POST:FormDetailsURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"fail"]) {
            [self showAlertControllerMessage:@"暂时没有数据" andTitle:@"提示" andAction:YES];
        }else {
            [self.dataUI removeAllObjects];
            // 填充数据  动态创建控件  显示在界面上
//            NSLog(@"%@",responseObject);
            NSArray *arr = responseObject[@"rows"];
            for (NSDictionary *dic in arr) {
                FormListModel *flm = [[FormListModel alloc] init];
                [flm setValuesForKeysWithDictionary:dic];
                [self.dataUI addObject:flm];
            }
            [self.tableUI reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"服务器请求失败！" andTitle:@"提示" andAction:YES];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataUI.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 不能复用cell  数据重叠
    FormCell *cell = [[FormCell alloc] init];
    [cell refreshUIWithModel:self.dataUI[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andAction:(BOOL)bl;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (bl) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
