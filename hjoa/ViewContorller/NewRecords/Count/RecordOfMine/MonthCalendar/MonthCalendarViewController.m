//
//  MonthCalendarViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/10/17.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  月历界面

#import "MonthCalendarViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "CalenderPersonCell.h"
#import "CalenderNewsCell.h"
#import "CalenderCountCell.h"
#import "CalenderRecordsCell.h"
#import "CalenderNORecordsCell.h"
#import "MonthCalenderModel.h"
#import "CalenderPMRecordCell.h"

#import "ApplyRecordsViewController.h"

@interface MonthCalendarViewController () <UITableViewDelegate, UITableViewDataSource, passSelectDayFromCalenderNewCell, passDateFromPersonCell>
{
    NSString *_now;     // 服务器日期
    NSString *_AMPM;    // 上午还是下午
    BOOL _isWeek;       // 是否为周末
    BOOL _isSelf;       // 是否为自己
}

@property (weak, nonatomic) IBOutlet UITableView *calendarTab;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) NSInteger records;               // YES->当前日期之前打卡记录可以显示数据   NO->之后不显示

@end

@implementation MonthCalendarViewController

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"月汇总" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBut)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.title = @"考勤月历";
    self.tabBarController.tabBar.hidden = YES;
}

// 月汇总按钮
- (void)clickRightBut
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.nowDate) {
        [self loadMonthRecordsWithDate:self.nowDate];
    }
    if (self.uiId.integerValue == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] integerValue]) {
        _isSelf = YES;
    }else {
        _isSelf = NO;
    }
    
    [self declareTableViewCell];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark ----注册cell----
- (void)declareTableViewCell
{
    [self.calendarTab registerNib:[UINib nibWithNibName:@"CalenderPersonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"calenderPersonCell"];
    [self.calendarTab registerNib:[UINib nibWithNibName:@"CalenderNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"calenderNewsCell"];
    
    [self.calendarTab registerNib:[UINib nibWithNibName:@"CalenderCountCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"calenderCountCell"];
    [self.calendarTab registerNib:[UINib nibWithNibName:@"CalenderRecordsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"calenderRecordsCell"];
    [self.calendarTab registerNib:[UINib nibWithNibName:@"CalenderPMRecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"calenderPMRecordCell"];
    
    [self.calendarTab registerNib:[UINib nibWithNibName:@"CalenderNORecordsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"calenderNoRecordsCell"];
}

- (void)loadMonthRecordsWithDate:(NSString *)date
{
    NSMutableDictionary *pamars = [NSMutableDictionary new];
    if (self.uiId) {
        [pamars setObject:self.uiId forKey:@"crUiid"];
    }else {
        [pamars setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"crUiid"];
    }
    [pamars setObject:date forKey:@"crSbcardtime"];
    
    [self.dataSource removeAllObjects];
    _AMPM = @"";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:monthCalenderUrl parameters:pamars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                MonthCalenderModel *model = [[MonthCalenderModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:model];
            }
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            // 服务器的日期
            _now = [[responseObject[@"rows"] firstObject][@"nowDate"] componentsSeparatedByString:@" "].firstObject;
            self.records = [self compareNowTime:_now withOtherTime:self.nowDate withDateFormatter:formatter];
            if (self.records == 0) {
                _AMPM = [[[[[responseObject[@"rows"] firstObject][@"nowDate"] componentsSeparatedByString:@" "] lastObject] componentsSeparatedByString:@":"] firstObject];
            }
            [self.calendarTab reloadData];
        }else {
            [self showAlertControllerMessage:@"没有可查询数据" andTitle:@"提示" andIsPre:NO];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"当月没有打卡数据" andTitle:@"提示" andIsPre:NO];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.records == 0 || self.records == 1) {
        return 6;
    }else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {   // 个人信息
        CalenderPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calenderPersonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.uiId = self.uiId;
        cell.selectDay = self.nowDate;
        cell.passTimeDelegate = self;
        [cell loadCalenderPersonCell:self.dataSource.firstObject];
        return cell;
        
    }else if (indexPath.row == 1) { // 日历
        CalenderNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calenderNewsCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:251/255.0 green:251/255.0 blue:252/255.0 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.nowDate) {
            cell.passDayDelegate = self;
            [cell passDate:self.nowDate];
        }
        return cell;
        
    }else if (indexPath.row == 2) { // 固定显示
        CalenderPersonCell *cell = [[CalenderPersonCell alloc] init];
        if (_isSelf) {
            cell.textLabel.text = [NSString stringWithFormat:@"班次 8:30-17:30 考勤组:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sciPiname"]];
        }else {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sciSetPiname"] == nil) {
                cell.textLabel.text = [NSString stringWithFormat:@"班次 8:30-17:30 考勤组:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sciPiname"]];
            }else {
                cell.textLabel.text = [NSString stringWithFormat:@"班次 8:30-17:30 考勤组:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sciSetPiname"]];
            }
        }
        cell.textLabel.alpha = 0.5;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 3) {
        if (self.records == 0 || self.records == 1) { // 显示打卡时间总计
            CalenderCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calenderCountCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell refreshRecordCountDataWithModel:self.dataSource.firstObject];
            return cell;
        }else {             // 未来日子显示 显示当前没有打卡记录(未来日子查询)
            CalenderNORecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calenderNoRecordsCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.row == 4) { // 上午打卡记录
        CalenderRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calenderRecordsCell" forIndexPath:indexPath];
        self.calendarTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.uiId = self.uiId;
        cell.isWeek = _isWeek;
        [cell.AMMissBut addTarget:self action:@selector(clickMissBut) forControlEvents:UIControlEventTouchUpInside];
        [cell showRecordDataWithModel:self.dataSource.firstObject];
        return cell;
    }else if (indexPath.row == 5) { // 下午打卡记录
        CalenderPMRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calenderPMRecordCell" forIndexPath:indexPath];
        self.calendarTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isWeek = _isWeek;
        cell.PM = _AMPM;
        cell.uiId = self.uiId;
        [cell.PMMissBut addTarget:self action:@selector(clickMissBut) forControlEvents:UIControlEventTouchUpInside];
        [cell showPMRecordDataWithModel:self.dataSource.firstObject];
        return cell;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }else if (indexPath.row == 1) {
        return 370;
    }else if (indexPath.row == 2) {
        return 40;
    }else if (indexPath.row == 3) {
        if (self.records == 0 || self.records == 1) {
            return 44;
        }else {
            return 200;
        }
    }else if (indexPath.row == 4) {
        return 130;
    }else if (indexPath.row == 5) {
        return 150;
    }else {
        return 0;
    }
}

#pragma mark --passSelectDayFromCalenderNewCell--
- (void)passSelectDay:(NSString *)day andIsWeek:(BOOL)week
{
    _isWeek = week;
    self.nowDate = day;
    // 重新加载数据
    [self loadMonthRecordsWithDate:self.nowDate];
}

#pragma mark --passDateFromPersonCell--
// 如果是当月，日期为当天
// 不为当月，日期为月首日
- (void)passPersonCellTime:(NSString *)time
{
    NSArray *nowArr = [_now componentsSeparatedByString:@"-"];
    // 比较年份 年份一样
    if ([nowArr.firstObject integerValue] == [[time componentsSeparatedByString:@"-"].firstObject integerValue]) {
        // 比较月份
        if ([nowArr[1] integerValue] == [[time componentsSeparatedByString:@"-"].lastObject integerValue]) {
            self.nowDate = _now;
        }else {
            self.nowDate = [NSString stringWithFormat:@"%@-01",time];
        }
    }else if ([nowArr.firstObject integerValue] > [[time componentsSeparatedByString:@"-"].firstObject integerValue]) {
        self.nowDate = [NSString stringWithFormat:@"%@-01",time];
    }
    // 重新加载数据
    [self loadMonthRecordsWithDate:self.nowDate];
}

//补卡申请
- (void)clickMissBut
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ApplyRecordsViewController *arVC = [sb instantiateViewControllerWithIdentifier:@"applyRecordsVC"];
    arVC.time = self.nowDate;
    [self.navigationController pushViewController:arVC animated:YES];
}

// 查询日期与当前日期做判断
- (NSInteger)compareNowTime:(NSString *)nowTime withOtherTime:(NSString *)otherTime withDateFormatter:(NSDateFormatter *)formatter
{
    NSDate *dateA = [formatter dateFromString:nowTime];
    NSDate *dateB = [formatter dateFromString:otherTime];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedSame) {    // 两者时间是同一个时间   说明是当天
        return 0;
    }else if (result == NSOrderedDescending) {  //nowTime比 otherTime时间晚 说明otherTime是过去时间
        return 1;
    }else {     // 说明otherTime是未来时间
        return 2;
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
