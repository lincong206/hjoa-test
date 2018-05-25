//
//  DocApplyViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/12/21.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  文档管理 -> 借出申请界面   WDJC

#import "DocApplyViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "SubmitView.h"
#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"
#import "ApproveEnclosureModel.h"

#import "ChooseProjectCell.h"
#import "LeaveReasonCell.h"
#import "LeavePhotoCell.h"
#import "PhotosCell.h"
#import "LeaveForApproveCell.h"

#import "SpecialPJTViewController.h"

@interface DocApplyViewController () <UITableViewDelegate, UITableViewDataSource, passReason, passPickViewFormLeaveForApproveCell, passApproveIdFromLeaveCell, passStepDataFormLeaveCell, passHeightFromLeaveCell, passSelectPhotos, passProjectDataFromSpecialPJTVC>
{
    NSString *_leaveNots;
    NSMutableArray *_step;
    NSString *_apId;
    CGFloat _apCellHeight;
    NSString *_docId;       // 文件id
    NSString *_docDescribe; // 文件描述
    NSString *_docOthers;
}
@property (weak, nonatomic) IBOutlet UITableView *LendTable;    //借出

@property (strong, nonatomic) NSString *checkPName;
@property (strong, nonatomic) NSMutableArray *photoArr;
@property (strong, nonatomic) NSMutableArray *postArr;
@property (strong, nonatomic) NSString *pcId;
@end

@implementation DocApplyViewController

- (NSMutableArray *)photoArr
{
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (NSMutableArray *)postArr
{
    if (!_postArr) {
        _postArr = [NSMutableArray array];
    }
    return _postArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"借出申请";
    
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
    //  用户id
    [params setValue:[user objectForKey:@"uiId"] forKey:@"uiId"];
    //  用户姓名
    [params setValue:[user objectForKey:@"uiName"] forKey:@"rfmUiname"];
    //  用户部门
    [params setValue:[user objectForKey:@"uiPsname"] forKey:@"upName"];
    //  文档借出
    [params setValue:@"借出" forKey:@"rfmStatus"];
    //  文档id
    if (_docId) {
        [params setObject:_docId forKey:@"rfId"];
    }else {
        [params setObject:@"" forKey:@"rfId"];
    }
    //  文档名字
    if (_docDescribe) {
        [params setObject:_docDescribe forKey:@"rfmDescribe"];
    }else {
        [params setObject:@"" forKey:@"rfmDescribe"];
    }
    //  文档名字
    if (_docOthers) {
        [params setObject:_docOthers forKey:@"rfmOthers"];
    }else {
        [params setObject:@"" forKey:@"rfmOthers"];
    }
    //  借出理由
    if (_leaveNots) {
        [params setObject:_leaveNots forKey:@"rfmReason"];
    }else {
        [params setObject:@"" forKey:@"rfmReason"];
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
    [dic1 setObject:@"WDJC" forKey:@"piType"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"文档借阅审批审批;编号及名称:DAM%@null,文档借阅",nameStr];
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
    if (self.postArr.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.postArr) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:@"WDJC" forKey:@"piType"];
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
    
    if (self.checkPName == nil || [self.checkPName isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请选择文档" andTitle:@"提示" andIsReturn:NO];
    }else if (_leaveNots == nil || [_leaveNots isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写借出理由" andTitle:@"提示" andIsReturn:NO];
    }else if (_step.count == 0) {
        [self showAlertControllerMessage:@"请选择审批流程" andTitle:@"提示" andIsReturn:NO];
    }else {
        
        [manager POST:wdsqUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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
    self.LendTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self tableviewRegisterCell];
}

- (void)tableviewRegisterCell
{
    [self.LendTable registerNib:[UINib nibWithNibName:@"ChooseProjectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"choosePjtCell"];
    [self.LendTable registerNib:[UINib nibWithNibName:@"LeaveReasonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lreasonCell"];
    [self.LendTable registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.LendTable registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.LendTable registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
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
    if (indexPath.section == 1) {
        return 100;
    }else if (indexPath.section == 3) {
        if (self.photoArr.count) {
            return 100;
        }else {
            return 0;
        }
    }else if (indexPath.section == 4) {
        return _apCellHeight + 110;
    }else {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ChooseProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choosePjtCell" forIndexPath:indexPath];
        cell.name.text = @"选择文档";
        cell.chooseBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        cell.chooseBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [cell.chooseBut addTarget:self action:@selector(clickChooseBut:) forControlEvents:UIControlEventTouchUpInside];
        if (self.checkPName != nil) {
            [cell.chooseBut setTitle:self.checkPName forState:UIControlStateNormal];
        }else {
            [cell.chooseBut setTitle:@"==请选择==" forState:UIControlStateNormal];
        }
        return cell;
    }else if (indexPath.section == 1) { // 借出理由
        LeaveReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lreasonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.reasonTitle.text = @"借出理由";
        cell.reasonText.text = @"请输入借出理由(必填)";
        cell.passReasonDelegate = self;
        if (_leaveNots) {
            cell.reasonText.text = _leaveNots;
        }
        return cell;
    }else if (indexPath.section == 2) { // 附件
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"附件";
        cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
        return cell;
    }else if (indexPath.section == 3) {
        PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.LendTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.photoArr.count) {
            [cell loadPhotosData:self.photoArr];
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 4) { // 审批流程
        LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = @"WDJC";
        cell.leaveDelegate = self;
        cell.passApIdDelegate = self;
        cell.passHeightDelegate = self;
        cell.passStepDataDelegate = self;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        [self creatAlertControllerWithCamera];
    }
}

//  通过警告控制器选择  附件从相册选出还是相机相机选出
- (void)creatAlertControllerWithCamera
{
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置相册警告响应事件
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getOriginalImages];
    }];
    [alert addAction:photosAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancelAction];
    // 展示警告控制器
    [self presentViewController:alert animated:YES completion:nil];
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
    [self.LendTable reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
    for (UIImage *image in selectArr) {
        [self upLoadImageWith:image];
    }
    
}
// 上传图片
- (void)upLoadImageWith:(UIImage *)image
{
    NSString *url = @"";
    NSData *data = [NSData data];
    data = UIImageJPEGRepresentation(image, 0.5);
    url = [NSString stringWithFormat:@"%@/uploadFile/saveFile?num=1",intranetURL];
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
            // 附件图片
            [self.postArr addObject:model];
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

#pragma mark --passReasonDelegate--
- (void)passReason:(NSString *)reason
{
    _leaveNots = reason;
}
#pragma mark --选择项目按钮--
- (void)clickChooseBut:(UIButton *)but
{
    SpecialPJTViewController *spjtVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SPJTVC"];
    spjtVC.title = @"文档列表";
    spjtVC.delegate = self;
    spjtVC.name = @"WDJC";
    spjtVC.pickData = @[@"人员证书",@"获奖证书",@"合同文件",@"行政资料",@"工程资料",@"规范书籍",@"分公司资料",@"子公司资料",@"财务资料",@"其他"];
    [self.navigationController pushViewController:spjtVC animated:YES];
}
#pragma mark --passProjectDataFromSpecialPJTVC--
- (void)passProjectDataWithModel:(SpecialPJTModel *)model
{
    self.checkPName = model.rfMold;
    _docId = model.rfId;
    _docDescribe = model.rfDescribe;
    _docOthers = model.rfOthers;
    [self.LendTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self.LendTable reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)passStepDataFormLeaveCellWithStepData:(NSMutableArray *)step
{
    _step = step;
}
- (void)passApproveIdFromLeaveCell:(NSString *)apId
{
    _apId = apId;
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsReturn:(BOOL)isR
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
