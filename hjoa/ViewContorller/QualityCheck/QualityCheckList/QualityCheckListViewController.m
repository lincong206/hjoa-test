//
//  QualityCheckListViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/2/27.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  质量检查 —> 列表

#import "QualityCheckListViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

#import "QCListModel.h"
#import "QualityCheckListCell.h"
#import "QCChangeCell.h"

#import "QualityCheckDetailsViewController.h"
#import "QualityRectifyViewController.h"

@interface QualityCheckListViewController () <UITableViewDelegate, UITableViewDataSource, passQCListStatus, passReplyButStatus>
{
    NSInteger _row;
    NSInteger _page;
    NSString *_total;
}
@property (strong, nonatomic) NSMutableDictionary *paras;   // 参数
@property (strong, nonatomic) UITableView *qcListTable;
@property (strong, nonatomic) NSMutableArray *listDataSource;

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation QualityCheckListViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
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

- (UITableView *)qcListTable
{
    if (!_qcListTable) {
        if (kscreenHeight == 812) {
            _qcListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kscreenWidth, kscreenHeight-50-64) style:UITableViewStylePlain];
        } else {
            _qcListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-50) style:UITableViewStylePlain];
        }
        _qcListTable.delegate = self;
        _qcListTable.dataSource = self;
        _qcListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _qcListTable;
}

- (NSMutableArray *)listDataSource
{
    if (!_listDataSource) {
        _listDataSource = [NSMutableArray array];
    }
    return _listDataSource;
}

- (NSMutableDictionary *)paras
{
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
    }
    return _paras;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    if (self.isChange) {
        self.title = @"质量整改";
    }else {
        self.title = @"质量检查";
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isChange) {
        [self.qcListTable registerNib:[UINib nibWithNibName:@"QCChangeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcChangeCell"];
    }else {
        [self.qcListTable registerNib:[UINib nibWithNibName:@"QualityCheckListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcListCell"];
    }
    [self.view addSubview:self.qcListTable];
    // 数据第一页
    _page = 1;
    [self checkUpInternet];
}
// 检查网络状态
- (void)checkUpInternet
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self loadData];
        }else {
            [self.qcListTable.mj_header setHidden:YES];
            [self.qcListTable.mj_footer setHidden:YES];
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示"];
        }
    }];
}

- (void)loadData
{
    [self.activity startAnimating];
    _activityView.hidden = NO;
    
    [self.listDataSource removeAllObjects];
    
    if (self.isChange) {    // 质量整改
        [self loadQCListDataFromServiceWithURL:qchangeListUrl];
    }else {
        [self loadQCListDataFromServiceWithURL:qcListUrl];
    }
    [self statrRefreshData];
    
//    [self.qcListTable reloadData];
}

// 开始上下拉刷新
- (void)statrRefreshData
{
    self.qcListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 清空数据源。避免数据重复出现
        [self.listDataSource removeAllObjects];
        _page = 1;
        if (self.isChange) {
            [self loadQCListDataFromServiceWithURL:qchangeListUrl];
        }else {
            [self loadQCListDataFromServiceWithURL:qcListUrl];
        }
        [self.qcListTable.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.qcListTable.mj_header.automaticallyChangeAlpha = YES;
    
    self.qcListTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page += 1;
        if (self.isChange) {
            [self loadQCListDataFromServiceWithURL:qchangeListUrl];
        }else {
            [self loadQCListDataFromServiceWithURL:qcListUrl];
        }
        [self.qcListTable.mj_footer endRefreshing];
    }];
}

- (void)loadQCListDataFromServiceWithURL:(NSString *)url
{
    [self.paras setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
    [self.paras setObject:[NSString stringWithFormat:@"15"] forKey:@"rows"];
    if (self.isChange) {
        [self.paras setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"]  forKey:@"uiId"];
    }
    
    [self.manager POST:url parameters:self.paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        _total = responseObject[@"total"];
        if (_total.integerValue == 0 || [responseObject[@"status"] isEqualToString:@"fail"]) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"暂无数据" andTitle:@"提示"];
        }else {
            if (self.isChange) {    // 整改列表数据
                for (NSDictionary *dic in responseObject[@"rows"]) {
                    QCListModel *model = [[QCListModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.listDataSource addObject:model];
                }
            }else {
                for (NSDictionary *dic in responseObject[@"rows"]) {
                    QCListModel *model = [[QCListModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.listDataSource addObject:model];
                }
            }
        }
        [self.qcListTable reloadData];
        // 停止刷新
        [self.qcListTable.mj_header endRefreshing];
        [self.qcListTable.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"加载失败，请重新加载" andTitle:@"提示"];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isChange) {
        QCChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcChangeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.listDataSource.count > 0) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [cell refreshChangeCellWithModel:self.listDataSource[indexPath.row]];
        }
        return cell;
    }else {
        QualityCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.listDataSource.count > 0) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [cell refreshListCellWithModel:self.listDataSource[indexPath.row]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _row = indexPath.row;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (self.isChange) {            // 整改详情
        QualityRectifyViewController *qrVC = [sb instantiateViewControllerWithIdentifier:@"qrVC"];
        qrVC.bqiId = [self.listDataSource[indexPath.row] bqiId];
        qrVC.birId = [self.listDataSource[indexPath.row] birId];
        qrVC.passReplyButStatusDelegate = self;
        [self.navigationController pushViewController:qrVC animated:YES];
    }else {
        QualityCheckDetailsViewController *qcdVC = [sb instantiateViewControllerWithIdentifier:@"qcDetailsVC"];
        qcdVC.birId = [self.listDataSource[indexPath.row] birId];
        qcdVC.passQCListStatusDelegate = self;
        [self.navigationController pushViewController:qcdVC animated:YES];
    }
}
//  生成整改单时，改变状态
- (void)passQCListStatusWithQCDetails:(NSString *)status
{
    QCListModel *model = self.listDataSource[_row];
    if ([status isEqualToString:@"success"]) {
        model.birRectification = @"1";
    }
    [self.qcListTable reloadData];
}
//  整改or附件回复，改变状态
- (void)passReplyButStatus:(NSString *)status
{
    QCListModel *model = self.listDataSource[_row];
    if ([status isEqualToString:@"ZGsuccess"]) {
        model.bqiRectificationstatus = @"1";
    }else if ([status isEqualToString:@"FJsuccess"]) {
        model.bqiRectificationstatus = @"0";
    }else {
        model.bqiRectificationstatus = @"2";
    }
    [self.qcListTable reloadData];
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}
@end
