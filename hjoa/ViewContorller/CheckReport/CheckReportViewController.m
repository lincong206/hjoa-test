//
//  CheckReportViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/12/5.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  检查报告

#import "CheckReportViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "SubmitView.h"
#import "LeaveDaysCell.h"
#import "LeaveStartTimeCell.h"
#import "ChooseProjectCell.h"
#import "SpecialPJTViewController.h"
#import "LeaveReasonCell.h"
#import "LeavePhotoCell.h"
#import "PhotosCell.h"
#import "LeaveForApproveCell.h"

#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"
#import "ApproveEnclosureModel.h"

@interface CheckReportViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, passLeaveTimeFromDateCell, passDatePickViewFromStartCell, passProjectDataFromSpecialPJTVC, passReason, passPickViewFormLeaveForApproveCell, passHeightFromLeaveCell, passStepDataFormLeaveCell, passApproveIdFromLeaveCell, UIImagePickerControllerDelegate,UINavigationControllerDelegate, passSelectPhotos>
{
    NSString *_checkTime;
    NSString *_leaveNots;
    CGFloat _apCellHeight;
    NSMutableArray *_step;
    NSString *_apId;
    NSString *_name;
    BOOL _isFieldPhoto; // 是否为现场照片
}
@property (strong, nonatomic) UITableView *checkTable;
@property (strong, nonatomic) UIImagePickerController *imagePick;
@property (strong, nonatomic) NSString *checkPName;     // 项目名
@property (strong, nonatomic) NSString *checkId;
@property (strong, nonatomic) NSMutableArray *photoArr; // 附件图像
@property (strong, nonatomic) NSMutableArray *nowPhotoArr; // 现场图像
@property (strong, nonatomic) NSMutableArray *postArr; // 附件上传照片
@property (strong, nonatomic) NSMutableArray *postNowArr;   // 现场上传图片
@property (strong, nonatomic) NSString *pcId;

@end

@implementation CheckReportViewController

- (UIImagePickerController *)imagePick
{
    if (!_imagePick) {
        _imagePick = [UIImagePickerController new];
        _imagePick.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePick.allowsEditing = YES;
    }
    return _imagePick;
}

- (NSMutableArray *)postNowArr
{
    if (!_postNowArr) {
        _postNowArr = [NSMutableArray array];
    }
    return _postNowArr;
}

- (NSMutableArray *)postArr
{
    if (!_postArr) {
        _postArr = [NSMutableArray array];
    }
    return _postArr;
}

- (NSMutableArray *)nowPhotoArr
{
    if (!_nowPhotoArr) {
        _nowPhotoArr = [NSMutableArray array];
    }
    return _nowPhotoArr;
}

- (NSMutableArray *)photoArr
{
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (UITableView *)checkTable
{
    if (!_checkTable) {
        _checkTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-60) style:UITableViewStylePlain];
        _checkTable.delegate = self;
        _checkTable.dataSource = self;
        _checkTable.estimatedRowHeight = 0;
        _checkTable.estimatedSectionHeaderHeight = 0;
        _checkTable.estimatedSectionFooterHeight = 0;
        _checkTable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _checkTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _checkTable;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBut)];
    SubmitView *submiView = [[SubmitView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 60, kscreenWidth, 60)];
    [submiView.but addTarget:self action:@selector(clickSubmitBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submiView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 点击提交
- (void)clickSubmitBut:(UIButton *)but
{
    //  上传数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //  用户姓名
    [params setValue:[user objectForKey:@"uiId"] forKey:@"uiId"];
    //  用户姓名
    [params setValue:[user objectForKey:@"uiName"] forKey:@"uiName"];
    //  项目id
    if (self.checkId) {
        [params setObject:self.checkId forKey:@"piId"];
    }else {
        [params setObject:@"" forKey:@"piId"];
    }
    //  项目名称
    if (self.checkPName) {
        [params setObject:self.checkPName forKey:@"piName"];
    }else {
        [params setObject:@"" forKey:@"piName"];
    }
    //  录入人
    if (_name) {
        [params setObject:_name forKey:@"birEntryperson"];
    }else {
        [params setObject:[user objectForKey:@"uiName"] forKey:@"birEntryperson"];
    }
    //  时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    [params setObject:dateTime forKey:@"birTime"];
    //  报告内容
    if (_leaveNots) {
        [params setObject:_leaveNots forKey:@"birContent"];
    }else {
        [params setObject:@"" forKey:@"birContent"];
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
    [dic1 setObject:@"JCBG" forKey:@"piType"];
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"检查报告审批审批;编号及名称:JCBG%@null,检查报告审批",nameStr];
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
    NSString *fileString = @""; // 附件
    NSString *nowString = @"";  // 现场图片
    // 附件有数据
    if (self.postArr.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.postArr) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:@"JCBG" forKey:@"piType"];
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
    // 现场照片有数据
    if (self.postNowArr.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.postNowArr) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:@"JCBGT" forKey:@"piType"];
            [photos setObject:[user objectForKey:@"uiId"] forKey:@"uiId"];
            [photos setObject:model.baiSubsequent forKey:@"baiSubsequent"];
            [photos setObject:model.baiUrl forKey:@"baiUrl"];
            nowString = [NSString stringWithFormat:@"%@%@!",nowString,photos];
            
            nowString = [nowString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
            nowString = [nowString stringByReplacingOccurrencesOfString:@";" withString:@","];
            NSString *lastString = [nowString substringToIndex:nowString.length-4];
            nowString = [NSString stringWithFormat:@"%@}!",lastString];
        }
    }
    NSString *file = [NSString stringWithFormat:@"%@%@",fileString,nowString];
    [dic2 setObject:file forKey:@"file"];
    [dic setObject:dic2 forKey:@"files"];
    
    // curr 第四个参数
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"" forKey:@"con"];
    [dic setObject:dic3 forKey:@"curr"];
    
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:paramsStr forKey:@"params"];
    
    if (_checkTime == nil || [_checkTime isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写检查时间" andTitle:@"提示" andIsReturn:NO];
    }else if (self.checkPName == nil || [self.checkPName isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请选择项目" andTitle:@"提示" andIsReturn:NO];
    }else if (_leaveNots == nil || [_leaveNots isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请输入报告内容" andTitle:@"提示" andIsReturn:NO];
    }else if (self.postNowArr.count == 0) {
        [self showAlertControllerMessage:@"请拍摄现场图片，至少一张" andTitle:@"提示" andIsReturn:NO];
    }else if (_step.count == 0) {
        [self showAlertControllerMessage:@"请选择审批流程" andTitle:@"提示" andIsReturn:NO];
    }else {
        [manager POST:jcbgUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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
    
    self.imagePick.delegate = self;
    
    [self.view addSubview:self.checkTable];
    
    [self registerCell];
    
}

// 注册cell
- (void)registerCell
{
    [self.checkTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.checkTable registerNib:[UINib nibWithNibName:@"LeaveStartTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lstartCell"];
    [self.checkTable registerNib:[UINib nibWithNibName:@"ChooseProjectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"choosePjtCell"];
    [self.checkTable registerNib:[UINib nibWithNibName:@"LeaveReasonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lreasonCell"];
    
    [self.checkTable registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.checkTable registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.checkTable registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

//  段高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return 100;
    }else if (indexPath.section == 7) {
        if (self.photoArr.count) {
            return 100;
        }else {
            return 0;
        }
    }else if (indexPath.section == 5) {
        if (self.nowPhotoArr.count) {
            return 100;
        }else {
            return 0;
        }
    }else if (indexPath.section == 8) {
        return _apCellHeight + 110;
    }else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleName.text = @"录入人";
        cell.days.placeholder = @"默认为本人";
        cell.days.delegate = self;
        return cell;
        
    }else if (indexPath.section == 1) {
        LeaveStartTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lstartCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"检查时间";
        cell.startCellDelegate = self;
        cell.passTimeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 2) {
        ChooseProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choosePjtCell" forIndexPath:indexPath];
        cell.chooseBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        cell.chooseBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [cell.chooseBut addTarget:self action:@selector(clickChooseBut:) forControlEvents:UIControlEventTouchUpInside];
        if (self.checkPName != nil) {
            [cell.chooseBut setTitle:self.checkPName forState:UIControlStateNormal];
        }else {
            [cell.chooseBut setTitle:@"==请选择==" forState:UIControlStateNormal];
        }
        return cell;
        
    }else if (indexPath.section == 3) { // 现场照片  附件  审批流程
        LeaveReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lreasonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.reasonTitle.text = @"报告内容";
        cell.passReasonDelegate = self;
        if (_leaveNots) {
            cell.reasonText.text = _leaveNots;
        }
        return cell;
        
    }else if (indexPath.section == 4) {
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"现场照片";
        cell.image.image = [UIImage imageNamed:@"record_camera"];
        return cell;
        
    }else if (indexPath.section == 5) {
        PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.checkTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.nowPhotoArr.count > 0) {
            [cell loadPhotosData:self.nowPhotoArr];
            cell.hidden = NO;
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 6) {
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"附件";
        cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
        return cell;
        
    }else if (indexPath.section == 7) {
        PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.checkTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.photoArr.count > 0) {
            [cell loadPhotosData:self.photoArr];
            cell.hidden = NO;
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 8) {
        LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = @"JCBG";
        cell.leaveDelegate = self;
        cell.passApIdDelegate = self;
        cell.passHeightDelegate = self;
        cell.passStepDataDelegate = self;
        return cell;
        
    }else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) { // 现场图片
        [self creatAlertControllerWithCamera:YES];
    }else if (indexPath.section == 6) { // 附件
        [self creatAlertControllerWithCamera:NO];
    }
}

//  通过警告控制器选择  附件从相册选出还是相机相机选出
- (void)creatAlertControllerWithCamera:(BOOL)type
{
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (type) {
        // 设置拍照警告响应事件
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 设置照片来源为相机
            self.imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 设置进入相机时使用前置或后置摄像头
            self.imagePick.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            self.imagePick.allowsEditing = YES;
            // 展示选取照片控制器
            [self presentViewController:self.imagePick animated:YES completion:^{}];
        }];
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            // 添加警告按钮
            [alert addAction:cameraAction];
        }
        _isFieldPhoto = true;
        // 设置相册警告响应事件
        UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getOriginalImages];
        }];
        [alert addAction:photosAction];
    }else {
        _isFieldPhoto = false;
        // 设置相册警告响应事件
        UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getOriginalImages];
        }];
        [alert addAction:photosAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancelAction];
    // 展示警告控制器
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    UIImage *img = editingInfo[UIImagePickerControllerOriginalImage];
    [self.nowPhotoArr addObject:img];
    [self.checkTable reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationAutomatic];
    // 上传图片
    [self upLoadImageWith:[self scaleImage:img ToWidth:1200] andIsFujian:YES];
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
// 选择照片回调
#pragma mark --选择图片passDelegate--
- (void)passSelectPhotosFromPhotosVC:(NSMutableArray *)selectArr
{
    if (_isFieldPhoto) {
        self.nowPhotoArr = selectArr;
        for (UIImage *image in selectArr) {
            // 上传图片
            [self upLoadImageWith:[self scaleImage:image ToWidth:1200] andIsFujian:YES];
        }
        [self.checkTable reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else {
        self.photoArr = selectArr;
        for (UIImage *image in selectArr) {
            [self upLoadImageWith:image andIsFujian:NO];
        }
        [self.checkTable reloadSections:[NSIndexSet indexSetWithIndex:7] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

// 设置上传图片尺寸大小 最大边长
- (UIImage *)scaleImage:(UIImage *)sourceImage ToWidth:(CGFloat)width
{
    // 如果传入的宽度比当前宽度还要大,就直接返回
    if (width > sourceImage.size.width) {
        return  sourceImage;
    }
    CGFloat widthFactor = width / sourceImage.size.width;
    CGFloat heightFactor = width / sourceImage.size.height;
    CGFloat scaleFactor = 0.0;  // 比例
    if (widthFactor >= heightFactor) {
        scaleFactor = heightFactor;
    }else {
        scaleFactor = widthFactor;
    }
    // 初始化要画的大小
    CGRect  rect = CGRectMake(0, 0, scaleFactor*sourceImage.size.width, scaleFactor*sourceImage.size.height);
    // 1. 开启图形上下文
    UIGraphicsBeginImageContext(rect.size);
    // 2. 画到上下文中 (会把当前image里面的所有内容都画到上下文)
    [sourceImage drawInRect:rect];
    // 3. 取到图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    // 4. 关闭上下文
    UIGraphicsEndImageContext();
    // 5. 返回
    return image;
}

// 上传图片
- (void)upLoadImageWith:(UIImage *)image andIsFujian:(BOOL)isF;
{
    NSString *url = @"";
    NSData *data = [NSData data];
    if (isF) {
        data = UIImageJPEGRepresentation(image, 1.0);
        url = [NSString stringWithFormat:@"%@/uploadFile/saveFiles?num=1",intranetURL];
    }else {
        data = UIImageJPEGRepresentation(image, 0.5);
        url = [NSString stringWithFormat:@"%@/uploadFile/saveFile?num=1",intranetURL];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *imageDate = [formatter stringFromDate:[NSDate date]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:isF ? @"fileList":@"files" fileName:[NSString stringWithFormat:@"%@.jpg",imageDate] mimeType:@"image/jpg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dic in responseObject[@"rows"]) {
            ApproveEnclosureModel *model = [[ApproveEnclosureModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (isF) {
                // 现场图片
                [self.postNowArr addObject:model];
            }else { // 附件图片
                [self.postArr addObject:model];
            }
        }
        if ([responseObject[@"status"] isEqualToString:@"yes"]) {
            [self showAlertControllerMessage:@"上传成功" andTitle:@"提示" andIsReturn:NO];
        }else {
            [self showAlertControllerMessage:@"上传失败,网络错误" andTitle:@"提示" andIsReturn:NO];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"上传失败" andTitle:@"提示" andIsReturn:NO];
    }];
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --LeaveForApproveCell--
- (void)passPickViewFormLeaveForApproveCell:(UIView *)view
{
    [self.view addSubview:view];
}
- (void)passHeightFromLeaveCell:(CGFloat)height
{
    if (height == 0) {
        _apCellHeight = height;
    }else {
        _apCellHeight = height - 50;
    }
    [self.checkTable reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)passStepDataFormLeaveCellWithStepData:(NSMutableArray *)step
{
    _step = step;
}
- (void)passApproveIdFromLeaveCell:(NSString *)apId
{
    _apId = apId;
}

#pragma mark --选择项目按钮--
- (void)clickChooseBut:(UIButton *)but
{
    SpecialPJTViewController *spjtVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SPJTVC"];
    spjtVC.title = @"项目列表";
    spjtVC.delegate = self;
    spjtVC.name = @"jcbg";
    spjtVC.pickData = @[@"负责人",@"项目名称",@"建设单位",@"业绩归属"];
    [self.navigationController pushViewController:spjtVC animated:YES];
}

#pragma mark --passProjectDataFromSpecialPJTVC--
- (void)passProjectDataWithModel:(SpecialPJTModel *)model
{
    self.checkPName = model.bpcName;
    self.checkId = model.piId;
    [self.checkTable reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark --startTimeCellDelegate--
- (void)passDatePickViewFromStartCell:(UIView *)sender
{
    [self.view addSubview:sender];
}
- (void)passLeaveTime:(NSString *)time
{
    _checkTime = time;
}

#pragma mark --passReasonDelegate--
- (void)passReason:(NSString *)reason
{
    _leaveNots = reason;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _name = textField.text;
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
