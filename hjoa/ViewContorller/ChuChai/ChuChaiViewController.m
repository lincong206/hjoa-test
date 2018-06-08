//
//  ChuChaiViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/10/24.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  出差

#import "ChuChaiViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "SubmitView.h"

#import "LeaveStartTimeCell.h"
#import "LeaveDaysCell.h"
#import "LeaveReasonCell.h"
#import "LeavePhotoCell.h"
#import "LeaveForApproveCell.h"
#import "PhotosCell.h"
#import "ApproveEnclosureModel.h"

#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"

@interface ChuChaiViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, passDatePickViewFromStartCell, passLeaveTimeFromDateCell, passLeaveEndTimeFromDateCell, UITextFieldDelegate, passReason, passPickViewFormLeaveForApproveCell, passHeightFromLeaveCell, passApproveIdFromLeaveCell, passStepDataFormLeaveCell, passSelectPhotos>

{
    NSString *_startTime;
    NSString *_endTime;
    NSString *_ccDays;
    NSString *_ccAddress;
    NSString *_ccNots;
    NSString *_apId;
    NSMutableArray *_step;
    CGFloat _approveCellHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *ccTab;
@property (strong, nonatomic) UIImagePickerController *imagePick;
@property (strong, nonatomic) NSMutableArray *photoArr;

@property (strong, nonatomic) NSMutableArray *ccPhotos;     // 上传附件

@property (assign, nonatomic) CGFloat approveCellHeight;

@property (strong, nonatomic) NSString *pcId;               // 成功申请返回的数据



@end

@implementation ChuChaiViewController

- (UIImagePickerController *)imagePick
{
    if (!_imagePick) {
        _imagePick = [UIImagePickerController new];
        _imagePick.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePick.allowsEditing = YES;
    }
    return _imagePick;
}

- (NSMutableArray *)ccPhotos
{
    if (!_ccPhotos) {
        _ccPhotos = [NSMutableArray array];
    }
    return _ccPhotos;
}

- (NSMutableArray *)photoArr
{
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;

    SubmitView *submiView = [[SubmitView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 60, kscreenWidth, 60)];
    [submiView.but addTarget:self action:@selector(clickSubmitBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submiView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 提交
/*
 10.1.30.68/oaDocEvectionApprove/saveAndSubmit?deaIdtype=CCSP&deaDocname=出公差审批流程&deaCreatetime=2017-10-24 10:29:27&uiName=超级管理员&uiId=1&deaInitiatordept=IT部&deaEvectionpeople=超级管理员&deaDept=IT部&deaBegintime=2017-10-21 09:30:00&deaEndtime=2017-10-24 09:30:00&deaDay=4&deaAddress=广东深圳&deaReason=忙啊
 */
- (void)clickSubmitBut:(UIButton *)sender
{
    //  上传数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //  类型
    [params setObject:@"CCSP" forKey:@"deaIdtype"];
    //  公文名称
    [params setObject:@"出公差审批流程" forKey:@"deaDocname"];
    //  日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    [params setObject:dateTime forKey:@"deaCreatetime"];
    //  用户姓名
    [params setValue:[user objectForKey:@"uiId"] forKey:@"uiId"];
    //  用户姓名
    [params setValue:[user objectForKey:@"uiName"] forKey:@"uiName"];
    //  部门名字
    [params setObject:[user objectForKey:@"uiPsname"] forKey:@"deaInitiatordept"];
    //  请假人
    [params setValue:[user objectForKey:@"uiName"] forKey:@"deaEvectionpeople"];
    //  部门
    [params setObject:[user objectForKey:@"uiPsname"] forKey:@"deaDept"];
    //  出差开始时间
    if (_startTime) {
        [params setObject:[_startTime componentsSeparatedByString:@" "].firstObject forKey:@"deaBegintime"];
    }else {
        [params setObject:@"" forKey:@"deaBegintime"];
    }
    //  出差结束时间
    if (_endTime) {
        [params setObject:[_endTime componentsSeparatedByString:@" "].firstObject forKey:@"deaEndtime"];
    }else {
        [params setObject:@"" forKey:@"deaEndtime"];
    }
    //  出差天数
    if (_ccDays) {
        [params setObject:_ccDays forKey:@"deaDay"];
    }else {
        [params setObject:@"" forKey:@"deaDay"];
    }
    //  出差地址
    if (_ccAddress) {
        [params setObject:_ccAddress forKey:@"deaAddress"];
    }else {
        [params setObject:@"" forKey:@"deaAddress"];
    }
    //  出差事由
    if (_ccNots) {
        [params setObject:_ccNots forKey:@"deaReason"];
    }else {
        [params setObject:@"" forKey:@"deaReason"];
    }
    
    //  params 参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //  status 第一个
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    if (_apId) {   // 审批流id
        [dic1 setObject:_apId forKey:@"apId"];
    }else {
        [dic1 setObject:@"" forKey:@"apId"];
    }
    [dic1 setObject:@"" forKey:@"piId"];
    [dic1 setObject:@"CCSP" forKey:@"piType"];
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"出公差审批审批;编号及名称:CCSP%@null,出公差审批",nameStr];
    [dic1 setObject:nameStr forKey:@"astDocName"];
    [dic1 setObject:[user objectForKey:@"uiId"] forKey:@"uiId"];
    [dic1 setObject:@"" forKey:@"piMoney"];
    [dic setObject:dic1 forKey:@"status"];
    
    //  stepReceives 第二个参数 审批流
    if (_step.count > 0) {
        [dic setObject:_step forKey:@"stepReceives"];
    }else {
        [dic setObject:@"" forKey:@"stepReceives"];
    }
    
    //  files 第三个参数 上传图片
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    NSString *fileString = @"";
    // 有数据
    if (self.ccPhotos.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.ccPhotos) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:@"CCSP" forKey:@"piType"];
            [photos setObject:[user objectForKey:@"uiId"] forKey:@"uiId"];
            [photos setObject:model.baiSubsequent forKey:@"baiSubsequent"];
            [photos setObject:model.baiUrl forKey:@"baiUrl"];
            fileString = [NSString stringWithFormat:@"%@%@!",fileString,photos];
            
            fileString = [fileString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
            fileString = [fileString stringByReplacingOccurrencesOfString:@";" withString:@","];
            NSString *lastString = [fileString substringToIndex:fileString.length-4];
            fileString = [NSString stringWithFormat:@"%@}!",lastString];
        }
    }
    [dic2 setObject:fileString forKey:@"file"];
    [dic setObject:dic2 forKey:@"files"];
    
    // curr 第四个参数
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"" forKey:@"con"];
    [dic setObject:dic3 forKey:@"curr"];
    
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:paramsStr forKey:@"params"];
    
    if (_startTime == nil || [_startTime isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写出差开始时间" andTitle:@"提示" andIsReturn:NO];
    }else if (_endTime == nil || [_endTime isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写出差结束时间" andTitle:@"提示" andIsReturn:NO];
    }else if (_ccDays == nil || [_ccDays isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请输入出差天数" andTitle:@"提示" andIsReturn:NO];
    }else if (_ccAddress == nil || [_ccAddress isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请输入出差地址" andTitle:@"提示" andIsReturn:NO];
    }else if (_ccNots == nil || [_ccNots isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请输入出差事由" andTitle:@"提示" andIsReturn:NO];
    }else if (_step.count == 0) {
        [self showAlertControllerMessage:@"请选择审批流程" andTitle:@"提示" andIsReturn:NO];
    }else {
        
        [manager POST:ccUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                //  成功上传
                self.pcId = responseObject[@"id"];
                [self showAlertControllerMessage:@"申请成功" andTitle:@"提示" andIsReturn:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertControllerMessage:@"网络不给力" andTitle:@"提示" andIsReturn:NO];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.ccTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self tableviewRegisterCell];
    
    
    self.imagePick.delegate = self;
}

- (void)tableviewRegisterCell
{
    [self.ccTab registerNib:[UINib nibWithNibName:@"LeaveStartTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lstartCell"];
    [self.ccTab registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.ccTab registerNib:[UINib nibWithNibName:@"LeaveReasonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lreasonCell"];
    [self.ccTab registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.ccTab registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.ccTab registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
}

#pragma mark ---LeaveTableviewDelegate---
//  多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}
//  段高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 6 && self.photoArr.count) {
        return 0.01;
    }else {
        return 10;
    }
}
//  每一段有多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.photoArr.count) {
        if (section == 6) {
            return 1;
        }else {
            return 1;
        }
    }else {
        return 1;
    }
}
//  cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LeaveStartTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lstartCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"开始时间";
        cell.startCellDelegate = self;
        cell.passTimeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 1) {
        LeaveStartTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lstartCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"结束时间";
        cell.startCellDelegate = self;
        cell.passEndTimeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 2) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleName.text = @"出差天数";
        cell.days.placeholder = @"请输入出差天数(必填)";
        cell.days.delegate = self;
        return cell;
        
    }else if (indexPath.section == 3) {
        LeaveReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lreasonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.reasonTitle.text = @"出差地点";
        cell.passReasonDelegate = self;
        if (_ccAddress) {
            cell.reasonText.text = _ccAddress;
        }
        return cell;
        
    }else if (indexPath.section == 4) {
        LeaveReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lreasonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.reasonTitle.text = @"出差事由";
        cell.passReasonDelegate = self;
        if (_ccNots) {
            cell.reasonText.text = _ccNots;
        }
        return cell;
        
    }else if (indexPath.section == 5) {
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"附件";
        cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
        return cell;
        
    }else if (indexPath.section == 6) {
        PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.ccTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.photoArr.count) {
            [cell loadPhotosData:self.photoArr];
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 7) {
        LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = @"CCSP";
        cell.leaveDelegate = self;
        cell.passHeightDelegate = self;
        cell.passApIdDelegate = self;
        cell.passStepDataDelegate = self;
        return cell;
        
    }else {
        return nil;
    }
}

#pragma mark --passHeightFromLeaveCell--
- (void)passHeightFromLeaveCell:(CGFloat)height
{
    _approveCellHeight = height;
    [self.ccTab reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 6) {
        if (self.photoArr.count) {
                return 100;
            }else {
                return 0;
            }
    }else if (indexPath.section == 4 || indexPath.section == 3) {
        return 100;
    }else if (indexPath.section == 7) {
        return _approveCellHeight + 80;
    }else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        [self creatAlertController];
    }
}
//  通过警告控制器选择  附件从相册选出还是相机相机选出
- (void)creatAlertController
{
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置拍照警告响应事件
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置照片来源为相机
        self.imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        self.imagePick.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 展示选取照片控制器
        [self presentViewController:self.imagePick animated:YES completion:^{}];
    }];
    // 设置相册警告响应事件
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getOriginalImages];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 添加警告按钮
        [alert addAction:cameraAction];
    }
    [alert addAction:photosAction];
    [alert addAction:cancelAction];
    // 展示警告控制器
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    UIImage *img = editingInfo[UIImagePickerControllerOriginalImage];
    [self.photoArr addObject:img];
    // 上传图片
    [self upLoadImageWith:img];
    [self.ccTab reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  获得所有相簿的原图
 */
- (void)getOriginalImages
{
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll];
}
/**
 *  遍历相簿中的所有图片
 *
 *  @param assetCollection 相簿
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    PhotosViewController *photosVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"attachmentsVC"];
    photosVC.title = assetCollection.localizedTitle;
    photosVC.passDelegate = self;
    
    for (PHAsset *asset in assets) {
        @autoreleasepool {
            // 从asset中获得图片
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                if (imageData) {
                    PhotosModel *model = [[PhotosModel alloc] init];
                    model.select = NO;
                    model.photosData = imageData;
                    [photosVC.data addObject:model];
                }
            }];
        }
    }
    [self.navigationController pushViewController:photosVC animated:YES];
}
#pragma mark --选择图片passDelegate--
- (void)passSelectPhotosFromPhotosVC:(NSMutableArray *)selectArr
{
    self.photoArr = selectArr;
    for (UIImage *image in selectArr) {
        [self upLoadImageWith:image];
    }
    [self.ccTab reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationAutomatic];
}

// 上传图片
- (void)upLoadImageWith:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    if (data) {
        NSString *url = [NSString stringWithFormat:@"%@/uploadFile/saveFile?num=1",intranetURL];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *imageDate = [formatter stringFromDate:[NSDate date]];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"files" fileName:[NSString stringWithFormat:@"%@.jpg",imageDate] mimeType:@"image/jpg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            for (NSDictionary *dic in responseObject[@"rows"]) {
                ApproveEnclosureModel *model = [[ApproveEnclosureModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.ccPhotos addObject:model];
            }
            if ([responseObject[@"status"] isEqualToString:@"yes"]) {
                [self showAlertControllerMessage:@"上传成功" andTitle:@"提示" andIsReturn:NO];
            }else {
                [self showAlertControllerMessage:@"上传失败,网络错误" andTitle:@"提示" andIsReturn:NO];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertControllerMessage:@"上传失败" andTitle:@"提示" andIsReturn:NO];
        }];
    }else {
        [self showAlertControllerMessage:@"上传失败" andTitle:@"提示" andIsReturn:NO];
    }
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --startTimeCellDelegate--
- (void)passDatePickViewFromStartCell:(UIView *)sender
{
    [self.view addSubview:sender];
}
- (void)passLeaveTime:(NSString *)time
{
    _startTime = time;
}
- (void)passLeaveEndTime:(NSString *)time
{
    _endTime = time;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _ccDays = textField.text;
}

#pragma mark --passReasonDelegate--
- (void)passReason:(NSString *)reason
{
    _ccAddress = reason;
    _ccNots = reason;
}

#pragma mark --passPickViewFormLeaveForApproveCell--
- (void)passPickViewFormLeaveForApproveCell:(UIView *)view
{
    [self.view addSubview:view];
}
- (void)passApproveIdFromLeaveCell:(NSString *)apId
{
    _apId = apId;
}
- (void)passStepDataFormLeaveCellWithStepData:(NSMutableArray *)step
{
    _step = step;
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
