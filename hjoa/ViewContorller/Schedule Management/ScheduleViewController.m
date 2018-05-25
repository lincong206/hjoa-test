//
//  ScheduleViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/6/23.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  制度管理

#import "ScheduleViewController.h"
#import "ScheduleCell.h"
#import "ScheduleModel.h"
#import "ApproveEnclosureCell.h"
#import "DownDocumentViewController.h"

@interface ScheduleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) UISegmentedControl *seg;

@property (assign, nonatomic) BOOL isCollection;

@end

@implementation ScheduleViewController

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    // 将导航栏的头视图设置为选择控制器 Segment
    self.navigationItem.titleView = self.seg;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 创建Segment
- (UISegmentedControl *)seg
{
    if (!_seg) {
        NSArray *name = @[@"制 度",@"收 藏"];
        _seg = [[UISegmentedControl alloc] initWithItems:name];
        _seg.selectedSegmentIndex = 0;
        _seg.frame = CGRectMake(0, 0, 150, 30);
        _seg.tintColor = [UIColor whiteColor];
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0]};
        [_seg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor whiteColor]};
        [_seg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        //        seg.momentary = YES;
        [_seg addTarget:self action:@selector(clickSeg:) forControlEvents:UIControlEventValueChanged];
    }
    return _seg;
}

// 点击按钮
- (void)clickSeg:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        self.isCollection = NO;
        [self loadScheduleData];
    }else {
        self.isCollection = YES;
        [self loadScheduleData];
    }
}

- (void)loadScheduleData
{
    [self.data removeAllObjects];
    NSArray *titleArr = @[@"行政人力中心",@"营销管理中心",@"财务管理中心",@"采购管理中心",
                          @"工程管理中心",@"技术管理中心",@"设计研究院"];
    for (NSInteger i = 0; i < 7; i ++) {
        ScheduleModel *model = [[ScheduleModel alloc] init];
        model.title = [NSString stringWithFormat:@"%@",titleArr[i]];
        [self.data addObject:model];
    }
    [self.table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    if (self.seg.selectedSegmentIndex == 0) {
        self.isCollection = NO;
        [self loadScheduleData];
    }else {
        self.isCollection = YES;
        [self loadScheduleData];
    }
    
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell" forIndexPath:indexPath];
    cell.title.text = [self.data[indexPath.row] title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DownDocumentViewController *dd = [sb instantiateViewControllerWithIdentifier:@"ddVC"];
    dd.isShowPgv = self.isCollection;
    dd.parameter = [self.data[indexPath.row] title];
    switch (indexPath.row) {
        case 0:
            dd.type = @"XZZX";
            break;
        case 1:
            dd.type = @"YXZX";
            break;
        case 2:
            dd.type = @"CWZX";
            break;
        case 3:
            dd.type = @"CGZX";
            break;
        case 4:
            dd.type = @"GCZX";
            break;
        case 5:
            dd.type = @"JSZX";
            break;
        case 6:
            dd.type = @"SJY";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:dd animated:YES];
}


@end
