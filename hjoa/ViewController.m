//
//  ViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "ViewController.h"
#import "tabbarController.h"
#import "AFNetworking.h"
#import "Header.h"
#import "AddressViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "DindingQQAndWXView.h"

#import "RegisterViewController.h"

@interface ViewController () <TencentSessionDelegate, UITextFieldDelegate, passAccountAndPWFromRegist>

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) NSDictionary *loginDic;
@property (strong, nonatomic) NSUserDefaults *user;

@property (strong, nonatomic) NSString *deviceToken;

@property (strong, nonatomic) TencentOAuth *tencentOAuth;

@property (strong, nonatomic) UILabel *declareLabel; // 申明  第三方登录
@property (strong, nonatomic) UILabel *companyLabel; // 申明  第三方登录

@property (weak, nonatomic) IBOutlet UIButton *secureBut;   //  密文按钮

@property (strong, nonatomic) UIButton *registBut;  // 注册按钮

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;

@end

@implementation ViewController

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
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

- (UIButton *)registBut
{
    if (!_registBut) {
        _registBut = [UIButton buttonWithType:UIButtonTypeSystem];
        _registBut.frame = CGRectMake(kscreenWidth - 100 - 20, kscreenHeight*0.6, 100, 30);
        [_registBut setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registBut addTarget:self action:@selector(clickRegist) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBut;
}

- (NSDictionary *)loginDic
{
    if (!_loginDic) {
        _loginDic = [[NSDictionary alloc] init];
    }
    return _loginDic;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/paUserInfo/register",intranetURL];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *regist = responseObject[@"status"];
        if (regist.integerValue == 1) {
            [self.view addSubview:self.registBut];
        }else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

// 进入创建页面
- (void)clickRegist
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RegisterViewController *regist = [sb instantiateViewControllerWithIdentifier:@"registeVC"];
    regist.title = @"注册账户";
    regist.passDelegate = self;
    [self presentViewController:regist animated:YES completion:nil];
}

- (void)passAccount:(NSString *)account andPW:(NSString *)pw
{
    self.account.text = account;
    self.password.text = pw;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.secureBut.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置密文按钮
    [self setupSecureBut];
    
    // 测试版本数据
//    [self textHuaJianOA];
    
    // QQ 微信登录
//    [self creatCustomBut];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
    [self.view addGestureRecognizer:tap];
    
    [self startMonitorNetWork];
}

- (void)setupSecureBut
{
    self.account.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password.delegate = self;
    [self.secureBut addTarget:self action:@selector(clickSecureBut:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark---UITextFieldDelagate----
//  textfield 即将开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //  显示密文按钮
    self.secureBut.hidden = NO;
    [textField resignFirstResponder];
    return YES;
}

//  textfield 已经编辑完成
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.secureBut.hidden = YES;
    }
}

- (void)creatCustomBut
{
    _declareLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kscreenHeight*0.83 - 30, kscreenWidth - 20, 30)];
    _declareLabel.text = @"其他登录方式";
    _declareLabel.tintColor = [UIColor grayColor];
    _declareLabel.textAlignment = NSTextAlignmentCenter;
    _declareLabel.font = [UIFont systemFontOfSize:15];
    _declareLabel.alpha = 0.5;
    [self.view addSubview:_declareLabel];
    
    _clickQQ = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickQQ.frame = CGRectMake(kscreenWidth/3, kscreenHeight*0.83, 63, 63);
    [_clickQQ setImage:[UIImage imageNamed:@"log_qq_icon02"] forState:UIControlStateNormal];
    [_clickQQ setImage:[UIImage imageNamed:@"log_qq_icon02"] forState:UIControlStateSelected];
    [_clickQQ addTarget:self action:@selector(clickQQBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clickQQ];
    
    _clickWeiChat = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickWeiChat.frame = CGRectMake(kscreenWidth/3 + 63 + 5, kscreenHeight*0.83, 63, 63);
    [_clickWeiChat setImage:[UIImage imageNamed:@"log_wx_icon02"] forState:UIControlStateNormal];
    [_clickWeiChat setImage:[UIImage imageNamed:@"log_wx_icon02"] forState:UIControlStateSelected];
    [_clickWeiChat addTarget:self action:@selector(clickWeiChatBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clickWeiChat];
    
    _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kscreenHeight*0.92, kscreenWidth - 20, 30)];
    _companyLabel.text = @"华剑信息管理系统";
    _companyLabel.tintColor = [UIColor grayColor];
    _companyLabel.textAlignment = NSTextAlignmentCenter;
    _companyLabel.font = [UIFont systemFontOfSize:15];
    _companyLabel.alpha = 0.5;
    [self.view addSubview:_companyLabel];
}

#pragma mark ---clickSecureBut---
- (void)clickSecureBut:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setImage:[UIImage imageNamed:@"secure_press"] forState:UIControlStateNormal];
    }else {
        [sender setImage:[UIImage imageNamed:@"secure"] forState:UIControlStateNormal];
    }
    //  文字转换
    self.password.secureTextEntry = !self.password.secureTextEntry;
    NSString *s = self.password.text;
    self.password.text = @"";
    self.password.text = s;
}

#pragma mark ---- QQ 事件响应以及delegate ----
// QQ 登录
- (void)clickQQBut:(UIButton *)but
{
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1106126891" andDelegate:self];
    NSArray *permissons = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    // 调用登录
    [_tencentOAuth authorize:permissons inSafari:NO];
}

// 登录成功
- (void)tencentDidLogin
{
    NSLog(@"登录成功");
    if (_tencentOAuth.accessToken.length > 0) {
        // 获取用户信息
        [_tencentOAuth getUserInfo];
    }else {
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}

//非网络错误导致登录失败：
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        NSLog(@"用户取消登录");
    } else {
        NSLog(@"登录失败");
    }
}

- (void)tencentDidNotNetWork
{
    [self showAlertMessage:@"无网络状态" andTitle:@"提示"];
}

// 获取用户信息
- (void)getUserInfoResponse:(APIResponse *)response {
    
    if (response && response.retCode == URLREQUEST_SUCCEED) {
        
        NSDictionary *userInfo = [response jsonResponse];
        NSLog(@"QQ-userInfo--%@",userInfo);
        NSLog(@"headImage_qq_40@2x---%@",userInfo[@"figureurl_qq_1"]);
        
        NSLog(@"accessToken--%@",_tencentOAuth.accessToken);
        NSLog(@"openId---%@",_tencentOAuth.openId);
        NSLog(@"expirationDate---%@",_tencentOAuth.expirationDate);
        // 后续操作...
#warning QQ跳转到账号登录绑定页面
        DindingQQAndWXView *qqView= [[DindingQQAndWXView alloc] init];
        qqView.frame = CGRectMake(kscreenWidth/4, kscreenHeight/4, kscreenWidth/2, kscreenHeight/2);
        qqView.backgroundColor = [UIColor orangeColor];
//        [self.view addSubview:qqView];
    } else {
        NSLog(@"QQ auth fail ,getUserInfoResponse:%d", response.detailRetCode);
    }
}


#pragma mark ---- 微信 事件响应以及delegate ----
// 微信 登录
- (void)clickWeiChatBut:(UIButton *)but
{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
    if (accessToken && openID) {
        // 过期时，重新获取
        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
        NSString *refreshUrlStr = [NSString stringWithFormat:@"%@/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", WX_BASE_URL, WX_App_ID, refreshToken];
        NSURL *url = [NSURL URLWithString:refreshUrlStr];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data){
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSLog(@"请求reAccess的response = %@", dict);
                    NSString *reAccessToken = [dict objectForKey:WX_ACCESS_TOKEN];
                    // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
                    if (reAccessToken) {
                        // 更新access_token、refresh_token、open_id
                        [[NSUserDefaults standardUserDefaults] setObject:reAccessToken forKey:WX_ACCESS_TOKEN];
                        [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:WX_OPEN_ID] forKey:WX_OPEN_ID];
                        [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:WX_REFRESH_TOKEN] forKey:WX_REFRESH_TOKEN];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [self getWechatUserInfo]; // 获取用户个人信息（UnionID机制）
                        
                    }else {
                        [self wechatLogin];
                    }
                }
                
            });
        });
    }else {
        [self wechatLogin];
        
    }
}
///使用AccessToken获取用户信息
- (void)getWechatUserInfo
{
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openID];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([dict objectForKey:@"errcode"]) {
                    //AccessToken失效
                }else {
                    //获取需要的数据
                    NSLog(@"微信个人信息= %@",dict);
#warning WX跳转到账号登录绑定页面 (必须是有真机调试)
                    DindingQQAndWXView *qqView= [[DindingQQAndWXView alloc] init];
                    qqView.frame = CGRectMake(kscreenWidth/4, kscreenHeight/4, kscreenWidth/2, kscreenHeight/2);
                    qqView.backgroundColor = [UIColor orangeColor];
//                    [self.view addSubview:qqView];
                }
            }
            
        });
    });
    
}

- (void)wechatLogin {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq* req =[[SendAuthReq alloc ] init];
        // 获取你的公开信息 snsapi_userinfo
        req.scope = @"snsapi_userinfo";
        req.state = @"wx_oauth2_authorization_state";
        [WXApi sendReq:req];
    }
}


- (void)clickView
{
    [self.account endEditing:YES];
    [self.password endEditing:YES];
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
            [self showAlertMessage:@"无网络状态" andTitle:@"提示"];
        }
    }];
}

// 点击登录时，弹出对话框显示
- (void)showAlertMessage:(NSString *)message andTitle:(NSString *)title
{
    UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if ([message isEqualToString:@"登陆成功"]) {
// 跳转到tabbar
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            tabbarController *tabbar = [sb instantiateViewControllerWithIdentifier:@"tabbar"];
            [self presentViewController:tabbar animated:YES completion:nil];
        }else {
        
        }
    }];
    [loginAlert addAction:loginAction];
    [self presentViewController:loginAlert animated:YES completion:nil];
}

//  删除操作
- (IBAction)clickDeleteBut:(id)sender
{
    _password.text = @"";
}

// 点击登录按钮 获取用户输入的账号和密码
- (IBAction)clickLoginBut:(UIButton *)sender
{
    // 加载动画
    [self.activity startAnimating];
    _activityView.hidden = NO;
    
    _user = [NSUserDefaults standardUserDefaults];
    self.deviceToken = [_user objectForKey:@"deviceToken"];
    [self loginRequestAccount:self.account.text andPassword:self.password.text andDeviceToken:self.deviceToken];
   
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

// 登录请求
- (void)loginRequestAccount:(NSString *)account andPassword:(NSString *)pwd andDeviceToken:(NSString *)dt;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:account forKey:@"uiAccount"];
    [params setValue:pwd forKey:@"uiPassword"];
    [params setValue:dt forKey:@"pushid"];
    [params setValue:@"iOS" forKey:@"deviceOS"];
    
    [manager POST:LOGINURL parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    id status = responseObject[@"status"];
    if (![status isEqualToString:@"success"]) {
        [self showAlertMessage:responseObject[@"msg"] andTitle:@"提示"];
        // 关闭加载动画
        [self.activity stopAnimating];
        _activityView.hidden = YES;
        
        [self.account endEditing:NO];
        [self.password endEditing:NO];
    }else {
        // 关闭加载动画
        [self.activity stopAnimating];
        
        [self showAlertMessage:responseObject[@"msg"] andTitle:@"提示"];
// 保存本地用户数据
        _user = [NSUserDefaults standardUserDefaults];
        [_user setObject:self.account.text forKey:@"uiAccount"];
        [_user setObject:self.password.text forKey:@"uiPassword"];
        [_user setObject:responseObject[@"user"][@"uiId"] forKey:@"uiId"];  //个人ID
        if ([responseObject[@"user"][@"psId"] isEqual:[NSNull alloc]]) {
            [_user setObject:@"36" forKey:@"psId"];  //部门ID
        }else {
            [_user setObject:responseObject[@"user"][@"psId"] forKey:@"psId"];  //部门ID
        }
        if ([responseObject[@"user"][@"uiPsname"] isEqual:[NSNull alloc]]) {
            [_user setObject:@"#" forKey:@"uiPsname"];
        }else {
            [_user setObject:responseObject[@"user"][@"uiPsname"] forKey:@"uiPsname"];  // 部门名字
        }
        [_user setObject:responseObject[@"user"][@"uiName"] forKey:@"uiName"];  // 名字
        if ([responseObject[@"user"][@"uiHeadimage"] isEqual:[NSNull alloc]]) {
            [_user setObject:@"man" forKey:@"uiHeadimage"];
        }else {
            [_user setObject:responseObject[@"user"][@"uiHeadimage"] forKey:@"uiHeadimage"];
        }
        // 记录是否第一次登录
        NSInteger isFristLogin = 1;
        [_user setObject:[NSString stringWithFormat:@"%ld",(long)isFristLogin] forKey:@"isFrist"];
        
        // 考勤使用
        // 登录人的权限 是否为领导 -> 1 == 领导
        [_user setObject:responseObject[@"statistics"] forKey:@"statistics"];
        // 考勤组
        [_user setObject:[responseObject[@"sicrows"] firstObject][@"sciId"] forKey:@"sciId"];
        [_user setObject:[responseObject[@"sicrows"] firstObject][@"caSetCardInformation"][@"sciPiname"] forKey:@"sciPiname"];
        [_user synchronize];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
// 请求失败显示
        if (error) {
            // 关闭加载动画
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self.account endEditing:NO];
            [self.password endEditing:NO];
            [self showAlertMessage:@"登录失败!" andTitle:@"提示"];
        }
    }];
}

- (void)textHuaJianOA
{
    self.account.text = @"admin";
    self.password.text = @"admin666";
}

@end
