//
//  MonthRecordDataListViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/11/4.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  月统计 数据

#import "MonthRecordDataListViewController.h"
#import "QueryNameModel.h"
#import "MothRecordDataListCell.h"

@interface MonthRecordDataListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *listDataTab;

@end

@implementation MonthRecordDataListViewController

- (UITableView *)listDataTab
{
    if (!_listDataTab) {
        _listDataTab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _listDataTab.delegate = self;
        _listDataTab.dataSource = self;
        _listDataTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _listDataTab;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view addSubview:self.listDataTab];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.time = [NSString stringWithFormat:@"%@-%@",[self.time componentsSeparatedByString:@"-"].firstObject,[self.time componentsSeparatedByString:@"-"][1]];
    
    [self.listDataTab registerNib:[UINib nibWithNibName:@"MothRecordDataListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"monthDataListCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@ %@ 共%ld人",self.time,self.type,(unsigned long)self.listData.count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MothRecordDataListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthDataListCell" forIndexPath:indexPath];
    cell.type = self.type;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.listData.count > 0) {
        [cell refreshUIWithData:self.listData[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
