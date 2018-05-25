//
//  RecordNotActiveViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/11/9.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  项目管控分项 -> 时间详情列表

#import "RecordNotActiveViewController.h"
#import "AFNetworking.h"
#import "Header.h"
#import "ApplyModel.h"
#import "NotActiveCell.h"
#import "NewRecordListViewController.h"

@interface RecordNotActiveViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_name;
}
@property (strong, nonatomic) UITableView *notActiveTable;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;
@property (strong, nonatomic) NSMutableDictionary *paras;

@end

@implementation RecordNotActiveViewController

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

- (NSMutableDictionary *)paras
{
    if (!_paras) {
        _paras = [[NSMutableDictionary alloc] init];
    }
    return _paras;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)notActiveTable
{
    if (!_notActiveTable) {
        _notActiveTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _notActiveTable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _notActiveTable.delegate = self;
        _notActiveTable.dataSource = self;
        _notActiveTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _notActiveTable;
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
    
    [self.view addSubview:self.notActiveTable];
    
    if (self.timeModel) {
        _name = @[@"开工日期",@"预计竣工日期",@"实际竣工日期",@"开工天数",@"完成进度明细"];
        [self reloadDataFromModel:self.timeModel];
    }
    
    [self.notActiveTable registerNib:[UINib nibWithNibName:@"NotActiveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"notActiveCell"];
}

- (void)reloadDataFromModel:(TimeParasModel *)time
{
    for (int i = 0; i < _name.count; i ++) {
        ApplyModel *model = [[ApplyModel alloc] init];
        model.name = _name[i];
        switch (i) {
            case 0:
                model.icon = self.timeModel.startDay;
                break;
            case 1:
                model.icon = self.timeModel.endDay;
                break;
            case 2:
                model.icon = self.timeModel.endDay;
                break;
            case 3:
                model.icon = [NSString stringWithFormat:@"%@天",self.timeModel.currenStatus];
                break;
            case 4:
                model.icon = [NSString stringWithFormat:@"%@%@",self.timeModel.completionRate,@"%"];
                break;
            default:
                break;
        }
        [self.dataSource addObject:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notActiveCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != self.dataSource.count-1) {
        cell.image.hidden = YES;
    }else {
        cell.image.hidden = NO;
    }
    [cell refreshDataFromApplyModel:self.dataSource[indexPath.row]];
    return cell;
}
// 进入时间详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSource.count-1) {
        NewRecordListViewController *listVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"nrListVC"];
        listVC.name = self.title;
        [self.paras setObject:@"14469" forKey:@"piId"];
        listVC.url = finishProgressUrl;
        listVC.paras = self.paras;
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

@end
