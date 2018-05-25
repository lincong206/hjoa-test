//
//  NewRecordViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/9/15.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  新移动考勤

#import "NewRecordViewController.h"
#import "AFNetworking.h"
#import "Header.h"
#import "NewsRecordModel.h"
#import "RecordNewsCell.h"  // 个人信息 第一行
#import "AMRecordsCell.h"
#import "PMRecordsCell.h"

#import "RecordSuccessView.h"
#import "RecordView.h"
#import "CLLocation+YCLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "RCDateTimeUtils.h"
#import "RecordsViewController.h"
#import "BaseButtonView.h"

#import "ApplyRecordsViewController.h"
#import "NewRecordCountViewController.h"
#import "NewRecordsApplyViewController.h"
#import "RecordsCountViewController.h"
#import "RecordSettingViewController.h"

#import "GSKeyChainDataManager.h"

@interface NewRecordViewController () <UITableViewDelegate, UITableViewDataSource, passPickViewFromRecordNewsCell, passDateFromRecordNewsCell, passStatusCodeFromAM, passStatusCodeFromPM, CLLocationManagerDelegate, passClickTimeFromPM, passClickTimeFromAM, passImagePickFromRecordView, passPostImageNewsFromRecordView, passNotesFromRecordView, passButFromBaseView>
{
    NSString *_officeAddres;        // 内勤人员打卡默认地址
    NSDateFormatter *_formatter;
}

@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;

@property (strong, nonatomic) UITableView *NewRecordTable;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) NSUserDefaults *user;
@property (strong, nonatomic) NSString *myId;
@property (strong, nonatomic) NSString *dateTime;   // 查询日期
@property (assign, nonatomic) NSInteger isNow;           // 判断查询日期是否为今天
@property (assign, nonatomic) BOOL isOfficeWorker;        // 是否为内勤
@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic, strong) CLLocation *loc;                  // 当前位置
@property (nonatomic, strong) NSString *address;                // 地址
@property (nonatomic, strong) NSString *params;                 // 街道地址
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (strong, nonatomic) BaseButtonView *baseView;         // 底部按钮
@property (strong, nonatomic) RecordSuccessView *successView;   // 打卡成功View
@property (strong, nonatomic) RecordView *recordView;           // 打卡view
@property (strong, nonatomic) UIView *backView;                 // 背景View
@property (assign, nonatomic) BOOL isLate;                      // 是否迟到         -> true 未迟到
@property (assign, nonatomic) NSTimeInterval interval;          // 记录当时获取数据的时间
@property (strong, nonatomic) NSString *imageNews;              // 图片信息
@property (strong, nonatomic) NSString *remark;     // 备注信息

@property (strong, nonatomic) NSTimer *timer;       // 定时器
@property (strong, nonatomic) NSString *crId;       // 更新打卡参数
@property (strong, nonatomic) NSString *now;        // 当前时间

@end

@implementation NewRecordViewController

- (UITableView *)NewRecordTable
{
    if (!_NewRecordTable) {
        _NewRecordTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _NewRecordTable.backgroundColor = [UIColor whiteColor];
        _NewRecordTable.delegate = self;
        _NewRecordTable.dataSource = self;
    }
    return _NewRecordTable;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    }
    return _backView;
}

- (BaseButtonView *)baseView
{
    if (!_baseView) {
        _baseView = [[BaseButtonView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 70, kscreenWidth, 50)];
        _baseView.nameArr = @[@"文档",@"申请",@"统计",@"设置"];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.passButDelegate = self;
    }
    return _baseView;
}

- (RecordView *)recordView
{
    if (!_recordView) {
        _recordView = [[RecordView alloc] initWithFrame:CGRectMake(60, 200, kscreenWidth-120, kscreenHeight-360)];
        _recordView.backgroundColor = [UIColor whiteColor];
    }
    return _recordView;
}

- (RecordSuccessView *)successView
{
    if (!_successView) {
        _successView = [[RecordSuccessView alloc] initWithFrame:CGRectMake(60, 200, kscreenWidth-120, kscreenHeight-360)];
        _successView.backgroundColor = [UIColor orangeColor];
    }
    return _successView;
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.backgroundColor = [UIColor clearColor];
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

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    backBut.backgroundColor = [UIColor clearColor];
    [backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut setImage:[UIImage imageNamed:@"record_backBut"] forState:UIControlStateNormal];
    // 让返回按钮内容继续向左边偏移10
    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBut addTarget:self action:@selector(clickBackBut:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBut];
    
    self.title = @"移动考勤";
    self.baseView.count = 200;
    [self.view addSubview:self.baseView];
    
    if (!self.timer) {
        // 开启定时器
        [self postDataToServces];
    }
}

- (void)clickBackBut:(UIButton *)but
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    // 暂停
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.activity startAnimating];
//    self.activityView.hidden = NO;
    
    // 开启定位
    [self initLoc];
    
    [self initViewController];
    
}

- (void)initViewController
{
    self.backView.hidden = YES;
    
    [self.view addSubview:self.NewRecordTable];
    // 注册cell
    [self declareTableViewCell];

    self.NewRecordTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark --passButFromBaseView--
- (void)passBaseViewBut:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (but.tag == 201) {
        NewRecordsApplyViewController *applyVC = [sb instantiateViewControllerWithIdentifier:@"nrApplyVC"];
        [self.navigationController pushViewController:applyVC animated:YES];
    }else if (but.tag == 202) {
        RecordsCountViewController *count = [sb instantiateViewControllerWithIdentifier:@"rCountVC"];
        [self.navigationController pushViewController:count animated:YES];
    }else if (but.tag == 203) {
        RecordSettingViewController *settingVC = [sb instantiateViewControllerWithIdentifier:@"recordSettingVC"];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

// 获取打卡信息
- (void)postDataToServces
{
    self.user = [NSUserDefaults standardUserDefaults];
    self.myId = [self.user objectForKey:@"uiId"];

    if (self.dateTime) {
        // 获取某一天考勤数据
        [self loadInformationWithUrl:inquiryRecordNewsUrl andParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"crUiid":self.myId,@"crSbcardtime":self.dateTime}]];
    }else {
        // 获取当天考勤信息
        [self loadInformationWithUrl:newsRecordsUrl andParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"crUiid":self.myId}]];
    }
}

// 获取打卡信息
- (void)loadInformationWithUrl:(NSString *)url andParameters:(NSMutableDictionary *)parameters
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self.dataSource removeAllObjects];
    self.manager = [AFHTTPSessionManager manager];
    
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"noAddress"]) {
            [self.activity stopAnimating];
            self.activityView.hidden = YES;
            [self showAlertControllerMessage:@"无打卡点信息，请联系管理员进行设置" andTitle:@"提示" andIsPre:NO];
        }else if ([responseObject[@"status"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                NewsRecordModel *model = [[NewsRecordModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:model];
                // 获取考勤地址(默认地址)
                _officeAddres = dic[@"caSetCardInformation"][@"sciPiname"];
            }
            //  刷新数据
            [self.NewRecordTable reloadData];
            // 开启定位
//            [self initLoc];
            // 获取当前日期时间戳(用于定时器)
            [self returnCellRefreshTime];
            // 判断 服务器时间与当前时间对比 只对比年月日
            // 获取当前时间
            if (!_formatter) {
                _formatter = [[NSDateFormatter alloc] init];
            }
            [_formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *date = [_formatter stringFromDate:[NSDate date]];
            if (self.dateTime == nil) {
                self.dateTime = [[[responseObject[@"rows"] firstObject] [@"nowDate"] componentsSeparatedByString:@" "] firstObject];
            }
            self.isNow = [self compareNowTime:date withOtherTime:self.dateTime withDateFormatter:_formatter];
            if (self.isNow == 1) {
                // 获取crId (下来打下班卡)
                NewsRecordModel *model = self.dataSource.firstObject;
                if (model.DKRecord != nil) {
                    self.crId = model.DKRecord[@"crId"];
                }
            }
            // 判断是否开启定时器
            [self isStartTimerWithisNow:self.isNow];
            
        }else {
            [self showAlertControllerMessage:@"无信息" andTitle:@"提示" andIsPre:NO];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activity stopAnimating];
        self.activityView.hidden = YES;
        [self showAlertControllerMessage:@"网络加载失败，请稍后再试" andTitle:@"提示" andIsPre:NO];
    }];
}

// 开启定位
- (void)initLoc
{
    _locManager = [[CLLocationManager alloc] init];
    _locManager.delegate = self;
    _locManager.desiredAccuracy = kCLLocationAccuracyBest;
//    _locManager.distanceFilter = 100;
    // YES-> 当不需要定位功能时，会自动暂停  NO-> 需要在后台15分钟之后暂停
    _locManager.pausesLocationUpdatesAutomatically = YES;
    // 实现后台定位
    /*
     if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
     [_locManager requestWhenInUseAuthorization];
     [_locManager requestAlwaysAuthorization];
     }
     if ([[UIDevice currentDevice].systemVersion floatValue] > 9.0) {
     [_locManager requestAlwaysAuthorization];
     _locManager.allowsBackgroundLocationUpdates = YES;
     }
     */
    // 开始定位
    [_locManager startUpdatingLocation];
}

// 定位delegate 自动调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
#if 1
    NewsRecordModel * model = self.dataSource.firstObject;
//    double lat1 = [model.caSetCardInformation[@"sciLatitude"] doubleValue] + 1;
//    double lon1 = [model.caSetCardInformation[@"sciLongitude"] doubleValue] + 1;
//    CLLocation *testLoc = [[CLLocation alloc] initWithLatitude:lat1 longitude:lon1];
    _loc = locations.firstObject;
    //把定位坐标转成火星坐标 再转成百度坐标
    _loc = [[_loc locationMarsFromEarth] locationBaiduFromMars];
    // 考勤点坐标
    CLLocation *oldLoc = [[CLLocation alloc] initWithLatitude:[model.caSetCardInformation[@"sciLatitude"] doubleValue]  longitude:[model.caSetCardInformation[@"sciLongitude"] doubleValue]];
    // 定位点坐标
    CLLocation *newLoc = [[CLLocation alloc] initWithLatitude:_loc.coordinate.latitude longitude:_loc.coordinate.longitude];
    // 获得两个经纬度之间的距离
//    CLLocationDistance meters = [testLoc distanceFromLocation:newLoc];
    CLLocationDistance meters = [oldLoc distanceFromLocation:newLoc];
    if (meters > [model.caSetCardInformation[@"sciScope"] doubleValue]) {
        self.isOfficeWorker = NO;   // 外勤
    }else {
        self.isOfficeWorker = YES;  // 内勤
    }
//    NSLog(@"meters%f--isOfficeWorker--%@",meters,self.isOfficeWorker?@"YES":@"NO");
    [self.NewRecordTable reloadData];
    [self getAddressNewsFromCLLocation];
#else
    _loc = locations.firstObject;
    // 避免重复数据提交
    if ((_loc.coordinate.latitude != _old_lat) || (_loc.coordinate.longitude != _old_lon) ){
        _old_lat = _loc.coordinate.latitude;
        _old_lon = _loc.coordinate.longitude;
        [self getAddressNewsFromCLLocation];
    }
#endif
}

// 通过经纬度得到地址
- (void)getAddressNewsFromCLLocation
{
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:_loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *placeMark in placemarks) {
            NSDictionary *addressDic = placeMark.addressDictionary;
            _address = [[[addressDic[@"FormattedAddressLines"] firstObject] componentsSeparatedByString:@"中国"] lastObject];
            _params = addressDic[@"Name"];
        }
    }];
}
// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager startUpdatingLocation];
}

/*  
 1、判断获取到的上午和下午的数据是否为空
 2、当上午的数据为空时，判断当前时间是否为上午
    若当前时间为上午，需要判断当前时间与考勤时间的时间差(0->正常考勤时间,1->迟到考勤时间)
    若当前时间为下午，则一定为迟到考勤
 当上午的数据不为空时，则加载
 3、当下午的数据为空时，判断当前时间是否为下午
    若当前时间为下午，需要判断当前时间与考勤时间的时间差(0->早退打卡,1->正常下班打卡)
    若当前时间为上午，则还未到时间
 当下午的数据不为空时，则加载
 */

// 获取现在的时间，来获取一秒钟的间隔
- (void)returnCellRefreshTime
{
    // 记录当时获取数据的时间
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.interval = [[NSDate date] timeIntervalSince1970];
}

// 判断定时器是否开启(为当天就开启 isNow->1)
- (void)isStartTimerWithisNow:(NSInteger)isNow
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (isNow == 1) {
        NewsRecordModel *model = self.dataSource.firstObject;
        // 判断上班和下班打卡信息是否存在
        if (model.DKRecord[@"crSbcardtime"] != nil && model.DKRecord[@"crXbcardtime"] != nil && ![model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]] && ![model.DKRecord[@"crXbcardtime"] isKindOfClass:[NSNull class]]) {
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
        }else {
            // 开启定时器
            [self showCellTimeWithData:self.dataSource];
        }
    }else {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

#pragma mark ----注册cell----
- (void)declareTableViewCell
{
    [self.NewRecordTable registerNib:[UINib nibWithNibName:@"RecordNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"rnCell"];
    [self.NewRecordTable registerNib:[UINib nibWithNibName:@"AMRecordsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"amRecordsCell"];
    [self.NewRecordTable registerNib:[UINib nibWithNibName:@"PMRecordsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"pmRecordsCell"];
}

#pragma mark ----NewRecordTable Delegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count) {
        return 3;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {   // 打卡人信息
        RecordNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rnCell" forIndexPath:indexPath];
        [cell refreRecordNewsCellWithDateTime:self.dateTime];
        cell.recordNewsCellDelegate = self;
        cell.dateDelegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1) { // 上午打卡
        AMRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"amRecordsCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.NewRecordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.passCodeDalagate = self;
        if (self.isNow == 1) {
            cell.isOffice = self.isOfficeWorker;
            cell.locString = _params;
            cell.interval = self.interval;
            cell.passTimeDelegate = self;
            [cell refreAMRecordsCellWithDataSource:self.dataSource.firstObject];
            [cell.locBut addTarget:self action:@selector(clickLocBut:) forControlEvents:UIControlEventTouchUpInside];
            [cell.missAMBut addTarget:self action:@selector(clickAMMissBut:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (self.isNow == 0 || self.isNow == 2) { // 查询未来时间打卡情况 查询之前时间打卡情况
            cell.isNow = self.isNow;
            [cell refreOneDayFromAMRecordsCellWithDataSource:self.dataSource.firstObject];
            [cell.missAMBut addTarget:self action:@selector(clickAMMissBut:) forControlEvents:UIControlEventTouchUpInside];
            if (self.isNow == 0) {  // 未来日子
                cell.missAMBut.userInteractionEnabled = NO;
            }else {
                cell.missAMBut.userInteractionEnabled = YES;
            }
            return cell;
        }
        return nil;
    }else if (indexPath.row == 2) { //  下午打卡
        PMRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pmRecordsCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.NewRecordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.passCodeDalagate = self;
        if (self.isNow == 1) {
            cell.isOffice = self.isOfficeWorker;    // 传内外勤
            cell.locString = _params;               // 传当前地址
            cell.interval = self.interval;          // 传当前时间戳
            cell.passTimeDelegate = self;
            [cell refrePMRecordsCellWithDataSource:self.dataSource.firstObject];
            [cell.missPMBut addTarget:self action:@selector(clickPMMissBut:) forControlEvents:UIControlEventTouchUpInside];
            [cell.locBut addTarget:self action:@selector(clickLocBut:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (self.isNow == 0 || self.isNow == 2) { // 查询未来时间打卡情况 查询之前时间打卡情况
            cell.isNow = self.isNow;
            [cell.missPMBut addTarget:self action:@selector(clickPMMissBut:) forControlEvents:UIControlEventTouchUpInside];
            [cell refreOneDayFromPMRecordsCellWithDataSource:self.dataSource.firstObject];
            if (self.isNow == 0) {  // 未来日子
                cell.missPMBut.userInteractionEnabled = NO;
            }else {
                cell.missPMBut.userInteractionEnabled = YES;
            }
            return cell;
        }
        return nil;
    }else {
        return nil;
    }
}

/*
 上下班规定时间内打卡(上班8点30之前、下班5点半之后) 不需要显示打卡View
 外勤打卡都需要显示打卡View
 下班早退打卡需要显示打卡View
 打卡成功都需要显示成功View
 */
// 上午 上班打卡
// 传递点击打卡的时间和打卡按钮的tag
- (void)passClickTimeFromAM:(NSString *)time andButTag:(NSInteger)tag
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (tag == 100 || tag == 101) {   // 内勤 100-> 正常  101->迟到   102-> 外勤
        [dic setObject:self.myId forKey:@"crUiid"];
        [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.longitude] forKey:@"crSblongitude"];
        [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.latitude] forKey:@"crSblatitude"];
        [dic setObject:[NSString stringWithFormat:@"%@",_officeAddres] forKey:@"crSbaddress"];
        [dic setObject:@"2" forKey:@"crSbmachinerytype"]; // 设备参数 iOS->2
        [dic setObject:@"1" forKey:@"crSbcardtype"];      // 内勤->1  外勤->2
        [dic setObject:@"0" forKey:@"crSborXb"];            // 0->上班 1->下班
        [self postInformationWithUrl:senderRecordNewsUrl andParameter:dic andIsAMPM:0];
    }else { //外勤 需要显示打卡View
        [self addRecordViewWithTitle:@"外勤打卡备注" andTime:time andAddress:_params andTag:tag];
    }
    // 更新数据
    [self postDataToServces];
    [self.NewRecordTable reloadData];
}

// 上午 申请补卡按钮
- (void)clickAMMissBut:(UIButton *)but
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    // 申请补卡
    [self JumpToApplyRecordsVC];
}

// 下午 下班打卡
- (void)passClickTimeFormPM:(NSString *)time andButTag:(NSInteger)tag
{
    // 需要判断当前时间是否为正常下班时间
    [_formatter setDateFormat:@"HH-mm-ss"];
    NSInteger i = 4;
    if (time) {
        i = [self compareNowTime:time withOtherTime:@"17:30:00" withDateFormatter:_formatter];
    }
    if (i == 0) {
        // 早退  (显示早退打卡View)
        if (tag == 100) {   // 内勤
            [self addRecordViewWithTitle:@"确定要打早退卡吗?" andTime:time andAddress:_params andTag:tag];
        }else {             // 外勤 103
            [self addRecordViewWithTitle:@"外勤打卡备注" andTime:time andAddress:_params andTag:tag];
        }
    }else if (i == 1 || i == 2){
        // 正常下班 内勤
        if (tag == 100) {
            [self normalOffWorkWithTag:tag];
        }else { // 外勤 正常下班
            [self addRecordViewWithTitle:@"外勤打卡备注" andTime:time andAddress:_params andTag:tag];
        }
    }
}

// 正常下班打卡 内勤
- (void)normalOffWorkWithTag:(NSInteger)tag
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.myId forKey:@"crUiid"];
    [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.longitude] forKey:@"crXblongitude"];
    [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.latitude] forKey:@"crXblatitude"];
    [dic setObject:[NSString stringWithFormat:@"%@",_officeAddres] forKey:@"crXbaddress"];
    [dic setObject:@"1" forKey:@"crSborXb"];
    [dic setObject:@"2" forKey:@"crXbmachinerytype"];
    [dic setObject:@"1" forKey:@"crXbcardtype"];
    // 更新打卡参数
    if (self.crId) {
        [dic setObject:self.crId forKey:@"crId"];
    }else {
        [dic setObject:@"" forKey:@"crId"];
    }
    [self postInformationWithUrl:senderRecordNewsUrl andParameter:dic andIsAMPM:1];
    // 更新数据
    [self postDataToServces];
    [self.NewRecordTable reloadData];
}

// 下午更新打卡和申请补卡
- (void)clickPMMissBut:(UIButton *)but
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (but.tag == 300) {
        // 更新打卡
        [self refreshPMRecords];
    }else {
        // 申请补卡
        [self JumpToApplyRecordsVC];
    }
}
// 下午更新打卡
- (void)refreshPMRecords
{
    // 判断当前时间与下班时间前后关系。更新打卡为早退打卡，需要显示早退view
    // 判断当前打卡人是否为内外勤。
    
    NewsRecordModel *model = self.dataSource.firstObject;
    
    [_formatter setDateFormat:@"HH-mm-ss"];
    NSInteger i = 4;
    if (model.nowDate) {
        i = [self compareNowTime:[model.nowDate componentsSeparatedByString:@" "].lastObject withOtherTime:@"17:30:00" withDateFormatter:_formatter];
    }
    if (i == 0) {   // 早退
        if (self.isOfficeWorker) {  // 内勤
            [self addRecordViewWithTitle:@"确定要打早退卡吗?" andTime:[model.nowDate componentsSeparatedByString:@" "].lastObject andAddress:_params andTag:100];
        }else { // 外勤
            [self addRecordViewWithTitle:@"外勤打卡备注" andTime:[model.nowDate componentsSeparatedByString:@" "].lastObject andAddress:_params andTag:103];
        }
    }else if (i == 1 || i == 2) {
        if (self.isOfficeWorker) {
            [self normalOffWorkWithTag:100];
        }else {
            [self addRecordViewWithTitle:@"外勤打卡备注" andTime:[model.nowDate componentsSeparatedByString:@" "].lastObject andAddress:_params andTag:103];
        }
    }
}

#pragma mark --recordViewDelegate--
// 跳转到照相机视图
- (void)passImagePickFromRecordView:(UIImagePickerController *)imagePick
{
    [self presentViewController:imagePick animated:YES completion:^{}];
}
// 获取上传图片信息
- (void)passPostImageNewsFromRecordView:(NSString *)imageNews andSuccess:(BOOL)success
{
    if (success) {
        [self showAlertControllerMessage:@"上传成功" andTitle:@"提示" andIsPre:NO];
        self.imageNews = imageNews;
    }else {
        [self showAlertControllerMessage:@"上传失败，稍后再试" andTitle:@"提示" andIsPre:NO];
    }
}
- (void)passNotesFromRecordView:(NSString *)notes
{
    self.remark = notes;
}

// 进入地图 定位
- (void)clickLocBut:(UIButton *)sender
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //  移动考勤
    RecordsViewController *rvc = [sb instantiateViewControllerWithIdentifier:@"RecordsVC"];
    rvc.data = self.dataSource;
    rvc.crid = self.crId;
    rvc.title = @"移动考勤";
    [self.navigationController pushViewController:rvc animated:YES];
}

#pragma mark --打卡--
- (void)postInformationWithUrl:(NSString *)url andParameter:(NSMutableDictionary *)parameter andIsAMPM:(NSInteger)am
{
    [parameter setObject:[GSKeyChainDataManager readUUID] forKey:@"crTokenId"];
    // 判断打卡时 有无定位信息
    if (_loc == nil && _address == nil) {
        [self showAlertControllerMessage:@"无法获取当前定位信息,请移至信号较好的地方" andTitle:@"提示" andIsPre:NO];
    }else {
        [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [self.manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                
                self.successView.hidden = NO;
                self.backView.hidden = NO;
                self.crId = responseObject[@"crId"];
                if (am == 0) {
                    self.successView.am = @"上班";
                }else {
                    self.successView.am = @"下班";
                }
                self.successView.time = responseObject[@"cardTime"];
                [self.successView refreshSuccessTime:responseObject[@"cardTime"]];
                [self.successView.confirmBut addTarget:self action:@selector(clickConfirmBut:) forControlEvents:UIControlEventTouchUpInside];
                [self.backView addSubview:self.successView];
                [self.view addSubview:self.backView];
            }else {
                [self showAlertControllerMessage:responseObject[@"msg"] andTitle:@"确定" andIsPre:NO];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error) {
                NSLog(@"%@",error);
                [self showAlertControllerMessage:@"网络连接失败" andTitle:@"确定" andIsPre:NO];
            }
        }];
    }
}

// 打卡成功显示view，按钮
// 更新数据。重新请求数据，定时器会重启。
- (void)clickConfirmBut:(UIButton *)but
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.successView.hidden = YES;
    self.backView.hidden = YES;
    // 重新获取考勤信息
    [self postDataToServces];
}

#pragma mark --passStatusCodeFromAM--
- (void)passStatusCodeFormAM:(NSInteger)code
{
    if (code==1) {
        _height = 280;
    }else {
        _height = 150;
    }
}

#pragma mark --passStatusCodeFromPM--
- (void)passStatusCodeFormPM:(NSInteger)code
{
    if (code==1) {
        _height = 280;
    }else {
        _height = 150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }else if (indexPath.row == 1) {
        return _height;
    }else if (indexPath.row == 2) {
        return _height;
    }else {
        return 0;
    }
}

#pragma mark --recordNewsCellDelegate--
- (void)passPickBackView:(UIView *)view andPickView:(UIPickerView *)pick
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.view addSubview:view];
    [self.view addSubview:pick];
}
// 查询某日打卡详情
- (void)passDateFromRecordNewsCell:(NSString *)date
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.dateTime = date;
    [self loadInformationWithUrl:inquiryRecordNewsUrl andParameters:[NSMutableDictionary dictionaryWithDictionary:@{@"crUiid":self.myId,@"crSbcardtime":self.dateTime}]];
    [self.NewRecordTable reloadData];
}

// 加入打卡View 只有外勤打卡显示的view
- (void)addRecordViewWithTitle:(NSString *)title andTime:(NSString *)time andAddress:(NSString *)address andTag:(NSInteger)tag
{
    self.recordView.hidden = NO;
    self.backView.hidden = NO;
    self.recordView.timeLabel.text = time;
    self.recordView.titleLabel.text = title;
    self.recordView.addressLabel.text = address;
    // 取消按钮
    [self.recordView.cancelBut addTarget:self action:@selector(clickCancelBut:) forControlEvents:UIControlEventTouchUpInside];
    // 提交按钮
    self.recordView.sureBut.tag = tag;
    [self.recordView.sureBut addTarget:self action:@selector(clickSureBut:) forControlEvents:UIControlEventTouchUpInside];
    self.recordView.passNoteDelegate = self;
    self.recordView.passImagePickdelegate = self;
    self.recordView.passImageNewsDelegate = self;
    [self.backView addSubview:self.recordView];
    [self.view addSubview:self.backView];
}

// 隐藏打卡View
- (void)clickCancelBut:(UIButton *)but
{
    self.recordView.hidden = YES;
    self.backView.hidden = YES;
}
// 确定按钮
- (void)clickSureBut:(UIButton *)but
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.myId forKey:@"crUiid"];
    if (but.tag == 102) {   // 上午外勤打卡
        [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.longitude] forKey:@"crSblongitude"];
        [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.latitude] forKey:@"crSblatitude"];
        [dic setObject:[NSString stringWithFormat:@"%@%@",_address,_params] forKey:@"crSbaddress"];
        [dic setObject:@"2" forKey:@"crSbmachinerytype"];
        [dic setObject:@"2" forKey:@"crSbcardtype"];
        [dic setObject:@"0" forKey:@"crSborXb"];
        if (self.imageNews) {
            [dic setObject:self.imageNews forKey:@"crSbimg"];
        }else {
            [dic setObject:@"" forKey:@"crSbimg"];
        }
        if (self.remark) {
            [dic setObject:self.remark forKey:@"crSbremark"];
        }else {
            [dic setObject:@"" forKey:@"crSbremark"];
        }
    }else {     // 下午内勤早退打卡(下午内勤更新打卡) -> 100  下午外勤(早退/正常)打卡(下午外勤更新打卡)
        [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.longitude] forKey:@"crXblongitude"];
        [dic setObject:[NSString stringWithFormat:@"%f",_loc.coordinate.latitude] forKey:@"crXblatitude"];
        [dic setObject:@"2" forKey:@"crXbmachinerytype"];
        if (self.imageNews) {
            [dic setObject:self.imageNews forKey:@"crXbimg"];
        }else {
            [dic setObject:@"" forKey:@"crXbimg"];
        }
        if (self.remark) {
            [dic setObject:self.remark forKey:@"crXbremark"];
        }else {
            [dic setObject:@"" forKey:@"crXbremark"];
        }
        [dic setObject:@"1" forKey:@"crSborXb"];
        if (but.tag == 100) { // 内勤
            [dic setObject:[NSString stringWithFormat:@"%@",_officeAddres] forKey:@"crXbaddress"];
            [dic setObject:@"1" forKey:@"crXbcardtype"];
        }else {     // 外勤
            [dic setObject:[NSString stringWithFormat:@"%@%@",_address,_params] forKey:@"crXbaddress"];
            [dic setObject:@"2" forKey:@"crXbcardtype"];
        }
        // 更新打卡参数
        if (self.crId) {
            [dic setObject:self.crId forKey:@"crId"];
        }else {
            [dic setObject:@"" forKey:@"crId"];
        }
    }
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    // 提交打卡参数
    if (but.tag == 102) {   // 上午
        [self postInformationWithUrl:senderRecordNewsUrl andParameter:dic andIsAMPM:0];
    }else {     // 下午
        [self postInformationWithUrl:senderRecordNewsUrl andParameter:dic andIsAMPM:1];
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

// 计算cell显示的时间
- (void)showCellTimeWithData:(NSMutableArray *)data
{
    NewsRecordModel *model = data.firstObject;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreCellTimer:) userInfo:model repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
// 将计算好的时间装进model 修改数据源。刷新
- (void)refreCellTimer:(NSTimer *)timer
{
//    NSLog(@"111");
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];//零区时间
    // 转化服务器时间
    NSDate *sevcers = [_formatter dateFromString:[timer.userInfo nowDate]];
    NSTimeInterval sevcersInterval = [sevcers timeIntervalSince1970];
    // 获取时间差 (显示时间和过去一秒钟的时间)    将前一秒钟的时间传进去
    [RCDateTimeUtils updateServerTime:self.interval];
    // 当前时间传入
    NSDate *nowDate = [RCDateTimeUtils currentTime:sevcersInterval];
    NSString *time = [[_formatter stringFromDate:nowDate] componentsSeparatedByString:@" "].lastObject;
    NSMutableDictionary *timeDic = [NSMutableDictionary dictionary];
    [timeDic setObject:time forKey:@"time"];
    NewsRecordModel *model = timer.userInfo;
    model.timeD = timeDic;
    model.timeS = time;

    [_formatter setDateFormat:@"HH-mm-ss"];
    NSString *settingTime = @"08:30:00";
    NSInteger i = [self compareNowTime:time withOtherTime:settingTime withDateFormatter:_formatter];
    if (i == 2) {   // 迟到
        self.isLate = false;
    }else {
        self.isLate = true;
    }
    model.isLate = self.isLate;
    
    [self.dataSource removeAllObjects];
    [self.dataSource addObject:model];
    [self.NewRecordTable reloadData];
}

// 查询日期与当前日期做判断
- (NSInteger )compareNowTime:(NSString *)nowTime withOtherTime:(NSString *)otherTime withDateFormatter:(NSDateFormatter *)formatter
{
    NSDate *dateA = [formatter dateFromString:nowTime];
    NSDate *dateB = [formatter dateFromString:otherTime];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedAscending) { //  说明otherTime是未来时间
        return 0;
    }else if (result == NSOrderedSame) {    // 两者时间是同一个时间   说明是当天
        return 1;
    }else if (result == NSOrderedDescending) {  // 说明otherTime是过去时间
        return 2;
    }else {
        return 3;
    }
}

#pragma mark --跳转到申请补卡页面--
- (void)JumpToApplyRecordsVC
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ApplyRecordsViewController *arVC = [sb instantiateViewControllerWithIdentifier:@"applyRecordsVC"];
    arVC.time = self.dateTime;
    [self.navigationController pushViewController:arVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
