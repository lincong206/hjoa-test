//
//  NewRecordCountViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/9/28.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  统计界面->我的界面(非领导页面)

#import "NewRecordCountViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "RecordEarlyListCell.h"
#import "RecordPersonCell.h"
#import "RecordStateCell.h"

#import "BaseButtonView.h"
#import "NewRecordViewController.h"
#import "NewRecordsApplyViewController.h"
#import "RecordSettingViewController.h"

#import "MonthCalendarViewController.h"

@interface NewRecordCountViewController () <passButFromBaseView, UITableViewDelegate, UITableViewDataSource, passPickDateFromPresonCell, passPickDateFromPresonCell>
{
    NSString *_uiId;
}

@property (strong, nonatomic) BaseButtonView *baseView;

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;

@property (strong, nonatomic) UITableView *queryTab;
@property (strong, nonatomic) NSMutableArray *dataSource;       // 数据源
@property (strong, nonatomic) NSMutableArray *recordData;       // 考勤数据

@property (strong, nonatomic) NSString *recordTime;             // 获取月期

@property (assign, nonatomic) BOOL isOpen;                      // 是否展开

@end

@implementation NewRecordCountViewController

- (NSMutableArray *)recordData
{
    if (!_recordData) {
        _recordData = [NSMutableArray array];
    }
    return _recordData;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)queryTab
{
    if (!_queryTab) {
        _queryTab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _queryTab.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _queryTab.delegate = self;
        _queryTab.dataSource = self;
        _queryTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _queryTab;
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
        [self.queryTab addSubview:_activityView];
    }
    return _activity;
}

- (BaseButtonView *)baseView
{
    if (!_baseView) {
        _baseView = [[BaseButtonView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 70, kscreenWidth, 50)];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.nameArr = @[@"文档",@"申请",@"统计"];
        _baseView.passButDelegate = self;
    }
    return _baseView;
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
    backBut.adjustsImageWhenHighlighted = NO;
    backBut.imageView.contentMode = UIViewContentModeScaleToFill;
    // 让返回按钮内容继续向左边偏移10
    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBut addTarget:self action:@selector(clickBackBut:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBut];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"统计";
    [self.view addSubview:self.queryTab];
    
    self.baseView.count = 202;
    [self.view addSubview:self.baseView];
    
    [self startMonitorNetWork];
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

#pragma mark --passButFromBaseView--
- (void)passBaseViewBut:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (but.tag == 200) {
        NewRecordViewController *recordVC = [sb instantiateViewControllerWithIdentifier:@"nrVC"];
        [self.navigationController pushViewController:recordVC animated:YES];
    }else if (but.tag == 201) {
        NewRecordsApplyViewController *applyVC = [sb instantiateViewControllerWithIdentifier:@"nrApplyVC"];
        [self.navigationController pushViewController:applyVC animated:YES];
    }else if (but.tag == 203) {
        RecordSettingViewController *settingVC = [sb instantiateViewControllerWithIdentifier:@"recordSettingVC"];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            if (self.recordTime == nil) {
                self.recordTime = [self loadDate];
            }
            [self loadRecordDataWithTime:self.recordTime];
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
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self registerCell];
}
// 获取日期参数  服务器时间
- (NSString *)loadDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}

- (void)loadRecordDataWithTime:(NSString *)time;
{
    [self.activity startAnimating];
    self.activityView.hidden = NO;
    
    [self.dataSource removeAllObjects];
    
    if (time) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        _uiId = [user objectForKey:@"uiId"];
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        [paras setObject:time forKey:@"crSbcardtime"];
        [paras setObject:_uiId forKey:@"crUiid"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:myRecordUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                
                for (NSDictionary *dic in responseObject[@"rows"]) {
                    QueryNameModel *nmodel = [[QueryNameModel alloc] init];
                    nmodel.uiName = dic[@"uiName"];
                    nmodel.uiId = dic[@"uiId"];
                    nmodel.psName = dic[@"psName"];
                    nmodel.uiImg = dic[@"uiImg"];
                    nmodel.time = self.recordTime;
                    [self.dataSource addObject:nmodel];
                }
                // 重新处理数据源
                [self reprocessDataSource:responseObject[@"rows"]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.activity stopAnimating];
            self.activityView.hidden = YES;
            if (error) {
                [self showAlertControllerMessage:@"当前没有数据" andTitle:@"提示" andIsPre:NO];
            }
        }];
    }
}
// 重新处理数据源
- (void)reprocessDataSource:(NSMutableArray *)dataSource
{
    NSDictionary *dic = dataSource.firstObject;
    NSArray *key = [dic allKeys];
    
    for (NSString *keyStr in key) {
        if ([keyStr isEqualToString:@"cq"]) {
            QueryNameModel *model = [[QueryNameModel alloc] init];
            model.groupName = @"出勤天数";
            model.isOpen = false;
            model.groupData = dic[@"cq"];
            [self.dataSource addObject:model];
        }else if ([keyStr isEqualToString:@"xx"]) {
            QueryNameModel *model = [[QueryNameModel alloc] init];
            model.groupName = @"休息天数";
            model.isOpen = false;
            model.groupData = dic[@"xx"];
            [self.dataSource addObject:model];
        }else if ([keyStr isEqualToString:@"cd"]) {
            QueryNameModel *model = [[QueryNameModel alloc] init];
            model.groupName = @"迟到";
            model.isOpen = false;
            model.groupData = dic[@"cd"];
            [self.dataSource addObject:model];
        }else if ([keyStr isEqualToString:@"zt"]) {
            QueryNameModel *model = [[QueryNameModel alloc] init];
            model.groupName = @"早退";
            model.isOpen = false;
            model.groupData = dic[@"zt"];
            [self.dataSource addObject:model];
        }else if ([keyStr isEqualToString:@"qk"]) {
            QueryNameModel *model = [[QueryNameModel alloc] init];
            model.groupName = @"缺卡";
            model.isOpen = false;
            model.groupData = dic[@"qk"];
            [self.dataSource addObject:model];
        }else if ([keyStr isEqualToString:@"kg"]) {
            QueryNameModel *model = [[QueryNameModel alloc] init];
            model.groupName = @"旷工";
            model.isOpen = false;
            model.groupData = dic[@"kg"];
            [self.dataSource addObject:model];
        }else if ([keyStr isEqualToString:@"wq"]) {
            QueryNameModel *model = [[QueryNameModel alloc] init];
            model.groupName = @"外勤";
            model.isOpen = false;
            model.groupData = dic[@"wq"];
            [self.dataSource addObject:model];
        }
    }
    
    [self.queryTab reloadData];
}

// 我的界面->注册cell
- (void)registerCell
{
    [self.queryTab registerNib:[UINib nibWithNibName:@"RecordEarlyListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"earlyCell"];
    [self.queryTab registerNib:[UINib nibWithNibName:@"RecordPersonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nrPresonCell"];
    [self.queryTab registerNib:[UINib nibWithNibName:@"RecordStateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nrStateCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }else {
        QueryNameModel *model = self.dataSource[section - 1];
        NSInteger count = model.isOpen ? model.groupData.count : 0;
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.activity stopAnimating];
    self.activityView.hidden = YES;
    if (indexPath.section == 0) {
        RecordPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nrPresonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataSource.count) {
            cell.passDateDelegate = self;
            [cell loadPresonData:self.dataSource[indexPath.row]];
        }
        return cell;
        
    }else if (indexPath.section == 1) {
        RecordStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nrStateCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        [cell showMonthRecords];
        [cell.monthRecords addTarget:self action:@selector(clickMonthRecords:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else {
        RecordStateCell *cell = [[RecordStateCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        [cell setModel:self.dataSource[indexPath.section - 1] IndexPath:indexPath];
        return cell;
    }
    return nil;
}

// 跳转到月历界面
- (void)clickMonthRecords:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MonthCalendarViewController *month = [sb instantiateViewControllerWithIdentifier:@"monthVC"];
    month.title = but.titleLabel.text;
    month.nowDate = self.recordTime;
    month.uiId = _uiId;
    [self.navigationController pushViewController:month animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else if (section == 1) {
        return 0;
    }else {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return nil;
    }
    
    if (self.dataSource.count > 0) {
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        sectionView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];

        QueryNameModel *model = self.dataSource[section - 1];
        
        // 计算 迟到总时间
        NSInteger cdTime = 0;
        if ([model.groupName isEqualToString:@"迟到"]) {
            for (NSDictionary *dic in model.groupData) {
                NSString *time = dic[@"ztTime"];
                cdTime += time.integerValue;
            }
        }
        NSString *cdString = [self changeTimeStamp:[NSString stringWithFormat:@"%ld",(long)cdTime]];
        
        // 计算 早退总时间
        NSInteger ztTime = 0;
        if ([model.groupName isEqualToString:@"早退"]) {
            for (NSDictionary *dic in model.groupData) {
                NSString *time = dic[@"ztTime"];
                ztTime += time.integerValue;
            }
        }
        NSString *ztString = [self changeTimeStamp:[NSString stringWithFormat:@"%ld",(long)ztTime]];
        
        // 显示个数
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 160, 11, 140, 20)];
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.userInteractionEnabled = YES;
        countLabel.font = [UIFont systemFontOfSize:15];
        countLabel.textColor = [UIColor grayColor];
        countLabel.textAlignment = NSTextAlignmentRight;
        if ([model.groupName isEqualToString:@"出勤天数"] || [model.groupName isEqualToString:@"休息天数"] || [model.groupName isEqualToString:@"旷工"]) {
            countLabel.text = [NSString stringWithFormat:@"%ld天",(unsigned long)model.groupData.count];
        }else if ([model.groupName isEqualToString:@"早退"]) {
            countLabel.text = [NSString stringWithFormat:@"%ld次,共%@分钟",(unsigned long)model.groupData.count,ztString];
        }else if ([model.groupName isEqualToString:@"迟到"]) {
            countLabel.text = [NSString stringWithFormat:@"%ld次,共%@分钟",(unsigned long)model.groupData.count,cdString];
        }else {
            countLabel.text = [NSString stringWithFormat:@"%ld次",(unsigned long)model.groupData.count];
        }
        [sectionView addSubview:countLabel];
        
        // 按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:sectionView.bounds];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTag:section - 1];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:model.groupName forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [button addTarget:self action:@selector(buttonIsOpen:) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:button];
        
        // 绘制上下边线
        UILabel *upLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 1)];
        upLineLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [sectionView addSubview:upLineLabel];
        
        return sectionView;
    }
    return nil;
}
// 展开和收起
- (void)buttonIsOpen:(UIButton *)but
{
    QueryNameModel *model = self.dataSource[but.tag];
    model.isOpen = !model.isOpen;
    
    if (model.groupData.count == 0) {
        [self showAlertControllerMessage:@"暂时没有数据" andTitle:@"提示" andIsPre:NO];
    }else {
        [self.queryTab reloadSections:[NSIndexSet indexSetWithIndex:but.tag + 1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark --passPickDateFromPresonCell--
- (void)passPickDate:(NSString *)date
{
    // 选择的时间
    NSArray *dateArr = [date componentsSeparatedByString:@"-"];
    // 当前的时间
    NSArray *nowArr = [[self loadDate] componentsSeparatedByString:@"-"];
    if ([nowArr.firstObject integerValue] >= [dateArr.firstObject integerValue]) { // 判断年份
        if ([nowArr[1] integerValue] > [dateArr.lastObject integerValue]) {    // 判断月份
            NSString *day = [self getMonthBeginAndEndWith:date];
            self.recordTime = [NSString stringWithFormat:@"%@",day];
        }else {
            self.recordTime = [self loadDate];
        }
    }
    // 重新获取数据
    [self loadRecordDataWithTime:self.recordTime];
}

// 返回每个月的最后一天
- (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    return endString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 计算分钟时间
- (NSString *)changeTimeStamp:(NSString *)stamp
{
    return [NSString stringWithFormat:@"%ld",stamp.integerValue/60000];
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
