//
//  RecordsViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

/**
 内勤打卡界面
 */
 
#import "RecordsViewController.h"
#import "Header.h"
#import "CLLocationCell.h"
#import "NoteAndPickImageCell.h"
#import "RecordsCell.h"
#import "AFNetworking.h"
#import "NewsRecordModel.h" //模型
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface RecordsViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate, UITableViewDelegate, UITableViewDataSource, passPickImageVCFromNoteCell, passPostImageNewsFromNoteCell, passNotesFromNoteCell>

//@property (weak, nonatomic) IBOutlet BMKMapView *backMap;
@property (strong, nonatomic) BMKMapView *mapView;              // 地图
@property (strong, nonatomic) BMKLocationService *locService;   // 定位
@property (strong, nonatomic) NSString *nowAddressStr;          // 当前地址字符串

@property (strong, nonatomic) BMKCircleView *circleView;
@property (strong, nonatomic) BMKCircle *circle;

@property (assign, nonatomic) CLLocationCoordinate2D coo;           // 当前位置
@property (strong, nonatomic) CLLocation *loc;
@property (assign, nonatomic) CLLocationCoordinate2D cooCenterCoordinate;   // 考勤地点

@property (strong, nonatomic) UITableView *recordTab;
@property (strong, nonatomic) NSMutableArray *locArr;

@property (strong, nonatomic) UIImageView *freshLoc;   // 重新定位按钮
@property (strong, nonatomic) UILabel *locLabel;        // 文字
@property (strong, nonatomic) NSString *uiId;
@property (strong, nonatomic) NSNumber *scope;      // 范围半径
@property (assign, nonatomic) BOOL isOutW;          // 是否在考勤范围内

@property (strong, nonatomic) NSString *remark;     // 备注信息
@property (strong, nonatomic) NSString *imageNews;  // 图片信息

@end

@implementation RecordsViewController

- (BMKLocationService *)locService
{
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
        _locService.distanceFilter = 50.0f;
    }
    return _locService;
}

- (UILabel *)locLabel
{
    if (!_locLabel) {
        _locLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 25)];
        _locLabel.backgroundColor = [UIColor clearColor];
        _locLabel.text = @"重新定位";
        _locLabel.textAlignment = NSTextAlignmentCenter;
        _locLabel.font = [UIFont systemFontOfSize:13];
        _locLabel.userInteractionEnabled = YES;
    }
    return _locLabel;
}

- (UIImageView *)freshLoc
{
    if (!_freshLoc) {
        _freshLoc = [[UIImageView alloc] initWithFrame:CGRectMake(20, (kscreenHeight*0.8) - 40, 80, 25)];
        _freshLoc.backgroundColor = [UIColor whiteColor];
        _freshLoc.layer.cornerRadius = 10;
        _freshLoc.layer.masksToBounds = YES;
        _freshLoc.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFreloc)];
        [_freshLoc addGestureRecognizer:tap];
    }
    return _freshLoc;
}

- (NSMutableArray *)locArr
{
    if (!_locArr) {
        _locArr = [NSMutableArray array];
    }
    return _locArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    [self startMonitorNetWork];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
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
            [self.locArr removeAllObjects];
            [self.mapView removeAnnotations:self.mapView.annotations];
            [self mapViewDidFinishLoading:self.mapView];
        }else {
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示" andIsPre:NO];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    // 获取设置考勤的内容
    [self getContentOfAttendance];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight*0.8)];
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.zoomLevel = 19;
//    self.mapView.showsUserLocation = YES;
    self.recordTab = [[UITableView alloc] initWithFrame:CGRectMake(0, kscreenHeight*0.8, kscreenWidth, kscreenHeight*0.2) style:UITableViewStylePlain];
    self.recordTab.backgroundColor = [UIColor whiteColor];
    self.recordTab.dataSource = self;
    self.recordTab.delegate = self;
    self.recordTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.recordTab];
    [self.view addSubview:self.mapView];
    [self registerTableviewCell];
    self.recordTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.recordTab.scrollEnabled = NO;
// 添加重新定位按钮
    [self.freshLoc addSubview:self.locLabel];
    [self.mapView addSubview:self.freshLoc];
    
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

// 重新定位按钮
- (void)tapFreloc
{
    [self startMonitorNetWork];
}

- (void)registerTableviewCell
{
    // 定位信息
    [self.recordTab registerNib:[UINib nibWithNibName:@"CLLocationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cllocationCell"];
    // 定位备注和拍照
    [self.recordTab registerNib:[UINib nibWithNibName:@"NoteAndPickImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"noteAndPickImageCell"];
    // 定位按钮
    [self.recordTab registerNib:[UINib nibWithNibName:@"RecordsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"recordsCell"];
}

// 获取设置考勤的内容
- (void)getContentOfAttendance
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.uiId = [user objectForKey:@"uiId"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"crUiid":self.uiId};
    [manager POST:newsRecordsUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject[@"rows"] firstObject];
        NSDictionary *dic1 = dic[@"caSetCardInformation"];
        NSNumber *latitude = dic1[@"sciLatitude"];
        NSNumber *longitude = dic1[@"sciLongitude"];
        _scope = dic1[@"sciScope"];
            // 将中心点的数据和范围的数据传递
        [self creatMapCircleLatitude:latitude andLongitude:longitude andScope:_scope];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

// 画出考勤范围
- (void)creatMapCircleLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude andScope:(NSNumber *)scope
{
    _cooCenterCoordinate.latitude = latitude.doubleValue;
    _cooCenterCoordinate.longitude = longitude.doubleValue;
    _circle = [BMKCircle circleWithCenterCoordinate:_cooCenterCoordinate radius:scope.doubleValue];
    [self.mapView addOverlay:_circle];
}

// 将画好的圆加载到地图中
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKCircle class]]) {
        _circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        _circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
        _circleView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
        _circleView.lineWidth = 0.01;
        return _circleView;
    }
    return nil;
}

// 开始定位。定位完成会跳出方法。
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    [self.locService startUserLocationService];
}

// 定位 进行反地理编码，显示出详细位置
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    // 更新位置
    [self.mapView updateLocationData:userLocation];
    if (userLocation.location) {
        // 定位完。停止定位
        [self.locService stopUserLocationService];
        // 获取当前位置
        _loc = userLocation.location;
        _coo.latitude = userLocation.location.coordinate.latitude;
        _coo.longitude = userLocation.location.coordinate.longitude;
        // 判断当前位置和设定位置
        self.isOutW = BMKCircleContainsCoordinate(_coo, _cooCenterCoordinate, _scope.doubleValue);;
        // 更新当前位置到地图中间
        _mapView.centerCoordinate = _loc.coordinate;
        // 添加大头针
        BMKPointAnnotation *ann = [[BMKPointAnnotation alloc] init];
        ann.coordinate = _loc.coordinate;
        ann.title = userLocation.title;
        [self.mapView addAnnotation:ann];
        // 获取地址信息
        [self getDetailsInformationFromLoacation:_loc];
    }
}

// 添加大头针
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

// 反地理编码，将获取的到的经纬信息编码成地址信息
- (void)getDetailsInformationFromLoacation:(CLLocation *)loc
{
    CLGeocoder *geoC = [[CLGeocoder alloc] init];
    [geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
//            NSLog(@"error---%@",error);
            [self showAlertControllerMessage:@"获取地址失败,请移至信号较好的地方" andTitle:@"提示" andIsPre:NO];
        }
        CLPlacemark *pl = placemarks.firstObject;
        NSDictionary *text = [pl addressDictionary];
        NSString *ss = [text objectForKey:@"FormattedAddressLines"][0];
        NSArray *locArr = [ss componentsSeparatedByString:@"中国"];
        NSString *locStr = locArr.lastObject;
        NSString *address = @"";
        if (text[@"Name"] != nil) {
            if (locStr != nil) {
                address = [NSString stringWithFormat:@"%@%@",locStr,text[@"Name"]];
            }
        }else {
            if (locStr != nil) {
                address = locStr;
            }
        }
        [self.locArr addObject:address];
        [self.recordTab reloadData];
    }];
}



#pragma make--tableView--delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {   // 定位信息
        CLLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cllocationCell" forIndexPath:indexPath];
        cell.myCLLocation.text = self.locArr.firstObject;
        if (self.isOutW) {
            cell.status.text = @"正常";
            cell.status.backgroundColor = [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0];
        }else {
            cell.status.text = @"外勤";
            cell.status.backgroundColor = [UIColor orangeColor];
        }
        cell.status.layer.cornerRadius = 2;
        cell.status.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1) { // 定位备注和照片按钮
        NoteAndPickImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteAndPickImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.passNotesDelegate = self;
        cell.passImagePickDelegate = self;
        cell.passImageNewsDelegate = self;
        return cell;
    }else if (indexPath.row == 2) { // 打卡按钮
        RecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.isOutW) {
            [cell.recordNews setTitle:@"正常打卡" forState:UIControlStateNormal];
        }else {
            [cell.recordNews setTitle:@"外勤打卡" forState:UIControlStateNormal];
        }
        [cell.recordNews addTarget:self action:@selector(clickRecordNews) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark --NoteCellDelegate--
// 备注信息
- (void)passNotesFromNoteCell:(NSString *)notes
{
    self.remark = notes;
}
// 跳转到照相机视图
- (void)passPickImageVCFromNoteCell:(UIImagePickerController *)imagePick
{
    [self presentViewController:imagePick animated:YES completion:^{}];
}

- (void)passPostImageNewsFromNoteCellWithImageNews:(NSString *)imageNews andSuccess:(BOOL)success
{
    if (success) {
        [self showAlertControllerMessage:@"上传成功" andTitle:@"确定" andIsPre:NO];
        self.imageNews = imageNews;
    }else {
        [self showAlertControllerMessage:@"上传失败，请稍后再试" andTitle:@"确定" andIsPre:NO];
    }
}

// 点击上传信息
- (void)clickRecordNews
{
//    NSLog(@"%@--%@",self.imageNews,self.remark);
    NewsRecordModel *model = self.data.firstObject;
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    [paras setObject:self.uiId forKey:@"crUiid"];
    
    if (model.DKRecord == nil) {    // 没有打卡数据
        NSString *date = [model.nowDate componentsSeparatedByString:@" "].lastObject;
        NSString *hour = [date componentsSeparatedByString:@":"].firstObject;
        
        if (hour.integerValue >= 12) {  //下午
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.longitude] forKey:@"crXblongitude"];
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.latitude] forKey:@"crXblatitude"];
            [paras setObject:[NSString stringWithFormat:@"%@",self.locArr.firstObject] forKey:@"crXbaddress"];
            [paras setObject:@"1" forKey:@"crSborXb"];
            [paras setObject:@"2" forKey:@"crXbmachinerytype"];
            if (self.isOutW) {  // 内外勤
                [paras setObject:@"1" forKey:@"crXbcardtype"];
            }else {
                [paras setObject:@"2" forKey:@"crXbcardtype"];
            }
            if (self.remark) {
                [paras setObject:self.remark forKey:@"crXbremark"];
            }else {
                [paras setObject:@"" forKey:@"crXbremark"];
            }
            if (self.imageNews) {
                [paras setObject:self.imageNews forKey:@"crXbimg"];
            }else {
                [paras setObject:@"" forKey:@"crXbimg"];
            }
            if (self.crid) {
                [paras setObject:self.crid forKey:@"crId"];
            }else {
                [paras setObject:@"" forKey:@"crId"];
            }
        }else {
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.longitude] forKey:@"crSblongitude"];
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.latitude] forKey:@"crSblatitude"];
            [paras setObject:[NSString stringWithFormat:@"%@",self.locArr.firstObject] forKey:@"crSbaddress"];
            [paras setObject:@"0" forKey:@"crSborXb"];
            [paras setObject:@"2" forKey:@"crSbmachinerytype"];
            if (self.isOutW) {
                [paras setObject:@"1" forKey:@"crSbcardtype"];
            }else {
                [paras setObject:@"2" forKey:@"crSbcardtype"];
            }
            if (self.remark) {
                [paras setObject:self.remark forKey:@"crSbremark"];
            }else {
                [paras setObject:@"" forKey:@"crSbremark"];
            }
            if (self.imageNews) {
                [paras setObject:self.imageNews forKey:@"crSbimg"];
            }else {
                [paras setObject:@"" forKey:@"crSbimg"];
            }
        }
    }else { // 有打卡数据
        if (model.DKRecord[@"crSbcardtime"] == nil || [model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) {   // 上午
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.longitude] forKey:@"crSblongitude"];
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.latitude] forKey:@"crSblatitude"];
            [paras setObject:[NSString stringWithFormat:@"%@",self.locArr.firstObject] forKey:@"crSbaddress"];
            [paras setObject:@"0" forKey:@"crSborXb"];
            [paras setObject:@"2" forKey:@"crSbmachinerytype"];
            if (self.isOutW) {
                [paras setObject:@"1" forKey:@"crSbcardtype"];
            }else {
                [paras setObject:@"2" forKey:@"crSbcardtype"];
            }
            if (self.remark) {
                [paras setObject:self.remark forKey:@"crSbremark"];
            }else {
                [paras setObject:@"" forKey:@"crSbremark"];
            }
            if (self.imageNews) {
                [paras setObject:self.imageNews forKey:@"crSbimg"];
            }else {
                [paras setObject:@"" forKey:@"crSbimg"];
            }
        }else if (model.DKRecord[@"crXbcardtime"] == nil || [model.DKRecord[@"crXbcardtime"] isKindOfClass:[NSNull class]]) {   // 下午
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.longitude] forKey:@"crXblongitude"];
            [paras setObject:[NSString stringWithFormat:@"%f",_coo.latitude] forKey:@"crXblatitude"];
            [paras setObject:[NSString stringWithFormat:@"%@",self.locArr.firstObject] forKey:@"crXbaddress"];
            [paras setObject:@"1" forKey:@"crSborXb"];
            [paras setObject:@"2" forKey:@"crXbmachinerytype"];
            if (self.isOutW) {  // 内外勤
                [paras setObject:@"1" forKey:@"crXbcardtype"];
            }else {
                [paras setObject:@"2" forKey:@"crXbcardtype"];
            }
            if (self.remark) {
                [paras setObject:self.remark forKey:@"crXbremark"];
            }else {
                [paras setObject:@"" forKey:@"crXbremark"];
            }
            if (self.imageNews) {
                [paras setObject:self.imageNews forKey:@"crXbimg"];
            }else {
                [paras setObject:@"" forKey:@"crXbimg"];
            }
            if (self.crid) {
                [paras setObject:self.crid forKey:@"crId"];
            }else {
                [paras setObject:@"" forKey:@"crId"];
            }
        }
    }
    if ((_coo.longitude == 0 && _coo.longitude == 0) || self.locArr.count == 0) {
        [self showAlertControllerMessage:@"请设置定位功能开启" andTitle:@"提示" andIsPre:NO];
    }else {
        [self postAttendanceNewsWithParameters:paras];
    }
}

// 上传考勤信息
- (void)postAttendanceNewsWithParameters:(NSMutableDictionary *)parameters;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:senderRecordNewsUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            [self showAlertControllerMessage:@"打卡成功" andTitle:@"确定" andIsPre:YES];
        }
        [self showAlertControllerMessage:@"打卡失败,请稍后再试" andTitle:@"确定" andIsPre:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"打卡失败,请检查网络" andTitle:@"确定" andIsPre:NO];
    }];
}

// 键盘
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
//    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
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
