//
//  SpecialPJTViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/7/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "SpecialPJTViewController.h"
#import "AFNetworking.h"
#import "Header.h"
#import "SpecialPJTCell.h"
#import "MJRefresh.h"

@interface SpecialPJTViewController () <UITableViewDelegate, UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *parameters;     // 搜索条件关键字
@property (strong, nonatomic) NSString *searchText;     // 搜索字
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSMutableArray *pjtData;
@property (weak, nonatomic) IBOutlet UITableView *sProjectTable;

@property (strong, nonatomic) UIView *pickBackView;
@property (strong, nonatomic) UISearchBar *search;
@property (strong, nonatomic) UIButton *chooseType;

@property (strong, nonatomic) UIView *seachView;
@property (strong, nonatomic) UIPickerView *pick;
@property (strong, nonatomic) UIButton *confirmButton;
@end

@implementation SpecialPJTViewController

- (NSMutableArray *)pjtData
{
    if (!_pjtData) {
        _pjtData = [NSMutableArray array];
    }
    return _pjtData;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(kscreenWidth -70, 5, 40, 30)];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    [self checkUpInternet];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)creatCearchView
{
    self.seachView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kscreenWidth, 50)];
    self.seachView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    self.chooseType = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseType.frame = CGRectMake(10, 10, 100, 30);
    self.chooseType.backgroundColor = [UIColor grayColor];
    self.chooseType.tintColor = [UIColor blackColor];
    self.chooseType.titleLabel.textAlignment = NSTextAlignmentCenter;
    if ([self.name isEqualToString:@"WDJC"]) {
        [self.chooseType setTitle:self.pickData.firstObject forState:UIControlStateNormal];
    }else {
        [self.chooseType setTitle:@"搜索条件" forState:UIControlStateNormal];
    }
    [self.chooseType addTarget:self action:@selector(clickChooseBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.seachView addSubview:self.chooseType];
    
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(120, 0, kscreenWidth - 120, 50)];
    self.search.delegate = self;
    self.search.placeholder = @"搜索";
    [self.seachView addSubview:self.search];
    [self.view addSubview:self.seachView];
}

- (void)clickChooseBut:(UIButton *)sender
{
    self.pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kscreenHeight*0.6, kscreenWidth, kscreenHeight*0.4)];
    self.pickBackView.backgroundColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    self.pick = [[UIPickerView alloc] initWithFrame:self.pickBackView.bounds];
    self.pick.backgroundColor = [UIColor whiteColor];
    self.pick.delegate = self;
    self.pick.dataSource = self;
    [self.pickBackView addSubview:self.pick];
    [self.pickBackView addSubview:self.confirmButton];
    [self.pick selectRow:0 inComponent:0 animated:NO];
    [self.view addSubview:self.pickBackView];
}

#pragma mark --UIPickerViewDelegate--
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickData[row];
}

// 选中行显示在label上
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.name isEqualToString:@"xmbx"] || [self.name isEqualToString:@"jcbg"]) {
        switch (row) {
            case 0:
                self.parameters = @"uiManagername";
                break;
            case 1:
                self.parameters = @"piName";
                break;
            case 2:
                self.parameters = @"piBuildcompany";
                break;
            case 3:
                self.parameters = @"uiBelongname";
                break;
            default:
                self.parameters = @"uiManagername";
                break;
        }
    }else if ([self.name isEqualToString:@"WDJC"]) {
        self.parameters = self.pickData[row];
    }else {
        self.parameters = @"";
    }
    [self.chooseType setTitle:self.pickData[row] forState:UIControlStateNormal];
}

// pick确定按钮
- (void)cancel:(UIButton *)but
{
    self.pickBackView.hidden = YES;
    [self loadData];
}

#pragma mark --UISearchBarDelegate--
// 当搜索按钮按下时会调用该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchText = searchBar.text;
    // 收起键盘
    [self.search resignFirstResponder];
    searchBar.showsCancelButton = NO;
    [self loadData];
}

- (void)loadData
{
    [self.pjtData removeAllObjects];
    [self loadSpecialProjectDataWithUrl:self.url];
    [self statrRefreshDataFromURL:self.url];
    [self.sProjectTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    if ([self.name isEqualToString:@"xmbx"]) {
        self.url = specialPjtUrl;
    }else if ([self.name isEqualToString:@"WDJC"]) {
        self.url = wdjcUrl;
    }else if ([self.name isEqualToString:@"jcbg"]) {
        self.url = sgCheckPjtUrl;
    }
    
    // 数据第一页
    self.page = 1;
    
    [self creatCearchView];
    
    [self.sProjectTable registerNib:[UINib nibWithNibName:@"SpecialPJTCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"pjtCell"];
    self.sProjectTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

// 检查网络状态
- (void)checkUpInternet
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self loadData];
        }else {
            [self.sProjectTable.mj_header setHidden:YES];
            [self.sProjectTable.mj_footer setHidden:YES];
            [self showAlertControllerMessage:@"请连接网络" andTitle:@"提示"];
        }
    }];
}

// 开始上下拉刷新
- (void)statrRefreshDataFromURL:(NSString *)url
{
    self.sProjectTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 清空数据源。避免数据重复出现
        [self.pjtData removeAllObjects];
        self.page = 1;
        [self loadSpecialProjectDataWithUrl:url];
        [self.sProjectTable.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.sProjectTable.mj_header.automaticallyChangeAlpha = YES;
    
    self.sProjectTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page += 1;
        [self loadSpecialProjectDataWithUrl:url];
        [self.sProjectTable.mj_footer endRefreshing];
    }];
}

// 获取数据
- (void)loadSpecialProjectDataWithUrl:(NSString *)url
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    if ([self.name isEqualToString:@"jcbg"]) {
        [parameter setObject:@"SG" forKey:@"type"];
    }
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];
    [parameter setObject:@"15" forKey:@"rows"];
    
    // 搜索字
    if ([self.name isEqualToString:@"WDJC"]) {
        if (self.parameters == nil) {   // 搜索条件
            [parameter setObject:self.pickData.firstObject forKey:@"rfMold"];
        }else {
            [parameter setObject:self.parameters forKey:@"rfMold"];
        }
        if (self.searchText != nil) {   // 搜索关键字
            [parameter setObject:self.searchText forKey:@"rfDescribe"];
        }
    }else {
        if (self.parameters != nil) {
            if (self.searchText == nil) {
                [parameter setObject:@" " forKey:self.parameters];
            }else {
                [parameter setObject:self.searchText forKey:self.parameters];
            }
        }
    }
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"fail"]) {
            [self showAlertControllerMessage:@"当前没有数据" andTitle:@"提示"];
            [self.sProjectTable reloadData];
        }else {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                SpecialPJTModel *model = [[SpecialPJTModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.pjtData addObject:model];
            }
            if (self.pjtData.count < 5) {
                [self.sProjectTable.mj_footer setHidden:YES];
                [self.sProjectTable.mj_header setHidden:YES];
            }
            [self.sProjectTable reloadData];
        }
        // 停止刷新
        [self.sProjectTable.mj_header endRefreshing];
        [self.sProjectTable.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"网络不给力" andTitle:@"提示"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pjtData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialPJTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pjtCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = self.name;
    if (self.pjtData.count) {
        [cell refreUIWithData:self.pjtData[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate passProjectDataWithModel:self.pjtData[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}


@end
