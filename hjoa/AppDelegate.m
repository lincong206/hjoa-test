//
//  AppDelegate.m
//  hjoa
//
//  Created by 华剑 on 2017/3/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "ViewController.h"
#import "tabbarController.h"
#import "WelcomeViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

#import "DindingQQAndWXView.h"

//#import <HyphenateLite/>

@interface AppDelegate () <UISplitViewControllerDelegate, UNUserNotificationCenterDelegate, WXApiDelegate>
{
    BMKMapManager *_mapManager;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 百度地图SDK
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"HAUgIvSInkCeBD5G62RKmCSANRNzGISv" generalDelegate:nil];
    if (!ret) {
        NSLog(@"_mapManager is failed!");
    }
    
    // 友盟推送
    [UMessage startWithAppkey:@"59000d4dc62dca5faf00230f" launchOptions:launchOptions httpsEnable:YES];
    //注册通知
    [UMessage registerForRemoteNotifications];
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            
        } else {
            //点击不允许
            
        }
    }];
        //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
        if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
            UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
            action1.identifier = @"action1_identifier";
            action1.title=@"打开应用";
            action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
            UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
            action2.identifier = @"action2_identifier";
            action2.title=@"忽略";
            action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
            action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
            action2.destructive = YES;
            UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
            actionCategory1.identifier = @"category1";//这组动作的唯一标示
            [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
            NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
            [UMessage registerForRemoteNotifications:categories];
        }
        //如果要在iOS10显示交互式的通知，必须注意实现以下代码
        if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
            UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
            UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
    
            //UNNotificationCategoryOptionNone
            //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
            //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
            UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category101" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
            NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
            [center setNotificationCategories:categories_ios10];
        }
    
//    如果对角标，文字和声音的取舍，请用下面的方法
//    UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
//    UIUserNotificationType types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
//    [UMessage registerForRemoteNotifications:categories withTypesForIos7:types7 withTypesForIos8:types8];
    
    //for log
    [UMessage setAutoAlert:NO];
    [UMessage setLogEnabled:YES];
    
    
    // 环信即使通讯
    
    
    // 微信登录
    [WXApi registerApp:WX_App_ID];
    
    
// 判断是否为第一次登录。如果是跳转到ViewController 不是跳转到tabbarController
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginVC"];
    tabbarController *tabbar = [sb instantiateViewControllerWithIdentifier:@"tabbar"];
    WelcomeViewController *wel = [sb instantiateViewControllerWithIdentifier:@"welcomeVC"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isF = [user objectForKey:@"isFrist"];
    if (isF.integerValue) {
        self.window.rootViewController = tabbar;//tabbar//loginVC;
    }else {
#pragma 加载引导页面  判断版本号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        if (![user boolForKey:appCurVersion]) {
            self.window.rootViewController = wel;
            [user setBool:YES forKey:appCurVersion];
            [user synchronize];
        }else {
            self.window.rootViewController = loginVC;
        }
    }
    [self.window makeKeyWindow];
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //获取deviceToken
    NSString *tokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""]               stringByReplacingOccurrencesOfString: @"" withString: @""];
    NSArray *tokenArr = [tokenStr componentsSeparatedByString:@" "];
    NSString *deviceTo = [tokenArr componentsJoinedByString:@""];
    // 保存到沙盒
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:deviceTo forKey:@"deviceToken"];
    [user synchronize];
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark ----QQ集成  重写AppDelegate 的handleOpenURL和openURL方法----

//openURL:
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

//handleOpenURL:
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}

#pragma mark ----微信集成----
///从微信端打开第三方APP会调用此方法,此方法再调用代理的onResp方法
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}

/**! 微信回调，不管是登录还是分享成功与否，都是走这个方法
 */
-(void) onResp:(BaseResp*)resp{
    NSLog(@"resp %d",resp.errCode);
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            NSLog(@"授权登录成功！");
            SendAuthResp *aresp = (SendAuthResp *)resp;
            [self getAccessTokenWithCode:aresp.code];
        }
    }
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        //使用UIAlertView 显示回调信息
        NSString *str = [NSString stringWithFormat:@"%d",resp.errCode];
        if ([str isEqualToString:@"0"]) {
            NSLog(@"分享成功！");
        }
    }
}

- (void)getAccessTokenWithCode:(NSString *)code
{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_App_ID,WX_AppSecret,code];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([dict objectForKey:@"errcode"]) {
                    //获取token错误
                }else {
                    //存储AccessToken OpenId RefreshToken以便下次直接登陆,  AccessToken有效期两小时，RefreshToken有效期三十天
                    
                    NSString *accessToken = [dict objectForKey:WX_ACCESS_TOKEN];
                    NSString *openID = [dict objectForKey:WX_OPEN_ID];
                    NSString *refreshToken = [dict objectForKey:WX_REFRESH_TOKEN];
                    
                    if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
                        [[NSUserDefaults standardUserDefaults] setObject:openID forKey:WX_OPEN_ID];
                        [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
                        [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
                    }
                    //通过代理吧对应的登录消息传送到登录控制器页面
                    // 通过代理方法 [self.delegate getWechatUserInfo]; // 使用AccessToken获取用户信息
                    
                }
            }
            
        });
    });
}

@end
