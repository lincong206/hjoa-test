//
//  DocManagerViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/12/13.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  文档管理

#import "DocManagerViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "DocTypeCell.h"

#import "DocViewController.h"
#import "BaseButtonView.h"
#import "DocManagerApplyViewController.h"
#import "DocManagerCountViewController.h"

@interface DocManagerViewController () <UITableViewDataSource, UITableViewDelegate, passButFromBaseView>

@property (weak, nonatomic) IBOutlet UITableView *docTable;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) BaseButtonView *baseView;

@end

@implementation DocManagerViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"人员证书",@"获奖证书",@"合同文件",@"行政资料",@"工程资料",@"规范书籍",@"分公司资料",@"子公司资料",@"财务资料",@"其他", nil];
    }
    return _dataSource;
}

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.baseView.count = 200;
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
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self.docTable registerNib:[UINib nibWithNibName:@"DocTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"docTypeCell"];
    self.docTable.scrollEnabled = NO;
    
}
// 底部按钮跳转
- (void)passBaseViewBut:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (but.tag == 201) {
        DocManagerApplyViewController *dmaVC = [sb instantiateViewControllerWithIdentifier:@"docManagerApplyVC"];
        [self.navigationController pushViewController:dmaVC animated:YES];
    }else if (but.tag == 202) {
        DocManagerCountViewController *dmcVC = [sb instantiateViewControllerWithIdentifier:@"docManagerCountVC"];
        [self.navigationController pushViewController:dmcVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"docTypeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocViewController *docVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"docVC"];
    docVC.typeName = self.dataSource[indexPath.row];
    switch (indexPath.row) {
        case 0:
            docVC.type = @"RYZS";
            break;
        case 1:
            docVC.type = @"HJZS";
            break;
        case 2:
            docVC.type = @"HTWJ";
            break;
        case 3:
            docVC.type = @"XZZL";
            break;
        case 4:
            docVC.type = @"GCZL";
            break;
        case 5:
            docVC.type = @"GFSJ";
            break;
        case 6:
            docVC.type = @"FGSZL";
            break;
        case 7:
            docVC.type = @"ZGSZL";
            break;
        case 8:
            docVC.type = @"CWZL";
            break;
        case 9:
            docVC.type = @"QT";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:docVC animated:YES];
}

@end
