//
//  DocManagerCountViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/12/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "DocManagerCountViewController.h"
#import "Header.h"

#import "QFDatePickerView.h"

#import "BaseButtonView.h"
#import "DocManagerViewController.h"
#import "DocManagerApplyViewController.h"


@interface DocManagerCountViewController () <passButFromBaseView, UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_headerButName;    // 段头名字
    NSInteger _select;
    NSString *_timeLabel;
}
@property (strong, nonatomic) BaseButtonView *baseView;

@property (strong, nonatomic) UITableView *docCountTable;

@end

@implementation DocManagerCountViewController

- (BaseButtonView *)baseView
{
    if (!_baseView) {
        _baseView = [[BaseButtonView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 70, kscreenWidth, 50)];
        _baseView.nameArr = @[@"文档",@"申请",@"统计"];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.passButDelegate = self;
    }
    return _baseView;
}

- (UITableView *)docCountTable
{
    if (!_docCountTable) {
        _docCountTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _docCountTable.delegate = self;
        _docCountTable.dataSource = self;
        _docCountTable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _docCountTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _docCountTable;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"文档管理";
    self.baseView.count = 202;
    [self.view addSubview:self.baseView];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut setImage:[UIImage imageNamed:@"record_backBut"] forState:UIControlStateNormal];
    // 让返回按钮内容继续向左边偏移10
    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBut addTarget:self action:@selector(clickBackBut:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBut];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _select = 500;
    
    [self.view addSubview:self.docCountTable];
    
}
// 传当前年月日
- (NSString *)getNowDateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}
// 底部按钮跳转
- (void)passBaseViewBut:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (but.tag == 201) {
        DocManagerApplyViewController *dmaVC = [sb instantiateViewControllerWithIdentifier:@"docManagerApplyVC"];
        [self.navigationController pushViewController:dmaVC animated:YES];
    }else if (but.tag == 200) {
        DocManagerViewController *dmVC = [sb instantiateViewControllerWithIdentifier:@"docManagerVC"];
        [self.navigationController pushViewController:dmVC animated:YES];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_select == 500) {
        return 1;
    }else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 60;
    }else {
        return 10;
    }
}
// 段头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) { // 顶部按钮
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.docCountTable.frame.size.width, 50)];
        header.backgroundColor = [UIColor clearColor];
        _headerButName = @[@"数据管理",@"我的"];
        for (int i = 0; i < _headerButName.count; i ++) {
            UIButton *headerBut = [UIButton buttonWithType:UIButtonTypeCustom];
            headerBut.backgroundColor = [UIColor whiteColor];
            [headerBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [headerBut setTitleColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateSelected];
            headerBut.titleLabel.font = [UIFont systemFontOfSize:15];
            headerBut.frame =CGRectMake((self.docCountTable.bounds.size.width/_headerButName.count)*i, 0, self.docCountTable.bounds.size.width/_headerButName.count, 47);
            [headerBut setTitle:_headerButName[i] forState:UIControlStateNormal];
            headerBut.tag = 500 + i;
            [headerBut addTarget:self action:@selector(clickHeaderBut:) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:headerBut];
            // 背景
            UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.docCountTable.bounds.size.width/_headerButName.count)*i, 47, (self.docCountTable.bounds.size.width/_headerButName.count), 2)];
            headerImage.backgroundColor = [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0];
            headerImage.tag = 400 + i;
            headerImage.hidden = YES;
            [header addSubview:headerImage];
            
            if (headerBut.tag == _select) {
                headerBut.selected = YES;
            }
            if (headerImage.tag == (_select-100)) {
                headerImage.hidden = NO;
            }
        }
        return header;
    }else {
        return nil;
    }
}
// 点击顶部按钮
- (void)clickHeaderBut:(UIButton *)but
{
    for (NSInteger i = 0; i < _headerButName.count; i ++) {
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
    if (but.tag == 500) {
        
    }else {
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {       // 时间
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_timeLabel) {
            cell.textLabel.text = _timeLabel;
        }else {
            cell.textLabel.text = [self getNowDateTime];
        }
        return cell;
    }else if (indexPath.section == 1) { // 文档下载
        return nil;
    }else if (_select == 500) {
        if (indexPath.section == 2) {   // 带归还文档
            return nil;
        }else {                         // 已归还文档
            return nil;
        }
    }else if (_select == 501) {         // 文档借阅记录
        return nil;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        QFDatePickerView *qfDatePickView = [[QFDatePickerView alloc] initDatePackerWithResponse:^(NSString *str) {
            _timeLabel = str;
        }];
        [qfDatePickView show];
    }
}

@end
