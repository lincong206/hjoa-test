//
//  FieldworkViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

/**
 外勤签到界面
 */

#import "FieldworkViewController.h"
#import "FieldWorkCell.h"
#import "AFNetworking.h"
#import "Header.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface FieldworkViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate,UITableViewDelegate, UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UIView *backMapView;
@property (weak, nonatomic) IBOutlet UITableView *addressTab;
//@property (weak, nonatomic) IBOutlet BMKMapView *backMap;

//@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (strong, nonatomic) BMKMapView *mapView;              // 地图
@property (strong, nonatomic) BMKLocationService *locService;   // 定位
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;  // 搜索服务

@property (assign, nonatomic) CLLocationCoordinate2D coo;
@property (strong, nonatomic) NSString *uiId;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *localAddress;
@property (strong, nonatomic) NSString *fielWorkUrl;

@property (strong, nonatomic) NSMutableArray *addressArr;

@property (weak, nonatomic) IBOutlet UIButton *fieldBut;

@property (assign, nonatomic) BOOL isNet;   // 是否有网络

@end

@implementation FieldworkViewController

- (NSMutableArray *)addressArr
{
    if (!_addressArr) {
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.geocodesearch.delegate = self;
    [self startMonitorNetWork];
    self.title = @"外勤签到";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    self.geocodesearch.delegate = nil;
    self.tabBarController.tabBar.hidden = NO;
}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self startLocation];
            _isNet = YES;
        }else {
            _isNet = NO;
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示"];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, kscreenWidth, kscreenHeight*0.5)];
    self.addressTab.frame = CGRectMake(0, kscreenHeight*0.5, kscreenWidth, kscreenHeight*0.5);
    self.addressTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.zoomLevel = 18;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.addressTab];
    [self creatFieldBut];
    
    self.geocodesearch = [[BMKGeoCodeSearch alloc] init];
}

//初始化BMKLocationService
- (void)startLocation
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //启动LocationService
    [_locService startUserLocationService];
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //普通态
    //以下_mapView为BMKMapView对象
    [_mapView updateLocationData:userLocation]; //更新地图上的位置
    _mapView.centerCoordinate = userLocation.location.coordinate; //更新当前位置到地图中间
    //地理反编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag){
//        NSLog(@"反geo检索发送成功");
        [_locService stopUserLocationService];
        _coo.latitude = userLocation.location.coordinate.latitude;
        _coo.longitude = userLocation.location.coordinate.longitude;
        [self.addressArr removeAllObjects];
    }else{
//        NSLog(@"反geo检索发送失败");
    }
}

#pragma make 地理反编码的delegate
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
//    NSLog(@"address:%@----businessCircle%@",result.address, result.businessCircle);
    
    _address = result.address;
    
    //addressDetail:     层次化地址信息
    //address:    地址名称
    //businessCircle:  商圈名称
    // location:  地址坐标
    //  poiList:   地址周边POI信息，成员类型为BMKPoiInfo
    
        for (BMKPoiInfo *info in result.poiList) {
            // 添加数据
            [self.addressArr addObject:info];
//            NSLog(@"info--%@",info);
        }
    [self.addressTab reloadData];
    
    //    NSString* _name;			///<POI名称
    //    NSString* _uid;
    //    NSString* _address;		///<POI地址
    //    NSString* _city;			///<POI所在城市
    //    NSString* _phone;		///<POI电话号码
    //    NSString* _postcode;		///<POI邮编
    //    int		  _epoitype;		///<POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
    //    CLLocationCoordinate2D _pt;	///<POI坐标
}

#pragma make-tableView--Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FieldWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fieldworkCell" forIndexPath:indexPath];
    BMKPoiInfo *info = self.addressArr[indexPath.row];
    cell.nameLabel.text = info.address;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.attendanceBut.tag = indexPath.row + 300;
    [cell.attendanceBut addTarget:self action:@selector(clickAtt:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

// 创建考勤按钮
- (void)creatFieldBut
{
    self.fieldBut.center = self.view.center;
    self.fieldBut.layer.cornerRadius = self.fieldBut.frame.size.width/2.0;
    self.fieldBut.layer.masksToBounds = YES;
    self.fieldBut.backgroundColor = [UIColor lightGrayColor];
    self.fieldBut.alpha = 0.6;
    self.fieldBut.tag = 299;
    [self.fieldBut setTitle:@"考勤" forState:UIControlStateNormal];
    [self.fieldBut setTitle:@"考勤" forState:UIControlStateSelected];
    [self.fieldBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.fieldBut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.fieldBut addTarget:self action:@selector(clickAtt:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:self.fieldBut];
}

- (void)clickAtt:(UIButton *)bbt
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.uiId = [user objectForKey:@"uiId"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (!_isNet) {
        [self showAlertControllerMessage:@"请检查网络状态" andTitle:@"提示"];
    }else {
        if (self.address) {
            if (bbt.tag == 299){
                [parameters setObject:self.address forKey:@"waEvectionarea"];
            }else {
                BMKPoiInfo *info = self.addressArr[bbt.tag - 300];
                self.address = info.address;
                [parameters setObject:self.address forKey:@"waEvectionarea"];
            }
        }
        
        [parameters setObject:[NSString stringWithFormat:@"%f",_coo.longitude] forKey:@"waAttendancelongitude"];
        [parameters setObject:[NSString stringWithFormat:@"%f",_coo.latitude]       forKey:@"waAttendancelatitude"];
        [parameters setObject:self.uiId forKey:@"uiId"];
        [parameters setObject:@"外勤签到iOS" forKey:@"waNote"];
    
        [manager POST:fieldWork_URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self showAlertControllerMessage:responseObject[@"msg"] andTitle:@"确定"];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
