//
//  RecordSettingViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/11/16.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  设置界面 -> 考勤点查询

#import "RecordSettingViewController.h"
#import "Header.h"

#import "BaseButtonView.h"
#import "NewRecordViewController.h"
#import "NewRecordsApplyViewController.h"
#import "RecordsCountViewController.h"
#import "NewRecordCountViewController.h"

#import "ChangeRecordAddressViewController.h"

@interface RecordSettingViewController () <passButFromBaseView, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) BaseButtonView *baseView;

@property (strong, nonatomic) UITableView *settingTable;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation RecordSettingViewController

- (UITableView *)settingTable
{
    if (!_settingTable) {
        _settingTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _settingTable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _settingTable.scrollEnabled = NO;
        _settingTable.delegate = self;
        _settingTable.dataSource = self;
        _settingTable.estimatedRowHeight = 0;
        _settingTable.estimatedSectionHeaderHeight = 0;
        _settingTable.estimatedSectionFooterHeight = 0;
        _settingTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _settingTable;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSArray *titleArr = @[@"考勤组管理"];
        for (int i = 0; i < titleArr.count; i ++) {
            NSString *title = [NSString stringWithFormat:@"%@",titleArr[i]];
            [_dataSource addObject:title];
        }
    }
    return _dataSource;
}

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
    
    self.title = @"设置";
    [self.view addSubview:self.settingTable];
    
    self.baseView.count = 203;
    [self.view addSubview:self.baseView];
}

- (void)clickBackBut:(UIButton *)but
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)passBaseViewBut:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (but.tag == 200) {
        NewRecordViewController *recordVC = [sb instantiateViewControllerWithIdentifier:@"nrVC"];
        [self.navigationController pushViewController:recordVC animated:YES];
    }else if (but.tag == 201) {
        NewRecordsApplyViewController *applyVC = [sb instantiateViewControllerWithIdentifier:@"nrApplyVC"];
        [self.navigationController pushViewController:applyVC animated:YES];
    }else if (but.tag == 202) {
        RecordsCountViewController *count = [sb instantiateViewControllerWithIdentifier:@"rCountVC"];
        [self.navigationController pushViewController:count animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
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
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ChangeRecordAddressViewController *craVC = [sb instantiateViewControllerWithIdentifier:@"changeRecordAddressVC"];
    [self.navigationController pushViewController:craVC animated:YES];
}


@end
