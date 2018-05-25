//
//  MeViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "MeViewController.h"
#import "AFNetworking.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#import "MeCell.h"
#import "MeModel.h"

@interface MeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *personImage;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UIImageView *departImage;
@property (weak, nonatomic) IBOutlet UILabel *departLabel;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *telephoneImage;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emailImage;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (strong, nonatomic) NSUserDefaults *user;
@property (weak, nonatomic) IBOutlet UITableView *meTable;
@property (strong, nonatomic) NSMutableArray *meData;
@end

@implementation MeViewController

- (UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight*0.35)];
        _backImage.image = [UIImage imageNamed:@"DSC_2846"];
    }
    return _backImage;
}

- (NSMutableArray *)meData
{
    if (!_meData) {
        _meData = [NSMutableArray array];
        NSArray *icon = @[@"out",@"setting"];
        NSArray *text = @[@"退出",@"设置"];
        for (int i = 0; i < icon.count; i ++) {
            MeModel *model = [[MeModel alloc] init];
            model.icon = [NSString stringWithFormat:@"%@",icon[i]];
            model.text = [NSString stringWithFormat:@"%@",text[i]];
            [_meData addObject:model];
        }
    }
    return _meData;
}

#pragma 隐藏navigationBar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [self startMonitorNetWork];
}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
        }else {
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示" isLeave:NO];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backImage];
    [self.view sendSubviewToBack:self.backImage];
    
    self.meTable.scrollEnabled = NO;
    
    [self creatUI];
    
    _user = [NSUserDefaults standardUserDefaults];
    NSString *uiAccount = [_user objectForKey:@"uiAccount"];
    NSString *uiPassword = [_user objectForKey:@"uiPassword"];
    if ((uiAccount == nil) || (uiPassword == nil)) {
        [self showAlertControllerMessage:@"账号和密码已失效，请重新登录!" andTitle:@"提示" isLeave:YES];
    }else {
        [self loginRequestAccount:uiAccount andPassword:uiPassword];
    }
}

#pragma 创建UI布局
- (void)creatUI
{
    self.headerImage.layer.cornerRadius = self.headerImage.frame.size.width/2;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.layer.borderWidth = 2;
    self.headerImage.layer.borderColor = ([UIColor whiteColor].CGColor);

    self.nameLabel.text = @"";
    self.personLabel.text = @"";
    self.departLabel.text = @"";
    self.phoneLabel.text = @"";
    self.telephoneLabel.text = @"";
    self.emailLabel.text = @"";
}


- (void)loginRequestAccount:(NSString *)account andPassword:(NSString *)pwd
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"uiAccount" : account,@"uiPassword" : pwd};
    
    [manager POST:LOGINURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"user"];
        if (![dic[@"uiName"] isKindOfClass:[NSNull class]]) {
            self.nameLabel.text = dic[@"uiName"];
        }
        if (![dic[@"uiAccount"] isKindOfClass:[NSNull class]]) {
            self.personLabel.text = dic[@"uiAccount"];
        }
        if (![dic[@"uiPsname"] isKindOfClass:[NSNull class]]) {
            self.departLabel.text = dic[@"uiPsname"];
        }
        if (![dic[@"uiPhone"] isKindOfClass:[NSNull class]]) {
            self.phoneLabel.text = dic[@"uiPhone"];
        }
        if (![dic[@"uiMobile"] isKindOfClass:[NSNull class]]) {
            self.telephoneLabel.text = dic[@"uiMobile"];
        }
        if (![dic[@"uiEmail"] isKindOfClass:[NSNull class]]) {
            self.emailLabel.text = dic[@"uiEmail"];
        }
        if (![dic[@"uiHeadimage"] isKindOfClass:[NSNull class]]) {
            NSString *headImageUrl = [NSString stringWithFormat:@"%@%@",headImageURL,dic[@"uiHeadimage"]];
            
            [self.headerImage sd_setImageWithURL:[NSURL URLWithString:headImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                    self.headerImage.image = [UIImage imageNamed:@"man"];
                    self.headerImage.contentMode = UIViewContentModeScaleToFill;
                }
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error--%@",error);
        }
    }];
}

#pragma mark ----MeTableView delegate-----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell" forIndexPath:indexPath];
    MeModel *model = self.meData[indexPath.row];
    cell.icon.image = [UIImage imageNamed:model.icon];
    cell.text.text = model.text;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 1) {
        cell.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self showAlertControllerMessage:@"是否退出?" andTitle:@"提示" isLeave:YES];
    }
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title isLeave:(BOOL)leave;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // 确定点击退出
    if (leave) {
        UIAlertAction *leaveAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            _user = [NSUserDefaults standardUserDefaults];
            [_user removeObjectForKey:@"uiAccount"];
            [_user removeObjectForKey:@"uiPassword"];
            [_user removeObjectForKey:@"uiId"];
            [_user removeObjectForKey:@"psId"];
            [_user removeObjectForKey:@"uiPsname"];
            [_user removeObjectForKey:@"uiName"];
            [_user removeObjectForKey:@"uiHeadimage"];
            NSInteger isF = 0;
            [_user setObject:[NSString stringWithFormat:@"%ld",(long)isF] forKey:@"isFrist"];
            [_user synchronize];
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            ViewController *login = [sb instantiateViewControllerWithIdentifier:@"loginVC"];
            [self presentViewController:login animated:YES completion:nil];
        }];
        // 点击取消
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
        }];
        [ac addAction:leaveAction];
        [ac addAction:cancelAction];
    }else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        }];
        [ac addAction:cancelAction];
    }
    [self presentViewController:ac animated:YES completion:nil];
}

@end
