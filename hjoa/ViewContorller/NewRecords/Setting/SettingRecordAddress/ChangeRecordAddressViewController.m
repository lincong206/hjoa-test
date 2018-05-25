//
//  ChangeRecordAddressViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/11/17.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  设置页面->考勤组管理

#import "ChangeRecordAddressViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "NewsRecordSettingModel.h"
#import "RecordsInfoCell.h"
#import "LeaveTypeCell.h"


@interface ChangeRecordAddressViewController () <UITableViewDelegate, UITableViewDataSource, passPickViewFromTypeCell, passPickRowFromTypeCell>
{
    NSMutableArray *_recordList;        // 考勤组数据 名字
    NSInteger _row;                     // 选择第几个考勤组
    NSInteger _number;                  // 选择自己的还是查看的考勤组
    NSString *_sciPiname;               // 考勤组名
}
@property (strong, nonatomic) UITableView *recordsManagerTable;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ChangeRecordAddressViewController

- (UITableView *)recordsManagerTable
{
    if (!_recordsManagerTable) {
        _recordsManagerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight) style:UITableViewStylePlain];
        _recordsManagerTable.delegate = self;
        _recordsManagerTable.dataSource = self;
        _recordsManagerTable.estimatedRowHeight = 0;
        _recordsManagerTable.estimatedSectionHeaderHeight = 0;
        _recordsManagerTable.estimatedSectionFooterHeight = 0;
        _recordsManagerTable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _recordsManagerTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _recordsManagerTable;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        _recordList = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"考勤组管理";
    [self.view addSubview:self.recordsManagerTable];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 获取网络数据
    [self loadRecordInfo];
    
    // 注册cell
    [self.recordsManagerTable registerNib:[UINib nibWithNibName:@"RecordsInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"recordInfoCell"];
    [self.recordsManagerTable registerNib:[UINib nibWithNibName:@"LeaveTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ltypeCell"];
}

- (void)loadRecordInfo
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uiAccount = [user objectForKey:@"uiAccount"];
    NSString *uiPassword = [user objectForKey:@"uiPassword"];
    NSDictionary *params = @{@"uiAccount" : uiAccount,@"uiPassword" : uiPassword};
    [manager POST:LOGINURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            // 自己的考勤点，每个人只有一个考勤点
            NSMutableArray *myInfo = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"sicrows"]) {
                NSDictionary *info = dic[@"caSetCardInformation"];
                _sciPiname = info[@"sciPiname"];
                NewsRecordSettingModel *model = [[NewsRecordSettingModel alloc] init];
                [model setValuesForKeysWithDictionary:info];
                [myInfo addObject:model];
            }
            // 可以查询的考勤点 有多个
            NSMutableArray *record = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"statisticsrows"]) {
                NSDictionary *info = dic[@"caSetCardInformation"];
                NewsRecordSettingModel *model = [[NewsRecordSettingModel alloc] init];
                [model setValuesForKeysWithDictionary:info];
                [record addObject:model];
            }
            [self.dataSource addObject:myInfo];
            [self.dataSource addObject:record];
            // 将考勤组参数分离
            [self reSetDataSource:record];
        }else {
            // 获取考勤设置失败
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            
        }
    }];
}

// 分离考勤组参数
- (void)reSetDataSource:(NSMutableArray *)arrM
{
    for (NewsRecordSettingModel *model in arrM) {
        [_recordList addObject:[NSString stringWithFormat:@"%@",model.sciPiname]];
    }
    [self.recordsManagerTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }else if (section == 1) {
        return 20;
    }else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else if (indexPath.section == 1) {
        return 50;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RecordsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordInfoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataSource.count > 0) {
            if ([self.dataSource[_number] count]>0) {
                [cell refreshRecordPointData:self.dataSource[_number][_row]];
            }
        }
        return cell;
    }else if (indexPath.section == 1) {
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = _recordList;
        cell.typeName.text = @"选择考勤组";
        cell.typeLabel.text = _sciPiname;
        cell.pickData = [NSArray arrayWithArray:arr];
        cell.typeCellDelegate = self;
        cell.passRowDelegate = self;
        return cell;
    }else {
        return nil;
    }
}

#pragma mark --typeCellDelegate--
- (void)passPickBackView:(UIView *)sender andPick:(UIPickerView *)pick
{
    [self.view addSubview:sender];
    [self.view addSubview:pick];
}
#pragma mark --passTypeLabelFromTypeCell--
- (void)passPickRowFromTypeCell:(NSInteger)row
{
    _row = row;
    _number = 1;
//    NSLog(@"%@",[self.dataSource[_number][_row] sciId]);
    [[NSUserDefaults standardUserDefaults] setObject:[self.dataSource[_number][_row] sciId] forKey:@"sciId"];
    [[NSUserDefaults standardUserDefaults] setObject:[self.dataSource[_number][_row] sciPiname] forKey:@"sciSetPiname"];
    [self.recordsManagerTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
