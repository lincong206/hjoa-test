//
//  BusinessNewsViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/7/10.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  企业要闻

#import "BusinessNewsViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "Header.h"
#import "BusinssNewsModel.h"
#import "BusinessNewsCell.h"

@interface BusinessNewsViewController () <UITableViewDelegate, UITableViewDataSource, passViewForPush>
{
    NSString *_url;
}
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (weak, nonatomic) IBOutlet UITableView *newsTab;
@property (strong, nonatomic) NSMutableArray *dataSource;           // 数据源

@property (assign, nonatomic) NSInteger page;

@end

@implementation BusinessNewsViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.backgroundColor = [UIColor whiteColor];
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
        [self.newsTab addSubview:_activityView];
    }
    return _activity;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self.newsTab registerNib:[UINib nibWithNibName:@"BusinessNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bcCell"];
    self.newsTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.page = 1;
    // 加载
    [self.activity startAnimating];
    self.activityView.hidden = NO;
    // 获取数据
    [self statrRefreshDataFromURL];
    [self loadDataFromServesWithUrl];
}

// 开始上下拉刷新
- (void)statrRefreshDataFromURL
{
    self.newsTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page += 1;
        [self loadDataFromServesWithUrl];
        [self.newsTab.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.newsTab.mj_header.automaticallyChangeAlpha = YES;
}


// 获取数据
- (void)loadDataFromServesWithUrl
{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setObject:@"JTYW" forKey:@"naIdtype"];
//    [parameters setValue:@"4" forKey:@"rows"];
//    [parameters setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];

    _url = [NSString stringWithFormat:@"%@?naIdtype=JTYW&rows=4&page=%ld",news,(long)self.page];
    
    [self.manager POST:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        if ([responseObject[@"rows"] count] > 0) {
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"rows"]) {
                BusinssNewsModel *model = [[BusinssNewsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [data addObject:model];
            }
            [self.dataSource addObject:data];
            // 将数据调换位置
            if (self.dataSource.count > 4) {
                for (int i = 0; i < self.dataSource.count/2 - 1; i ++) {
                    [self.dataSource exchangeObjectAtIndex:i withObjectAtIndex:self.dataSource.count-1-i];
                }
            }else if (self.dataSource.count == 2 || self.dataSource.count == 3 ) {
                [self.dataSource exchangeObjectAtIndex:0 withObjectAtIndex:self.dataSource.count-1];
            }
        }else {
            [self showAlertControllerMessage:@"暂时没有数据，请稍后再试" andTitle:@"提示" andIsReturn:NO];
        }
        [self.newsTab reloadData];
        // 停止刷新
        [self.newsTab.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"网络连接不正常" andTitle:@"提示" andIsReturn:NO];
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bcCell" forIndexPath:indexPath];
    if (self.dataSource.count) {
        [self.activity stopAnimating];
        self.activityView.hidden = YES;
        cell.timeLabel.text = [[[self.dataSource[indexPath.section] firstObject] naCreatetime] componentsSeparatedByString:@"."].firstObject;
        [cell passData:self.dataSource[indexPath.section]];
        cell.passDelegate = self;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource[indexPath.section] count] == 1) {
        return ([self.dataSource[indexPath.section] count]-1) * 80 + 50 + 150;
    }else {
        return ([self.dataSource[indexPath.section] count]-1) * 80 + 50 + 150;
    }
}

// 点击实现跳转
- (void)passViewForPush:(ClickNewsViewController *)view
{
    [self.navigationController pushViewController:view animated:YES];
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsReturn:(BOOL)isR;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isR) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
