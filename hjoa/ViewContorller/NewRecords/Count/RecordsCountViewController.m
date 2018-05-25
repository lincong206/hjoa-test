//
//  RecordsCountViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/10/23.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  项目管控 -> 项目情况

#import "RecordsCountViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "DataCountModel.h"
//#import "QueryNameModel.h"

#import "DataRecordsCell.h"
#import "DataRecordListCell.h"
#import "MonthChioceCell.h"
#import "MonthDataCell.h"
#import "RecordPersonCell.h"
#import "RecordStateCell.h"

#import "BaseButtonView.h"
#import "NewRecordViewController.h"
#import "NewRecordsApplyViewController.h"
#import "RecordSettingViewController.h"

#import "TimeParasModel.h"
#import "RecordDetailedViewController.h"        // 详情列表
#import "RecordNotActiveViewController.h"       // 时间的详情列表
#import "NewRecordListViewController.h"         // 详情页面

@interface RecordsCountViewController () <UITableViewDelegate, UITableViewDataSource, passClickButFromDataRecordCell, passButFromBaseView>

@property (strong, nonatomic) UITableView *countTable;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) TimeParasModel *timeModel;    // 时间页面model
@property (strong, nonatomic) BaseButtonView *baseView;
@property (assign, nonatomic) NSInteger select;             // 那个按钮

@property (strong, nonatomic) NSArray *headerButName;       // 顶部按钮名称
@property (strong, nonatomic) UIImageView *headerImage;     // 顶部选择
@property (strong, nonatomic) UIButton *headerBut;          // 顶部按钮

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;
@property (strong, nonatomic) UIStoryboard *sb;

@end

@implementation RecordsCountViewController

- (BaseButtonView *)baseView
{
    if (!_baseView) {
        _baseView = [[BaseButtonView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 70, kscreenWidth, 50)];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.nameArr = @[@"文档",@"申请",@"统计",@"设置"];
        _baseView.passButDelegate = self;
    }
    return _baseView;
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
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

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)countTable
{
    if (!_countTable) {
        _countTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-70) style:UITableViewStylePlain];
        _countTable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _countTable.delegate = self;
        _countTable.dataSource = self;
        _countTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _countTable;
}

- (TimeParasModel *)timeModel
{
    if (!_timeModel) {
        _timeModel = [[TimeParasModel alloc] init];
    }
    return _timeModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut setImage:[UIImage imageNamed:@"record_backBut"] forState:UIControlStateNormal];
    // 让返回按钮内容继续向左边偏移10
    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBut addTarget:self action:@selector(clickBackBut:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBut];
    
    [self.view addSubview:self.countTable];
    self.baseView.count = 202;
    [self.view addSubview:self.baseView];
}

- (void)passBaseViewBut:(UIButton *)but
{
    if (but.tag == 200) {
        NewRecordViewController *recordVC = [self.sb instantiateViewControllerWithIdentifier:@"nrVC"];
        [self.navigationController pushViewController:recordVC animated:YES];
    }else if (but.tag == 201) {
        NewRecordsApplyViewController *applyVC = [self.sb instantiateViewControllerWithIdentifier:@"nrApplyVC"];
        [self.navigationController pushViewController:applyVC animated:YES];
    }else if (but.tag == 203) {
        RecordSettingViewController *settingVC = [self.sb instantiateViewControllerWithIdentifier:@"recordSettingVC"];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

- (void)clickBackBut:(UIButton *)but
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
            [self loadDataRecordWithSelect:self.select];
        }else {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示" andIsPre:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.select == 0) {
        self.select = 500;
    }
    
    self.sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    [self startMonitorNetWork];
    
    [self registerCell];
}

// 注册cell
- (void)registerCell
{
    // 项目情况
    [self.countTable registerNib:[UINib nibWithNibName:@"DataRecordsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"dataRecordCell"];
    [self.countTable registerNib:[UINib nibWithNibName:@"DataRecordListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"dataRecordListCell"];
    // 经营情况
//    [self.countTable registerNib:[UINib nibWithNibName:@"MonthChioceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"monthChioceCell"];
//    [self.countTable registerNib:[UINib nibWithNibName:@"MonthDataCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"monthDataCell"];
//    // 结算情况
//    [self.countTable registerNib:[UINib nibWithNibName:@"RecordPersonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nrPresonCell"];
//    [self.countTable registerNib:[UINib nibWithNibName:@"RecordStateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nrStateCell"];
}

// 获取数据
- (void)loadDataRecordWithSelect:(NSInteger)select
{
    [self.activity startAnimating];
    _activityView.hidden = NO;
    
    self.select = select;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (select == 500) {    // 项目情况
        [dic setObject:@"5559" forKey:@"piId"];
        [self loadRecordDataFromSevercesWithUrl:projectPandectUrl andParas:dic andSelect:select];
    }else if (select == 501) {  // 经营情况
        [self loadRecordDataFromSevercesWithUrl:monthRecordUrl andParas:dic andSelect:select];
    }else{                      // 结算情况
        [self loadRecordDataFromSevercesWithUrl:myRecordUrl andParas:dic andSelect:select];
    }
}

#pragma mark --获取各个网络数据--
- (void)loadRecordDataFromSevercesWithUrl:(NSString *)url andParas:(NSMutableDictionary *)paras andSelect:(NSInteger)tag
{
    // 删除数据源。重新加载
    [self.dataSource removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (tag == 500) { // 项目情况
            for (NSDictionary *dic in responseObject[@"rows"]) {
                DataCountModel *model = [[DataCountModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:model];
            }
            self.timeModel.startDay = responseObject[@"startDay"];
            self.timeModel.endDay = responseObject[@"endDay"];
            [self.countTable reloadData];
        }else if (tag == 501) { // 重新组合数据 月统计
            
        }else {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"当前没有数据" andTitle:@"提示" andIsPre:NO];
        }
    }];
}

#pragma mark --TableViewDelegate--
// 多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.select == 500) {
        return 2;
    }else if (self.select == 501) {
        return 1;
    }else {
        return 1;
    }
}
// 段头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) { // 顶部按钮
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.countTable.frame.size.width, 50)];
        header.backgroundColor = [UIColor clearColor];
        self.headerButName = @[@"项目情况",@"经营情况",@"结算情况"];
        for (int i = 0; i < self.headerButName.count; i ++) {
            self.headerBut = [UIButton buttonWithType:UIButtonTypeCustom];
            self.headerBut.backgroundColor = [UIColor whiteColor];
            [self.headerBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.headerBut setTitleColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateSelected];
            self.headerBut.titleLabel.font = [UIFont systemFontOfSize:15];
            self.headerBut.frame =CGRectMake((self.countTable.bounds.size.width/self.headerButName.count)*i, 0, self.countTable.bounds.size.width/self.headerButName.count, 47);
            [self.headerBut setTitle:self.headerButName[i] forState:UIControlStateNormal];
            self.headerBut.tag = 500 + i;
            [self.headerBut addTarget:self action:@selector(clickHeaderBut:) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:self.headerBut];
            
            self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.countTable.bounds.size.width/self.headerButName.count)*i, 47, (self.countTable.bounds.size.width/self.headerButName.count), 2)];
            self.headerImage.backgroundColor = [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0];
            self.headerImage.tag = 400 + i;
            self.headerImage.hidden = YES;
            [header addSubview:self.headerImage];
            
            if (self.headerBut.tag == self.select) {
                self.headerBut.selected = YES;
            }
            if (self.headerImage.tag == (self.select-100)) {
                self.headerImage.hidden = NO;
            }
        }
        return header;
    }else {
        if (self.select == 500) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, 30)];
            view.backgroundColor = [UIColor clearColor];
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 30)];
            label1.backgroundColor = view.backgroundColor;
            label1.text = @"过度类型";
            label1.font = [UIFont systemFontOfSize:12];
            [view addSubview:label1];
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(kscreenWidth-90, 0, 60, 30)];
            label2.backgroundColor = view.backgroundColor;
            label2.text = @"完成比例";
            label2.textAlignment = NSTextAlignmentRight;
            label2.font = [UIFont systemFontOfSize:12];
            [view addSubview:label2];
            return view;
        }
    }
    return nil;
}

// 段高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.select == 500) {
        if (section == 0) {
            return 50;
        }else {
            return 30;
        }
    }else {
        return 0;
    }
}
// 点击顶部按钮
- (void)clickHeaderBut:(UIButton *)but
{
    for (NSInteger i = 0; i < self.headerButName.count; i ++) {
        if (but.tag == 500 + i) {
            but.selected = YES;
            UIImageView *image = (UIImageView *)[self.view viewWithTag:i + 400];
            image.hidden = NO;
            continue;
        }
        UIButton *button = (UIButton *)[self.view viewWithTag:i + 500];
        button.selected = NO;
        
        UIImageView *image = (UIImageView *)[self.view viewWithTag:i + 400];
        image.hidden = YES;
    }
    [self loadDataRecordWithSelect:but.tag];
}

// 多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.select == 500) {
        if (section == 0) {
            return 1;
        }else {
            return self.dataSource.count;
        }
    }else {
        return 0;
    }
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.select == 500) {
        if (indexPath.section == 0) {
            return 510;
        }else {
            return 30;
        }
    }else {
        return 0;
    }
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.activity stopAnimating];
    _activityView.hidden = YES;
    if (self.select == 500) {
        if (indexPath.section == 0) {
            DataRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataRecordCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.xmName = @"珠港澳项目";
            cell.passModelDelegate = self;
            if (self.dataSource.count > 0) {
                [cell refreshDataRecordCellWithData:self.dataSource];
                [cell.recordDetailed addTarget:self action:@selector(clickRecordDetailed:) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }else {
            DataRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataRecordListCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.countTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell refreshProgressDataWithModel:self.dataSource[indexPath.row]];
            return cell;
        }
    }
    return nil;
}

#pragma mark --第一部分cell--
// 跳转到进度明细界面 -> 进入详情列表
- (void)clickRecordDetailed:(UIButton *)but
{
    for (DataCountModel *model in self.dataSource) {
        if ([model.title isEqualToString:@"总合同额"]) {
            [self passModel:model withTitle:@"完工进度"];
        }
    }
}
// 其他部分点击跳转 -> 进入详情列表
- (void)passModel:(DataCountModel *)model withTitle:(NSString *)title
{
    if ([model.title isEqualToString:@"时间"]) {
        RecordNotActiveViewController *notVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"notActiveVC"];
        self.timeModel.completionRate = model.completionRate;
        self.timeModel.currenStatus = model.currentStatus;
        notVC.timeModel = self.timeModel;
        notVC.title = model.title;
        [self.navigationController pushViewController:notVC animated:YES];
    }else {
        RecordDetailedViewController *rdVC = [self.sb instantiateViewControllerWithIdentifier:@"recordDetailedVC"];
        rdVC.titleName = title;
        rdVC.model = model;
        [self.navigationController pushViewController:rdVC animated:YES];
    }
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
