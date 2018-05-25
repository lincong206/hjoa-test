//
//  ApproveViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/21.
//  Copyright © 2017年 huajian. All rights reserved.
//
/**
    快捷审批界面
 */

#import "ApproveViewController.h"
#import "ApproveCell.h"
#import "officeModel.h"
#import "Header.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "ClickApproveViewController.h"

@interface ApproveViewController () <UITableViewDelegate, UITableViewDataSource, passApproveStatus>

@property (weak, nonatomic) IBOutlet UITableView *ApproveTable;

@property (strong, nonatomic) NSMutableArray *ApproveDataSource;

@property (assign, nonatomic) NSInteger page;         // 第几页

//@property (assign, nonatomic) BOOL isInternet;          // 是否有网络连接

@property (strong, nonatomic) UISegmentedControl *seg;

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;
@property (assign, nonatomic) NSInteger row;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation ApproveViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)ApproveDataSource
{
    if (!_ApproveDataSource) {
        _ApproveDataSource = [NSMutableArray array];
    }
    return _ApproveDataSource;
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.backgroundColor = [UIColor clearColor];
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.center = self.view.center;
        _activity.backgroundColor = [UIColor clearColor];
        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        if ([_activity isAnimating]) {   //获取状态 ，0 NO 表示正在旋转，1 YES 表示没有旋转。
            _activityView.hidden = YES;
        }else {
            _activityView.hidden = NO;
        }
        [_activityView addSubview:_activity];
        [self.view addSubview:_activityView];
    }
    return _activity;
}

// 创建Segment
//- (UISegmentedControl *)creatSegment
//{
//    NSArray *name = @[@"我的审批",@"我的申请"];
//    _seg = [[UISegmentedControl alloc] initWithItems:name];
//    _seg.selectedSegmentIndex = 0;
//    _seg.frame = CGRectMake(0, 0, 150, 30);
//    _seg.tintColor = [UIColor whiteColor];
//    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor colorWithRed:14/255.0 green:100/255.0 blue:250/255.0 alpha:1.0]};
//    [_seg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
//    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor whiteColor]};
//    [_seg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
//    //        seg.momentary = YES;
//    [_seg addTarget:self action:@selector(clickSeg:) forControlEvents:UIControlEventValueChanged];
//    return _seg;
//}

// 检查网络状态
- (void)checkUpInternet
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
//            [self loadData];
            self.ApproveTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        }else {
            [self.ApproveTable.mj_header setHidden:YES];
            [self.ApproveTable.mj_footer setHidden:YES];
            self.ApproveTable.tableHeaderView = [self showMessageForNOInternet];
            self.ApproveTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        }
    }];
}
// 检查网络状态显示提示文字
- (UIView *)showMessageForNOInternet
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, 30)];
    view.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = @"当前网络不可用，请检查你的网络设置";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}

// 当审批页面加载时，重新加载数据源。
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    // 检查网络状态
    [self checkUpInternet];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据第一页
    self.page = 1;
    
    [self loadData];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.ApproveTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 将导航栏的头视图设置为选择控制器 Segment
//    self.navigationItem.titleView = [self creatSegment];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)loadData
{
    [self.activity startAnimating];
    _activityView.hidden = NO;
    
    [self.ApproveDataSource removeAllObjects];
    //    if (self.isApprove) {
    // 我的审批
    [self loadDataFromSeversURL:self.url];
    [self statrRefreshDataFromURL:self.url];
    //    }else {
    //        // 我的申请
    //        [self loadDataFromSeversURL:myApproveURL];
    //        [self statrRefreshDataFromURL:myApproveURL];
    //    }
    [self.ApproveTable reloadData];
}

// 开始上下拉刷新
- (void)statrRefreshDataFromURL:(NSString *)url
{
    self.ApproveTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 清空数据源。避免数据重复出现
        [self.ApproveDataSource removeAllObjects];
        self.page = 1;
        [self loadDataFromSeversURL:url];
        [self.ApproveTable.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.ApproveTable.mj_header.automaticallyChangeAlpha = YES;
    
    self.ApproveTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page += 1;
        [self loadDataFromSeversURL:url];
        [self.ApproveTable.mj_footer endRefreshing];
    }];
}

// 从服务器获取数据
- (void)loadDataFromSeversURL:(NSString *)url
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uiId = [user objectForKey:@"uiId"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];
    [parameters setObject:[NSString stringWithFormat:@"14"] forKey:@"rows"];
    
    if (self.isApprove) {
        // 我的审批
        [parameters setObject:[NSString stringWithFormat:@"%@",uiId] forKey:@"uiId"];
    }else {
        // 我的申请
        [parameters setObject:[NSString stringWithFormat:@"%@",uiId] forKey:@"userId"];
    }
 
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"fail"]) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"暂无数据" andTitle:@"提示"];
        }
        NSString *arr = responseObject[@"total"];
        if (arr.integerValue == 0) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"暂无数据" andTitle:@"提示"];
        }
        for (NSDictionary *dic in responseObject[@"rows"]) {
            officeModel *model = [[officeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.ApproveDataSource addObject:model];
        }
        [self.ApproveTable reloadData];
        // 停止刷新
        [self.ApproveTable.mj_header endRefreshing];
        [self.ApproveTable.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activity stopAnimating];
        _activityView.hidden = YES;
    }];
}

#pragma make---tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ApproveDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApproveCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isChange = self.isApprove;
    if (self.ApproveDataSource.count) {
        [self.activity stopAnimating];
        _activityView.hidden = YES;
        [cell showDataOfficeModel:self.ApproveDataSource[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

// 点击按钮时，分别请求不用的Url，
//- (void)clickSeg:(UISegmentedControl *)seg
//{
//    [self.activity startAnimating];
//    
//    if (seg.selectedSegmentIndex == 0) {
//        // 我的审批
//        [self clickMyApproveList];
//    }else {
//        // 我的申请
//        [self clickMyApprove];
//    }
//}

//- (void)clickMyApprove
//{
//    [self.ApproveDataSource removeAllObjects];
//    self.page = 1;
//    [self statrRefreshDataFromURL:myApproveURL];
//    [self loadDataFromSeversURL:myApproveURL];
//    [self.ApproveTable reloadData];
//}

//- (void)clickMyApproveList
//{
//    [self.ApproveDataSource removeAllObjects];
//    self.page = 1;
//    [self statrRefreshDataFromURL:approveListURL];
//    [self loadDataFromSeversURL:approveListURL];
//    [self.ApproveTable reloadData];
//}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

// 跳转到审批详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ClickApproveViewController *cavc = [sb instantiateViewControllerWithIdentifier:@"clickApproveVC"];
    officeModel *model = self.ApproveDataSource[indexPath.row];
    cavc.passStatusDelegate = self;
    NSArray *stringArr = [model.astDocname componentsSeparatedByString:@":"];
    NSArray *stringArr1 = [stringArr.firstObject componentsSeparatedByString:@";"];
    NSArray *stringArr2 = [stringArr1.firstObject componentsSeparatedByString:@"("];
    cavc.title = stringArr2.firstObject;
    cavc.model = model;
    self.row = indexPath.row;
//    if (self.seg.selectedSegmentIndex == 0) {
        cavc.isSelect = self.isApprove;
//    }else {
//        cavc.isSelect = false;
//    }
    //  txt文件中类型之外的跳转没数据
    [self.navigationController pushViewController:cavc animated:YES];
}

// 当这条审批单有通过、不通过、重新起草、延审时，强制将这条审批单的状态修改成对应的操作状态
- (void)passApproveStatus:(NSInteger)status
{
    if (status == 1) {  // 通过
        officeModel *model = self.ApproveDataSource[self.row];
        model.arvStatus = @"2";
        [self.ApproveTable reloadData];
    }else if (status == 2) {    // 不通过
        officeModel *model = self.ApproveDataSource[self.row];
        model.arvStatus = @"4";
        [self.ApproveTable reloadData];
    }else if (status == 3) {    // 重新起草
        officeModel *model = self.ApproveDataSource[self.row];
        model.arvStatus = @"5";
        [self.ApproveTable reloadData];
    }else if (status == 4) {    // 延审
        officeModel *model = self.ApproveDataSource[self.row];
        model.arvStatus = @"8";
        model.arvState = @"3";
        [self.ApproveTable reloadData];
    }
}

@end
