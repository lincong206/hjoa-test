
//  RecordDetailedViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/11/8.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  项目管控 -> 按钮进入详情列表页面

#import "RecordDetailedViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "officeModel.h"
#import "ClickApproveViewController.h"
#import "ZHTEModel.h"
#import "RecordDetailedCell.h"
#import "NewRecordListViewController.h"


@interface RecordDetailedViewController () <UITableViewDelegate, UITableViewDataSource>

{
    NSString *_title;
    NSString *_url;
}

@property (strong, nonatomic) UITableView *detailedTable;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableDictionary *paras;
// 段头
@property (strong, nonatomic) UILabel *pjtName;
@property (strong, nonatomic) UILabel *pjtMoney;

@end

@implementation RecordDetailedViewController

- (UILabel *)pjtName
{
    if (!_pjtName) {
        _pjtName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kscreenWidth*0.6, 25)];
        _pjtName.backgroundColor = [UIColor clearColor];
        _pjtName.font = [UIFont systemFontOfSize:12];
    }
    return _pjtName;
}
- (UILabel *)pjtMoney
{
    if (!_pjtMoney) {
        _pjtMoney = [[UILabel alloc] initWithFrame:CGRectMake(kscreenWidth*0.6 + 25, 0, kscreenWidth*0.4 - 25 - 10, 25)];
        _pjtMoney.backgroundColor = [UIColor clearColor];
        _pjtMoney.textAlignment = NSTextAlignmentRight;
        _pjtMoney.font = [UIFont systemFontOfSize:12];
    }
    return _pjtMoney;
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

- (UITableView *)detailedTable
{
    if (!_detailedTable) {
        _detailedTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _detailedTable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _detailedTable.delegate = self;
        _detailedTable.dataSource = self;
    }
    return _detailedTable;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = self.titleName;
    self.detailedTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.detailedTable];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self separatelyLoadData];
    
    [self.detailedTable registerNib:[UINib nibWithNibName:@"RecordDetailedCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"recordDetailedCell"];
}
// 区分参数获取数据
- (void)separatelyLoadData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self.titleName isEqualToString:@"完工进度"]) {
        _url = finishProgressUrl;
        [dic setObject:@"14469" forKey:@"piId"];
    }else if ([self.titleName isEqualToString:@"总合同额"]) {
        _url = contractMoneyUrl;
        [dic setObject:@"5559" forKey:@"piId"];
    }else if ([self.titleName isEqualToString:@"收款进度"]) {
        _url = paymentScheduleUrl;
        [dic setObject:@"1" forKey:@"astStatus"];
        [dic setObject:@"5559" forKey:@"piId"];
        [dic setObject:@"10" forKey:@"rows"];
        [dic setObject:@"1" forKey:@"page"];
    }else if ([self.titleName isEqualToString:@"开票"]) {
        _url = billingUrl;
        [dic setObject:@"KP" forKey:@"oiType"];
        [dic setObject:@"XM2017090713560" forKey:@"trProjectIdnum"];
        [dic setObject:@"10" forKey:@"rows"];
        [dic setObject:@"1" forKey:@"page"];
    }else if ([self.titleName isEqualToString:@"支出合同"]) {
        _url = contractExpenditureUrl;
        [dic setObject:@"5559" forKey:@"piId"];
    }else if ([self.titleName isEqualToString:@"付款"]) {
        [self showAlertControllerMessage:@"后续补上" andTitle:@"提示" andIsPre:NO];
    }else if ([self.titleName isEqualToString:@"收票"]) {
        [self showAlertControllerMessage:@"后续补上" andTitle:@"提示" andIsPre:NO];
    }
    
    if (_url) {
        [self loadProjectDetailedDataWithUrl:_url andParas:dic];
    }
}

- (void)loadProjectDetailedDataWithUrl:(NSString *)url andParas:(NSMutableDictionary *)pas
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:pas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dic in responseObject[@"rows"]) {
            ZHTEModel *zhte = [[ZHTEModel alloc] init];
            [zhte setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:zhte];
        }
        [self.detailedTable reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"网络连接失败" andTitle:@"提示" andIsPre:NO];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.detailedTable.frame.size.width, 25)];
    header.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.pjtName.text = @"珠港澳项目";
    [header addSubview:self.pjtName];
    
    if ([self.titleName isEqualToString:@"完工进度"]) {
        self.pjtMoney.text = [NSString stringWithFormat:@"%@:%@%@",self.model.title,self.model.completionRate,@"%"];
    }else if ([self.titleName isEqualToString:@"时间"]) {
        self.pjtMoney.text = [NSString stringWithFormat:@"时间进度:%@%@",self.model.completionRate,@"%"];
    }else if ([self.titleName isEqualToString:@"付款"]) {
       self.pjtMoney.text = [NSString stringWithFormat:@"%@:%.2f万",self.model.title,self.model.gross.floatValue/10000];
    }else if ([self.titleName isEqualToString:@"收票"]) {
       self.pjtMoney.text = [NSString stringWithFormat:@"%@:%.2f万",self.model.title,self.model.gross.floatValue/10000];
    }else {
        self.pjtMoney.text = [NSString stringWithFormat:@"合同总金额:%.2f万",self.model.gross.floatValue/10000];
    }
    [header addSubview:self.pjtMoney];
    return header;
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
    RecordDetailedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordDetailedCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.name = self.titleName;
    [cell loadDataWithModel:self.dataSource[indexPath.row]];
    return cell;
}
// 点击进入详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHTEModel *zhte = self.dataSource[indexPath.row];
    if ([self.model.title isEqualToString:@"支出合同"]) {
        if (zhte.contractNum.integerValue != 0) {
            NewRecordListViewController *listVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"nrListVC"];
            listVC.name = zhte.type;
            [self.paras setObject:@"1" forKey:@"page"];
            [self.paras setObject:@"10" forKey:@"rows"];
            if (indexPath.row == 0) {   // 材料
                [self.paras setObject:@"5559" forKey:@"piId"];
                listVC.url = contractCLUrl;
                listVC.paras = self.paras;
            }else {     // 劳务
                [self.paras setObject:@"5559" forKey:@"piId"];
                listVC.url = contractLWUrl;
                listVC.paras = self.paras;
            }
            [self.navigationController pushViewController:listVC animated:YES];
        }else {
            [self showAlertControllerMessage:@"暂无合同支出" andTitle:@"提示" andIsPre:NO];
        }
    }else if ([self.titleName isEqualToString:@"完工进度"]) {
        NewRecordListViewController *listVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"nrListVC"];
        [self.paras setObject:zhte.seId forKey:@"seId"];
        [self.paras setObject:@"1" forKey:@"page"];
        [self.paras setObject:@"10" forKey:@"rows"];
        listVC.name = self.titleName;
        listVC.url = finishXQUrl;
        listVC.paras = self.paras;
        [self.navigationController pushViewController:listVC animated:YES];
    }else {
        ClickApproveViewController *caVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"clickApproveVC"];
        caVC.isSelect = false;
        caVC.title = self.titleName;
        officeModel *model = [[officeModel alloc] init];
        if ([self.titleName isEqualToString:@"总合同额"]) {
            model.piType = zhte.contractType;
            model.piId = zhte.contractId;
        }else if ([self.titleName isEqualToString:@"收款进度"]) {
            model.piType = zhte.sprIdtype;
            model.piId = zhte.sprId;
        }else if ([self.titleName isEqualToString:@"开票"]) {
            model.piType = zhte.trIdtype;
            model.piId = zhte.trId;
        }else if ([self.titleName isEqualToString:@"付款"]) {
            
        }else if ([self.titleName isEqualToString:@"收票"]) {
            
        }
        caVC.model = model;
        [self.navigationController pushViewController:caVC animated:YES];
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
