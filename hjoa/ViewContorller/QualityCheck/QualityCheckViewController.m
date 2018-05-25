//
//  QualityCheckViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/2/26.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  质量检查 主页

#import "QualityCheckViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "ApplyModel.h"
#import "QualityCheckCell.h"

#import "AddQualityCheckViewController.h"   // 新增质量检查
#import "QualityCheckListViewController.h"

@interface QualityCheckViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_nameArr;
    NSArray *_iconArr;
    NSArray *_backArr;
}
@property (strong, nonatomic) UITableView *qcTable;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIButton *addBut;             // 点击创建新的
@property (strong, nonatomic) UIStoryboard *sb;
@end

@implementation QualityCheckViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)qcTable
{
    if (!_qcTable) {
        _qcTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight - 60) style:UITableViewStylePlain];
        _qcTable.delegate = self;
        _qcTable.dataSource = self;
        _qcTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _qcTable;
}

- (UIButton *)addBut
{
    if (!_addBut) {
        _addBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBut.frame = CGRectMake((kscreenWidth-60)/2, kscreenHeight*0.8, 60, 60);
        _addBut.backgroundColor = [UIColor clearColor];
        [_addBut setBackgroundImage:[UIImage imageNamed:@"qc_add"] forState:UIControlStateNormal];
        [_addBut setBackgroundImage:[UIImage imageNamed:@"qc_add"] forState:UIControlStateHighlighted];
        [_addBut addTarget:self action:@selector(clickAddBut:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBut;
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
    
    self.sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    // 载装数据
    _nameArr = @[@"质量检查",@"质量整改",@"检查设置"];
    _iconArr = @[@"qc_check",@"qc_change",@"qc_setting"];
    _backArr = @[@"color01",@"color02",@"color03"];
    for (int i = 0; i < _nameArr.count; i ++) {
        ApplyModel *model = [[ApplyModel alloc] init];
        model.name = _nameArr[i];
        model.icon = _iconArr[i];
        model.backImage = _backArr[i];
        [self.dataSource addObject:model];
    }
    
    [self.qcTable registerNib:[UINib nibWithNibName:@"QualityCheckCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcCell"];
    [self.view addSubview:self.qcTable];
    
    [self.view addSubview:self.addBut];
}

// 点击 新增质量检查
- (void)clickAddBut:(UIButton *)sender
{
    AddQualityCheckViewController *addQCVc = [self.sb instantiateViewControllerWithIdentifier:@"addQualityCheckVC"];
    [self.navigationController pushViewController:addQCVc animated:YES];
}

#pragma mark --TableViewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QualityCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refreshQualityCheckCellWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QualityCheckListViewController *qcListVC = [self.sb instantiateViewControllerWithIdentifier:@"qcListVC"];
    if (indexPath.row == 0) {
        qcListVC.isChange = false;
        [self.navigationController pushViewController:qcListVC animated:YES];
    }else if (indexPath.row == 1) {
        qcListVC.isChange = true;
        [self.navigationController pushViewController:qcListVC animated:YES];
    }else if (indexPath.row == 2) {
        
    }
}

@end
