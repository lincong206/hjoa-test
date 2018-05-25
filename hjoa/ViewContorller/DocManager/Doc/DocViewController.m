//
//  DocViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/12/14.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  下载 文件/记录 界面

#import "DocViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

#import "DocDownCell.h"
#import "DocTypeModel.h"

@interface DocViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UISegmentedControl *docSeg;
@property (assign, nonatomic) NSInteger page;

@property (weak, nonatomic) IBOutlet UITableView *downTab;
@property (strong, nonatomic) NSMutableArray *downData;

@end

@implementation DocViewController

- (UISegmentedControl *)docSeg
{
    if (!_docSeg) {
        _docSeg = [[UISegmentedControl alloc] initWithItems:@[@"文 件",@"记 录"]];
        _docSeg.selectedSegmentIndex = 0;
        _docSeg.frame = CGRectMake(0, 0, 150, 30);
        _docSeg.tintColor = [UIColor whiteColor];
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0]};
        [_docSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor whiteColor]};
        [_docSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        [_docSeg addTarget:self action:@selector(clickSeg:) forControlEvents:UIControlEventValueChanged];
    }
    return _docSeg;
}

- (NSMutableArray *)downData
{
    if (!_downData) {
        _downData = [NSMutableArray array];
    }
    return _downData;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)clickSeg:(UISegmentedControl *)seg
{
    [self.downData removeAllObjects];
    if (seg.selectedSegmentIndex == 0) {
        [self loadDownDocFromSeversWithType:self.typeName];
        [self refreshDataUpAndDown:self.typeName];
    }else {
        [self loadDataFromLocalWithType:self.type];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    // 设置选择器
    self.navigationItem.titleView = self.docSeg;
    
    self.page = 1;
    [self loadDownDocFromSeversWithType:self.typeName];
    [self refreshDataUpAndDown:self.typeName];
    
    [self.downTab registerNib:[UINib nibWithNibName:@"DocDownCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"docDownCell"];
    self.downTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

// 加载本地数据
- (void)loadDataFromLocalWithType:(NSString *)type
{
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
            DocTypeModel *model = [[DocTypeModel alloc] init];
            model.rfDescribe = fileName;
            model.cmAttachmentInformation = [NSDictionary dictionaryWithObject:fileName forKey:@"baiName"];
            [self.downData addObject:model];
        }
    }
    [self.downTab reloadData];
}

// 上下刷新
- (void)refreshDataUpAndDown:(NSString *)type
{
    self.downTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 清空数据源。避免数据重复出现
        [self.downData removeAllObjects];
        self.page = 1;
        [self loadDownDocFromSeversWithType:type];
        [self.downTab.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.downTab.mj_header.automaticallyChangeAlpha = YES;
    
    self.downTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page += 1;
        [self loadDownDocFromSeversWithType:type];
        [self.downTab.mj_footer endRefreshing];
    }];
}

// 获取服务器数据
- (void)loadDownDocFromSeversWithType:(NSString *)type
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"15" forKey:@"rows"];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [dic setObject:type forKey:@"rfMold"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:docDownUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"success"] && [responseObject[@"rows"] count] > 0) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                DocTypeModel *model = [[DocTypeModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.downData addObject:model];
            }
            [self.downTab reloadData];
            // 停止刷新
            [self.downTab.mj_header endRefreshing];
            [self.downTab.mj_footer endRefreshing];
        }else {
            [self.downTab.mj_header endRefreshing];
            [self.downTab.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.downData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"docDownCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.downData.count) {
        cell.type = self.type;
        [cell refreshDownDocWithModel:self.downData[indexPath.row]];
    }
    return cell;
}


// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsReturn:(BOOL)isR;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isR) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
