//
//  ApplyRecordsViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/10/16.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  申请补卡

#import "ApplyRecordsViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "LeaveTypeCell.h"
#import "LeaveDaysCell.h"
#import "LeaveReasonCell.h"
#import "LeavePhotoCell.h"
#import "PhotosCell.h"
#import "LeaveForApproveCell.h"
#import "ApproveEnclosureModel.h"

#import "SubmitView.h"
#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"

@interface ApplyRecordsViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, passPickViewFromTypeCell, passTypeLabelFromTypeCell, passReason, passPickViewFormLeaveForApproveCell, passApproveIdFromLeaveCell, passStepDataFormLeaveCell, passHeightFromLeaveCell, passSelectPhotos>

{
    CGFloat _approveCellHeight;
}
@property (weak, nonatomic) IBOutlet UITableView *applyRecordTab;

@property (strong, nonatomic) NSMutableArray *stepPhotoArr;     // 图片数据源
// 附件
@property (strong, nonatomic) UIImagePickerController *imagePick;
@property (strong, nonatomic) NSMutableArray *photoArr;

// 参数
@property (strong, nonatomic) NSString *AMPM;           // 时间 上午or下午
@property (strong, nonatomic) NSString *cardReason;         // 缺卡原因
@property (strong, nonatomic) NSString *approveId;      // 审批流id
@property (strong, nonatomic) NSMutableArray *step;     // 审批流程人物

@end

@implementation ApplyRecordsViewController

- (UIImagePickerController *)imagePick
{
    if (!_imagePick) {
        _imagePick = [UIImagePickerController new];
        _imagePick.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePick.allowsEditing = YES;
    }
    return _imagePick;
}

- (NSMutableArray *)photoArr
{
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (NSMutableArray *)stepPhotoArr
{
    if (!_stepPhotoArr) {
        _stepPhotoArr = [NSMutableArray array];
    }
    return _stepPhotoArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"申请补卡";
    
    SubmitView *submiView = [[SubmitView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 60, kscreenWidth, 60)];
    [submiView.but addTarget:self action:@selector(clickSubmitBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submiView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)clickSubmitBut:(UIButton *)but
{
    //   上传数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    // 用户姓名
    [params setValue:[user objectForKey:@"uiId"] forKey:@"caUiid"];
    // 补卡节点
    if (self.AMPM) {
        [params setObject:self.AMPM forKey:@"caSborxb"];
    }else {
        [params setObject:@"" forKey:@"caSborxb"];
    }
    
    // 补卡时间
    [params setObject:self.time forKey:@"caReplenishtime"];
    // 缺卡原因
    if (self.cardReason) {
        [params setObject:self.cardReason forKey:@"caReason"];
    }else {
        [params setObject:@"" forKey:@"caReason"];
    }
    
    //  params 参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //  status 第一个
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    if (self.approveId) {   // 审批流id
        [dic1 setObject:self.approveId forKey:@"apId"];
    }else {
        [dic1 setObject:@"" forKey:@"apId"];
    }
    [dic1 setObject:@"" forKey:@"piId"];
    [dic1 setObject:@"DKBKSQ" forKey:@"piType"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"补卡申请流程审批;编号及名称:DKBKSQ%@null,补卡申请流程",nameStr];
    [dic1 setObject:nameStr forKey:@"astDocName"];
    [dic1 setObject:[user objectForKey:@"uiId"] forKey:@"uiId"];
    [dic1 setObject:@"" forKey:@"piMoney"];
    [dic setObject:dic1 forKey:@"status"];
    
    //  stepReceives 第二个参数 审批流
    if (self.step.count > 0) {
        [dic setObject:self.step forKey:@"stepReceives"];
    }else {
        [dic setObject:@"" forKey:@"stepReceives"];
    }
    
    //  files 第三个参数 上传图片
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    NSString *fileString = @"";
    // 有数据
    if (self.photoArr.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.stepPhotoArr) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:@"DKBKSQ" forKey:@"piType"];
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
    
    [dic3 setObject:fileString forKey:@"file"];
    [dic setObject:dic3 forKey:@"files"];
    
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:paramsStr forKey:@"params"];
    
    // 必填数据
    if ([self.AMPM isEqualToString:@""] || self.AMPM == nil) {
        [self showAlertControllerMessage:@"请选择补卡节点" andTitle:@"提示" andIsReturn:NO];
    }else if ([self.cardReason isEqualToString:@""] || self.cardReason == nil) {
        [self showAlertControllerMessage:@"请填写请假原因" andTitle:@"提示" andIsReturn:NO];
    }else if (self.step.count == 0) {
        [self showAlertControllerMessage:@"请选择审批流程" andTitle:@"提示" andIsReturn:NO];
    }else {
        [manager POST:applyRecordUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                //  成功上传
//                self.pcId = responseObject[@"pcId"];
                [self showAlertControllerMessage:@"申请成功" andTitle:@"提示" andIsReturn:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertControllerMessage:@"网络不给力" andTitle:@"提示" andIsReturn:NO];
        }];
    }
    
}

#pragma mark--passStepDataFormLeaveCell--
- (void)passStepDataFormLeaveCellWithStepData:(NSMutableArray *)step
{
    self.step = step;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imagePick.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self tableviewRegisterCell];
}

- (void)tableviewRegisterCell
{
    [self.applyRecordTab registerNib:[UINib nibWithNibName:@"LeaveTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ltypeCell"];
    [self.applyRecordTab registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.applyRecordTab registerNib:[UINib nibWithNibName:@"LeaveReasonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lreasonCell"];
    
    [self.applyRecordTab registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.applyRecordTab registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.applyRecordTab registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

//  段高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 4 && self.photoArr.count) {
        return 0.01;
    }else {
        return 10;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"==请选择==",@"上午",@"下午"];
        cell.typeName.text = @"补卡节点";
        cell.pickData = [NSArray arrayWithArray:arr];
        cell.typeCellDelegate = self;
        cell.passTypeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 1) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleName.text = @"补卡时间";
        cell.days.text = self.time;
        cell.days.enabled = false;
        return cell;
        
    }else if (indexPath.section == 2) {
        LeaveReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lreasonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.reasonTitle.text = @"缺卡原因";
        cell.reasonText.text = @"请输入缺卡原因(必填)";
        cell.passReasonDelegate = self;
        if (self.cardReason) {
            cell.reasonText.text = self.cardReason;
        }
        return cell;
        
    }else if (indexPath.section == 3) {
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"附件";
        cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
        return cell;
        
    }else if (indexPath.section == 4) {
        PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.applyRecordTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.photoArr.count) {
            [cell loadPhotosData:self.photoArr];
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 5) {
        LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = @"DKBKSQ";
        cell.leaveDelegate = self;
        cell.passApIdDelegate = self;
        cell.passHeightDelegate = self;
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
    [self.applyRecordTab reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.photoArr.count) {
        if (indexPath.section == 2 || indexPath.section == 4) {
            return 100;
        }else if (indexPath.section == 5) {
            return _approveCellHeight + 90 + 20;
        }else {
            return 50;
        }
    }else {
        if (indexPath.section == 4) {
            return 0;
        }else if (indexPath.section == 2) {
            return 100;
        }else if (indexPath.section == 5) {
            return _approveCellHeight + 90 + 20;
        }else {
            return 50;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        [self creatAlertController];
    }
}

#pragma mark --附件--
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
    // 上传图片
    [self upLoadImageWith:img];
    [self.photoArr addObject:img];
    [self.applyRecordTab reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self.applyRecordTab reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
    for (UIImage *image in selectArr) {
        [self upLoadImageWith:image];
    }
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
                [self.stepPhotoArr addObject:model];
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

#pragma mark --typeCellDelegate--
- (void)passPickBackView:(UIView *)sender andPick:(UIPickerView *)pick
{
    [self.view addSubview:sender];
    [self.view addSubview:pick];
}
#pragma mark --passTypeLabelFromTypeCell--
- (void)passTypeLabelFromTypeCell:(NSString *)type
{
    if ([type isEqualToString:@"上午"]) {
        self.AMPM = @"0";
    }else {
        self.AMPM = @"1";
    }
}

#pragma mark --LeaveReasonCell--
- (void)passReason:(NSString *)reason
{
    self.cardReason = reason;
}

#pragma mark --LeaveForApproveCell--
- (void)passPickViewFormLeaveForApproveCell:(UIView *)view
{
    [self.view addSubview:view];
}
- (void)passApproveIdFromLeaveCell:(NSString *)apId
{
    self.approveId = apId;
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
