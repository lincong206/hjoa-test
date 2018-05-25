//
//  AddressViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressCell.h"
#import "addressModel.h"
#import "AFNetworking.h"
#import "BMChineseSort.h"
#import "MeViewController.h"
#import "Header.h"
#import "PersonViewController.h"
#import "ViewController.h"

@interface AddressViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented; //部门和字母的排序
@property (weak, nonatomic) IBOutlet UISearchBar *search;           //搜索功能
@property (weak, nonatomic) IBOutlet UITableView *tableView;        //table

@property (strong, nonatomic) NSMutableArray *dataSource;           //数据源
@property (strong, nonatomic) addressModel *adm;

//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@property (nonatomic, strong) NSMutableArray *resultDataSource; //!< 搜索结果的数据源;
@property (nonatomic, assign) BOOL isSearch; //!<  是否处理搜索状态;

@property (strong, nonatomic) UIActivityIndicatorView *activity; //!< 菊花

@property (strong, nonatomic) NSUserDefaults *user;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation AddressViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

// 数据源懒加载
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
    
}

- (NSMutableArray *)resultDataSource
{
    if (!_resultDataSource) {
        _resultDataSource = [NSMutableArray array];
    }
    return _resultDataSource;
}

- (NSMutableArray *)letterResultArr
{
    if (!_letterResultArr) {
        _letterResultArr = [[NSMutableArray alloc] init];
    }
    return _letterResultArr;
}

- (NSMutableArray *)indexArray
{
    if (!_indexArray) {
        _indexArray = [[NSMutableArray alloc] init];
    }
    return _indexArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // App检查更新
    [self checkAppVersion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.search.delegate = self;
    
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.activity.center = CGPointMake(kscreenWidth/2, kscreenHeight/2.5);
//    NSLog(@"x-%f-y-%f",self.activity.center.x,self.activity.center.y);
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.tableView addSubview:self.activity];
   
    // 设置导航栏左侧头像
//    [self setNavLeftButton];
    // 检测网络
    [self startMonitorNetWork];
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self.activity startAnimating];
            [self loadDataFromSever]; // 从服务器下载数据;
        }else {
            [self.activity stopAnimating];
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示" andIsPresent:NO];
            // 本地加载数据
            [self loadAdddersDataFromLocal];
        }
    }];
}
#pragma mark App检查版本更新
- (void)checkAppVersion
{
    NSString *app_url = @"https://itunes.apple.com/cn/lookup?id=1233130569";
    [self.manager POST:app_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*responseObject是个字典{}，有两个key
         KEYresultCount = 1//表示搜到一个符合你要求的APP
         results =（）//这是个只有一个元素的数组，里面都是app信息，那一个元素就是一个字典。里面有各种key。其中有 trackName （名称）trackViewUrl = （下载地址）version （可显示的版本号）等等
         */
        //具体实现为
        NSArray *arr = [responseObject objectForKey:@"results"];
        NSDictionary *dic = [arr firstObject];
        NSString *versionStr = [dic objectForKey:@"version"];
        NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
        NSString *releaseNotes = [NSString stringWithFormat:@"智慧华剑~v%@，快来体验最新版本吧",versionStr];
        
        // 本地build号和version号
        //NSString* buile = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];build号
        NSString* thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        if ([self compareVersionsFormAppStore:versionStr WithAppVersion:thisVersion]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"发现新版本" message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *OKAction  = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL * url = [NSURL URLWithString:trackViewUrl];//itunesURL = trackViewUrl的内容
                [[UIApplication sharedApplication] openURL:url];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:OKAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//比较版本的方法，在这里我用的是Version来比较的
- (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion
{
    BOOL littleSunResult = false;
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }

    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
}

// 获取数据源
- (void)loadDataFromSever
{
    [self.manager GET:addressULR parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 清除数据库数据
        [[DataBaseManager shareDataBase] deleteAllData];
        for (NSDictionary *dic in responseObject[@"rows"]) {
            self.adm = [[addressModel alloc] init];
            [self.adm setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:self.adm];
            // 保存全部通讯录数据
            [[DataBaseManager shareDataBase] insertData:self.adm];
        }
        [self.tableView reloadData];
        // 分离数据
        [self separateDataSource:self.dataSource];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activity stopAnimating];
        [self showAlertControllerMessage:@"获取人员信息失败。" andTitle:@"提示" andIsPresent:NO];
        [self loadAdddersDataFromLocal];
    }];
}
// 获取本地
- (void)loadAdddersDataFromLocal
{
    [self.activity startAnimating];
    
    self.dataSource = [[DataBaseManager shareDataBase] searchAllData];
    
//    if (self.dataSource.count) {
        [self separateDataSource:self.dataSource];
        [self.tableView reloadData];
//    }
}

//根据Person对象的 name 属性 按中文 对 Person数组 排序
- (void)separateDataSource:(NSMutableArray *)arrM
{
    [self.activity startAnimating];
    if (self.segmented.selectedSegmentIndex == 0) {
        self.indexArray = [BMChineseSort IndexWithArray:arrM Key:@"uiName" Sequence:false];
        self.letterResultArr = [BMChineseSort sortObjectArray:arrM Key:@"uiName" Sequence:false];
    }else {     //  强制将特殊字符的分组放置最后面 只针对与部门排序
        self.indexArray = [BMChineseSort IndexWithArray:arrM Key:@"uiPsname" Sequence:true];
        self.letterResultArr = [BMChineseSort sortObjectArray:arrM Key:@"uiPsname" Sequence:true];
    }
    [self.tableView reloadData];
}

// 设置左边头像
- (void)setNavLeftButton
{
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBut.frame = CGRectMake(0, 0, 33, 33);
    leftBut.backgroundColor = [UIColor clearColor];
    [leftBut setImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
    leftBut.adjustsImageWhenHighlighted = NO;
    leftBut.imageView.contentMode = UIViewContentModeScaleToFill;
    leftBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBut addTarget:self action:@selector(clickLeftBut:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBut];
}
// 头像but的方法
- (void)clickLeftBut:(UIButton *)but
{
    
}

#pragma 点击Segment 切换数据源显示
- (IBAction)clickSegment:(UISegmentedControl *)sender
{
    [self separateDataSource:self.dataSource];
}



#pragma tableView代理方法
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.segmented.selectedSegmentIndex == 1) {
        return [NSString stringWithFormat:@"%@",[self.indexArray objectAtIndex:section]];
    }else {
        return [self.indexArray objectAtIndex:section];
    }
}

//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isSearch == YES) {
        return 1;
    }
    return [self.indexArray count];
}

//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch == YES) {
        return self.resultDataSource.count;
    }
    return [[self.letterResultArr objectAtIndex:section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isSearch == YES) {
        return 0;
    }
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.isSearch == YES) {
        return 0;
    }
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = self.segmented.selectedSegmentIndex;
    if (self.isSearch == YES) {
        [cell refreshUI:self.resultDataSource[indexPath.row]];
    }else if (self.letterResultArr.count) {
        [self.activity stopAnimating];
        [cell refreshUI:[[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    }
    return cell;
}

// 设置段头段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isSearch == YES) {
        return 0;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isSearch == YES) {
        return 0;
    }
    return 15;
}

// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

#pragma 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PersonViewController *personVC = [sb instantiateViewControllerWithIdentifier:@"personVC"];
    personVC.hidesBottomBarWhenPushed = YES;
    if (self.isSearch == YES) {
        // 收起键盘
        [self.search resignFirstResponder];
        // 进入个人详情页面
        personVC.adModel = self.resultDataSource[indexPath.row];
        [self.navigationController pushViewController:personVC animated:YES];
    }else {
        personVC.adModel = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:personVC animated:YES];
    }
}

#pragma mark - searchController的代理方法:
// 搜索控制器的代理方法:
// 当搜索框的文字发生改变时会调用该代理方法:
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.search.showsCancelButton = YES;
    self.isSearch = YES; // 处理搜索状态;
    [self.resultDataSource removeAllObjects]; // 清空之前的数据:
    for (addressModel *model in self.dataSource) {
        if ([model.uiName containsString:searchText] == YES) {
            // 搜索到的数据放到resultDataSource:
            [self.resultDataSource addObject:model];
        }
    }
    [self.tableView reloadData];  // 刷新数据，显示搜索数据;
}
// 当搜索按钮按下时会调用该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 收起键盘
    [self.search resignFirstResponder];
//    NSLog(@"%@", self.search.text); // 搜索栏的文字;
    self.search.showsCancelButton = YES;
    self.isSearch = YES; // 处理搜索状态;
    [self.resultDataSource removeAllObjects]; // 清空之前的数据:
    for (addressModel *model in self.dataSource) {
        if ([model.uiName containsString:self.search.text] == YES) {
            // 搜索到的数据放到resultDataSource:
            [self.resultDataSource addObject:model];
        }
    }
    [self.tableView reloadData];  // 刷新数据，显示搜索数据;
}
// 离开搜索状态时调用:
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.isSearch = NO;
    self.search.text = nil;
    self.search.showsCancelButton = NO;
    [self.search resignFirstResponder];
    [self.tableView reloadData]; // 离开搜索状态, 刷新数据;
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsPresent:(BOOL)isP;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isP) {
            _user = [NSUserDefaults standardUserDefaults];
            [_user removeObjectForKey:@"uiAccount"];
            [_user removeObjectForKey:@"uiPassword"];
            [_user removeObjectForKey:@"uiId"];
            NSInteger isF = 0;
            [_user setObject:[NSString stringWithFormat:@"%ld",(long)isF] forKey:@"isFrist"];
            [_user synchronize];
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            ViewController *view = [sb instantiateViewControllerWithIdentifier:@"loginVC"];
            [self presentViewController:view animated:YES completion:nil];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}
@end
