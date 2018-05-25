//
//  DownDocumentViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/7/4.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  制度管理 -> 下载界面

#import "DownDocumentViewController.h"
#import "AFNetworking.h"
#import "Header.h"
#import "ApproveEnclosureCell.h"
#import "ApproveEnclosureModel.h"

@interface DownDocumentViewController () <UITableViewDataSource, UITableViewDelegate, ApproveEnclosureCellDelegate, passDownModel>
@property (strong, nonatomic) UITableView *downTab;
@property (strong, nonatomic) NSMutableArray *downData;
@end

@implementation DownDocumentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = self.parameter;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (NSMutableArray *)downData
{
    if (!_downData) {
        _downData = [NSMutableArray array];
    }
    return _downData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _downTab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _downTab.backgroundColor = [UIColor whiteColor];
    _downTab.delegate = self;
    _downTab.dataSource = self;
    [_downTab registerNib:[UINib nibWithNibName:@"ApproveEnclosureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aeCell"];
    [self.view addSubview:_downTab];
    _downTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // 已经下载好的数据直接加载
    if (self.isShowPgv) {
        [self loadDataFromLocalWithType:self.type];
    }else {
        // 获取网络数据
        [self loadDataFromSeversWithParameter:self.parameter];
    }
    
}

// 加载本地数据
- (void)loadDataFromLocalWithType:(NSString *)type
{
    [self.downData removeAllObjects];
    NSString *path = [[[NSHomeDirectory()
                        stringByAppendingPathComponent:@"Library"]
                       stringByAppendingPathComponent:@"Caches"]
                      stringByAppendingPathComponent:type];
    NSFileManager *fm = [NSFileManager defaultManager];
    // 判断文件是否存在
    if ([fm fileExistsAtPath:path]) {
        // 存在
        NSError *error;
        NSArray *fileList = [fm contentsOfDirectoryAtPath:path error:&error];
        for (NSString *fileName in fileList) {
            ApproveEnclosureModel *model = [[ApproveEnclosureModel alloc] init];
            model.baiName = fileName;
            [self.downData addObject:model];
        }
    }
    [self.downTab reloadData];
}

#pragma mark ---ApproveEnclosureCellDelegate---
- (void)passDownModel:(ApproveEnclosureModel *)model withType:(NSString *)type
{
    NSLog(@"model--%@ type---%@",model.baiName, type);
    [self.downData addObject:model];
    [self.downTab reloadData];
}

// 加载网络数据
- (void)loadDataFromSeversWithParameter:(NSString *)parameter;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"15" forKey:@"rows"];
    [parameters setValue:@"1" forKey:@"page"];
    [parameters setValue:parameter forKey:@"msClassify"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:downUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"rows"];
        for (NSDictionary *dic in arr) {
            NSDictionary *dic1 = dic[@"cmAttachmentInformation"];
            ApproveEnclosureModel *aeModel = [[ApproveEnclosureModel alloc] init];
            [aeModel setValuesForKeysWithDictionary:dic1];
            [self.downData addObject:aeModel];
        }
        [self.downTab reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.downData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApproveEnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aeCell" forIndexPath:indexPath];
    cell.ApproveEnclosureCelldelegate = self;
    cell.DownModelDelegate = self;
    cell.type = self.type;
    cell.isShowPgv = self.isShowPgv;
    [cell referUIWithModel:self.downData[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark -----ApproveEnclosureCellDelegate-----
- (void)EnclosureCellPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

@end
