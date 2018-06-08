//
//  WeeklyViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/7/19.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  周报

#import "WeeklyViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "ApproveEnclosureModel.h"

#import "LeaveTypeCell.h"
#import "LeaveDaysCell.h"
#import "LeaveReasonCell.h"
#import "LeavePhotoCell.h"
#import "PhotosCell.h"
#import "LeaveForApproveCell.h"
#import "ChooseProjectCell.h"
#import "SpecialPJTViewController.h"
#import "SubmitView.h"

#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"

#import "NowPhotosCell.h"


@interface WeeklyViewController () <UITableViewDelegate, UITableViewDataSource, passPickViewFromTypeCell, passTypeLabelFromTypeCell, passProjectDataFromSpecialPJTVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, passPickViewFormLeaveForApproveCell, passApproveIdFromLeaveCell, passHeightFromLeaveCell, passStepDataFormLeaveCell, passSelectPhotos, passReasonWithTag, passLeaveDaysCellText>
{
    NSArray *_companyArr;
    NSString *_company;
    NSString *_zbType;      // 周报类型
    NSInteger _shang;
    BOOL _isNow;
}

@property (weak, nonatomic) IBOutlet UITableView *weeklyTable;

@property (assign, nonatomic) NSInteger isPJT;   // 是否为项目部的周报  -> 1 项目部
@property (strong, nonatomic) NSString *projectName;

@property (strong, nonatomic) NSMutableArray *photoArr;
@property (strong, nonatomic) UIImagePickerController *imagePick;

@property (strong, nonatomic) NSString *pjtId;  // 项目周报时的项目ID
@property (strong, nonatomic) NSString *wkType; // 周报类型

@property (strong, nonatomic) NSString *wkTitle; // 周报标题
@property (strong, nonatomic) NSString *wkFinishwork; // 完成工作
@property (strong, nonatomic) NSString *wkSummarywork; // 本周总结
@property (strong, nonatomic) NSString *wkWorkplan; // 下周计划
@property (strong, nonatomic) NSString *wkNeedcoor; // 协调帮忙
@property (strong, nonatomic) NSString *approveType; // 审批类型
@property (strong, nonatomic) NSString *approveId;  // 审批流id

@property (assign, nonatomic) CGFloat approveCellHeight;

@property (strong, nonatomic) NSMutableArray *step;

@property (strong, nonatomic) NSMutableArray *stepPhotoArr; // 附件
@property (strong, nonatomic) NSMutableArray *upNowPhotos;  // 现场照片
@property (strong, nonatomic) NSUserDefaults *user;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation WeeklyViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

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
- (NSMutableArray *)upNowPhotos
{
    if (!_upNowPhotos) {
        _upNowPhotos = [NSMutableArray array];
    }
    return _upNowPhotos;
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBut)];
    
    SubmitView *submiView = [[SubmitView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 60, kscreenWidth, 60)];
    [submiView.but addTarget:self action:@selector(clickSubmitBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submiView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 保存按钮delegate     归档解档   本地缓存
- (void)clickSaveBut
{
    [self.navigationController popViewControllerAnimated:YES];
}

//  提交按钮delegate
- (void)clickSubmitBut:(UIButton *)sender
{
    self.approveType = @"ZBSPL";
    //  上传周报数据
    
    [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    // 用户id
    NSString *uiId = [self.user objectForKey:@"uiId"];
    [params setObject:uiId forKey:@"uiId"];
    // 部门id
    NSString *psId = [self.user objectForKey:@"psId"];
    [params setObject:psId forKey:@"psId"];
    // 用户姓名
    NSString *name = [self.user objectForKey:@"uiName"];
    [params setObject:name forKey:@"wkCodetype"];
    // 部门名称
    NSString *psName = [self.user objectForKey:@"uiPsname"];
    [params setObject:psName forKey:@"wkDepartment"];
    // 创建日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    [params setObject:dateTime forKey:@"wkDate"];
    if (self.projectName) {
        // 项目id
        [params setObject:self.pjtId forKey:@"piId"];
        // 项目名称
        [params setObject:self.projectName forKey:@"wkEntryname"];
    }else {
        // 项目id
        [params setObject:@"" forKey:@"piId"];
        // 项目名称
        [params setObject:@"" forKey:@"wkEntryname"];
    }
    // 是否提交
    [params setObject:@"1" forKey:@"wkStr"];
    // 周报类型
    if (self.wkType) {
        [params setObject:self.wkType forKey:@"wkType"];
    }else {
        [params setObject:@"" forKey:@"wkType"];
    }
    // 周报类型
    if (_zbType) {
        [params setObject:_zbType forKey:@"wkTypebao"];
    }else {
        [params setObject:@"" forKey:@"wkTypebao"];
    }
    // 区域
    if (_company) {
        [params setObject:_company forKey:@"wkCompant"];
    }else {
        [params setObject:@"" forKey:@"wkCompant"];
    }
    // 周报标题
    if (self.wkTitle) {
        [params setObject:self.wkTitle forKey:@"wkTitle"];
    }
    // 本周完成工作
    if (self.wkFinishwork) {
        [params setObject:self.wkFinishwork forKey:@"wkFinishworkweek"];
    }
    // 本周总结
    if (self.wkSummarywork) {
        [params setObject:self.wkSummarywork forKey:@"wkSummaryworkweek"];
    }
    // 下周计划
    if (self.wkWorkplan) {
        [params setObject:self.wkWorkplan forKey:@"wkWorkplannext"];
    }
    // 协调帮忙
    if (self.wkNeedcoor) {
        [params setObject:self.wkNeedcoor forKey:@"wkNeedcoordination"];
    }
    
    //  params 参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //  status 第一个
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    if (self.approveId) {
        [dic1 setObject:self.approveId forKey:@"apId"];
    }else {
        [dic1 setObject:@"" forKey:@"apId"];
    }
    
    [dic1 setObject:@"" forKey:@"piId"];
    // 获取当天日期 (不带-)
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"周报审批;编号及名称:ZBSPL%@null,周报",nameStr];
    [dic1 setObject:nameStr forKey:@"astDocName"];      // 周报名字
    [dic1 setObject:self.approveType forKey:@"piType"];
    [dic1 setObject:[self.user objectForKey:@"uiId"] forKey:@"uiId"];
    [dic1 setObject:@"" forKey:@"piMoney"];
    [dic setObject:dic1 forKey:@"status"];
    
    //  files 第三个参数 上传图片
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    NSString *fileString = @"";
    NSString *nowString = @"";
    // 有数据
    if (self.stepPhotoArr.count == 0) {
        
    }else {
        NSMutableDictionary *photos = [NSMutableDictionary dictionary];
        for (ApproveEnclosureModel *model in self.stepPhotoArr) {
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setValue:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setValue:@"empty" forKey:@"piId"];
            [photos setObject:self.approveType forKey:@"piType"];
            [photos setObject:[self.user objectForKey:@"uiId"] forKey:@"uiId"];
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
    if (self.upNowPhotos.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.upNowPhotos) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:@"ZBSG" forKey:@"piType"];
            [photos setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"uiId"];
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
    
    // 必填字段
    if ([self.wkType isEqualToString:@""] || self.wkType == nil) {
        [self showAlertControllerMessage:@"请选择周报类型" andTitle:@"提示" andIsReturn:NO];
    }else if ([self.wkTitle isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写标题" andTitle:@"提示" andIsReturn:NO];
    }else if ([self.wkFinishwork isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写本周完成工作" andTitle:@"提示" andIsReturn:NO];
    }else if ([self.wkWorkplan isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写下周计划" andTitle:@"提示" andIsReturn:NO];
    }else if (self.step.count == 0) {
        [self showAlertControllerMessage:@"请设置审批流程" andTitle:@"提示" andIsReturn:NO];
    }else {
        // 审批流程
        [dic setObject:self.step forKey:@"stepReceives"];
        // 文字备注
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setObject:@"" forKey:@"con"];
        [dic setObject:dic3 forKey:@"curr"];

        // 字典转data
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [params setObject:paramsStr forKey:@"params"];

        [self.manager POST:weeklyUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                // 删除零时数据
                [self.user removeObjectForKey:@"wkTitle"];
                [self.user removeObjectForKey:@"wkFinishwork"];
                [self.user removeObjectForKey:@"wkSummarywork"];
                [self.user removeObjectForKey:@"wkWorkplan"];
                [self.user removeObjectForKey:@"wkNeedcoor"];
                //  成功上传
                self.wkId = responseObject[@"wkId"];
                [self showAlertControllerMessage:@"申请成功" andTitle:@"提示" andIsReturn:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertControllerMessage:@"网络不给力" andTitle:@"提示" andIsReturn:NO];
        }];
    }
}

- (void)passStepDataFormLeaveCellWithStepData:(NSMutableArray *)step
{
    self. step = step;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.imagePick.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    _companyArr =  @[@"请选择",@"华南华中区域",@"西南西北区域",@"华东区域",@"成都分公司",@"厦门分公司",
                     @"海南分公司",@"河南分公司",@"贵州分公司",@"安徽分公司",@"烟台分公司",@"宁夏分公司",
                     @"重庆分公司",@"江西分公司",@"新疆分公司",@"广州分公司",@"北京分公司",@"陕西分公司",
                     @"云南分公司"];
    
    [self tableviewRegisterCell];
    
    _zbType = @"周报";
    
    self.weeklyTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.user = [NSUserDefaults standardUserDefaults];
    self.wkTitle = [self.user objectForKey:@"wkTitle"];
    self.wkFinishwork = [self.user objectForKey:@"wkFinishwork"];
    self.wkSummarywork = [self.user objectForKey:@"wkSummarywork"];
    self.wkWorkplan = [self.user objectForKey:@"wkWorkplan"];
    self.wkNeedcoor = [self.user objectForKey:@"wkNeedcoor"];
    
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.weeklyTable.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.weeklyTable.contentInset = UIEdgeInsetsZero;
}

- (void)tableviewRegisterCell
{
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"LeaveTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ltypeCell"];
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"ChooseProjectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"choosePjtCell"];
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"LeaveReasonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lreasonCell"];
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
    [self.weeklyTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (self.isPJT > 0) {
            return 10;
        }else {
            return 0;
        }
    }
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark --passHeightFromLeaveCell--
- (void)passHeightFromLeaveCell:(CGFloat)height
{
    _approveCellHeight = height;
    [self.weeklyTable reloadSections:[NSIndexSet indexSetWithIndex:11] withRowAnimation:UITableViewRowAnimationBottom];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (self.isPJT > 0) {
            return 50;
        }else {
            return 0;
        }
    }else if (indexPath.section == 9) {
        if (self.photoArr.count) {
            return 100;
        }else {
            return 0;
        }
    }else if (indexPath.section == 11) {
        return _shang*((kscreenWidth-40)/3) + (_shang * 10);
    }else if (indexPath.section == 12) {
        return _approveCellHeight + 80;
    }else if (indexPath.section > 3 && indexPath.section < 8) {
        return 100;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"请选择",@"本部",@"项目部",@"分公司项目部"];
        cell.typeName.text = @"汇报类型";
        cell.pickData = [NSArray arrayWithArray:arr];
        cell.typeCellDelegate = self;
        cell.passTypeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 1) {
        if (self.isPJT == 1) {
            ChooseProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choosePjtCell" forIndexPath:indexPath];
            cell.chooseBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            cell.chooseBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
            [cell.chooseBut addTarget:self action:@selector(clickChooseBut:) forControlEvents:UIControlEventTouchUpInside];
            if (self.projectName != nil) {
                [cell.chooseBut setTitle:self.projectName forState:UIControlStateNormal];
            }else {
                [cell.chooseBut setTitle:@"==请选择==" forState:UIControlStateNormal];
            }
            //  是项目部的周报就显示
            self.wkType = @"1";
            return cell;
        }else {
            LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.typeName.text = @"区域";
            cell.pickData = [NSArray arrayWithArray:_companyArr];
            cell.typeCellDelegate = self;
            cell.passTypeDelegate = self;
            if (self.isPJT == 2) {
                self.wkType = @"2";
                cell.hidden = NO;
            }else if (self.isPJT == -1) {
                self.wkType = @"0";
                cell.hidden = YES;
            }
            return cell;
        }
        
    }else if (indexPath.section == 2) { // 周报类型
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeName.text = @"汇报类别";
        cell.pickData = @[@"周报",@"月报",@"年报"];
        cell.typeLabel.text = cell.pickData.firstObject;
        cell.typeCellDelegate = self;
        cell.passTypeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 3) { // 标题
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleName.text = @"标题";
        cell.passTextDelegate = self;
        if (self.wkTitle) {
            cell.days.text = self.wkTitle;
        }else {
            cell.days.placeholder = @"请输入文字";
        }
        return cell;
        
    }else if (indexPath.section > 3 && indexPath.section < 8) {
        LeaveReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lreasonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *titleArr = @[@"本周完成工作",@"本周工作总结",@"下周工作计划",@"协调与帮助"];
        cell.reasonTitle.text = titleArr[indexPath.section - 4];
        cell.passReasonTagDelegate = self;
        cell.reasonText.tag = indexPath.section + 200;
        if (self.wkFinishwork && cell.reasonText.tag == 204) {
            cell.reasonText.text = self.wkFinishwork;
        }
        if (self.wkSummarywork && cell.reasonText.tag == 205) {
            cell.reasonText.text = self.wkSummarywork;
        }
        if (self.wkWorkplan && cell.reasonText.tag == 206) {
            cell.reasonText.text = self.wkWorkplan;
        }
        if (self.wkNeedcoor && cell.reasonText.tag == 207) {
            cell.reasonText.text = self.wkNeedcoor;
        }
        return cell;
        
    }else if (indexPath.section == 8) {
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"附件";
        cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
        return cell;
        
    }else if (indexPath.section == 9) {
        PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.weeklyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.photoArr.count > 0) {
            [cell loadPhotosData:self.photoArr];
            cell.hidden = NO;
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 10) {  // 现场照片
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"现场照片";
        cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
        return cell;
    }else if (indexPath.section == 11) {     // 图片显示
        NowPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nowPhotosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.upNowPhotos.count) {
            [cell loadNowPhotosFromData:self.upNowPhotos];
        }
        return cell;
    }else if (indexPath.section == 12) {
        LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = @"ZBSPL";
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
    if (indexPath.section == 8) {
        _isNow = false;
        [self creatAlertController];
    }else if (indexPath.section == 10) {
        _isNow = true;
        [self creatAlertController];
    }
}

#pragma mark --附件--
//  通过警告控制器选择  附件从相册选出还是相机相机选出
- (void)creatAlertController
{
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (_isNow) {
        
    }else {
        // 设置拍照警告响应事件
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 设置照片来源为相机
            self.imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 设置进入相机时使用前置或后置摄像头
            self.imagePick.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            // 展示选取照片控制器
            [self presentViewController:self.imagePick animated:YES completion:^{}];
        }];
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            // 添加警告按钮
            [alert addAction:cameraAction];
        }
    }
    // 设置相册警告响应事件
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getOriginalImages];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:photosAction];
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
    if (self.isPJT == 1) {
        photosVC.isMSelect = true;
    }else {
        photosVC.isMSelect = false;
    }
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
    if (_isNow) {   // 现场照片
        if (selectArr.count%3 == 0) {
            _shang = selectArr.count/3;
        }else {
            _shang = (NSInteger)(selectArr.count/3) + 1;
        }
        if (self.isPJT == 1) {      // 判断是否为项目部
            if (selectArr.count > 8) {      // 项目部上传图片最少8张
                for (UIImage *image in selectArr) {
                    [self upLoadImageWith:[self scaleImage:image ToWidth:1200] isNow:YES];
                }
            }else {
                [self showAlertControllerMessage:@"根据集团要求:项目部周报必须上传”安全文明图片4张“,”项目部图片4张" andTitle:@"提示" andIsReturn:NO];
            }
        }else {
            for (UIImage *image in selectArr) {
                [self upLoadImageWith:[self scaleImage:image ToWidth:1200] isNow:YES];
            }
        }
    }else {         // 附件
        self.photoArr = selectArr;
        for (UIImage *image in selectArr) {
            [self upLoadImageWith:[self scaleImage:image ToWidth:0] isNow:NO];
        }
    }
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    UIImage *img = editingInfo[UIImagePickerControllerOriginalImage];
    [self.photoArr addObject:img];
    // 上传图片
    [self upLoadImageWith:[self scaleImage:image ToWidth:0] isNow:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 设置上传图片尺寸大小 最大边长
- (UIImage *)scaleImage:(UIImage *)sourceImage ToWidth:(CGFloat)width
{
    // 如果传入的宽度比当前宽度还要大,就直接返回
    if (width == 0) {
        return sourceImage;
    }else if (width > sourceImage.size.width) {
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

// 上传图片 分为现场照片和附件       true -> 现场照片
- (void)upLoadImageWith:(UIImage *)image isNow:(BOOL)isNow
{
    NSString *url = @"";
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    if (isNow) {
        url = [NSString stringWithFormat:@"%@/uploadFile/saveFiles?num=1",intranetURL];
    }else {
        url = [NSString stringWithFormat:@"%@/uploadFile/saveFile?num=1",intranetURL];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *imageDate = [formatter stringFromDate:[NSDate date]];
    
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [self.manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:isNow ? @"fileList":@"files" fileName:[NSString stringWithFormat:@"%@.jpg",imageDate] mimeType:@"image/jpg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dic in responseObject[@"rows"]) {
            ApproveEnclosureModel *model = [[ApproveEnclosureModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (isNow) {
                // 现场图片
                [self.upNowPhotos addObject:model];
            }else { // 附件图片
                [self.stepPhotoArr addObject:model];
            }
        }
        if ([responseObject[@"status"] isEqualToString:@"yes"]) {
            [self showAlertControllerMessage:@"上传成功" andTitle:@"提示" andIsReturn:NO];
            if (isNow) {
                [self.weeklyTable reloadSections:[NSIndexSet indexSetWithIndex:11] withRowAnimation:UITableViewRowAnimationAutomatic];
            }else {
                [self.weeklyTable reloadSections:[NSIndexSet indexSetWithIndex:9] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }else {
            [self showAlertControllerMessage:@"上传失败,网络错误" andTitle:@"提示" andIsReturn:NO];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"上传失败" andTitle:@"提示" andIsReturn:NO];
    }];
}

#pragma mark --UITextFieldDelegate--
- (void)passLeaveDaysCellWithText:(NSString *)text
{
    self.wkTitle = text;
    [self.user setObject:self.wkTitle forKey:@"wkTitle"];
}
#pragma mark --passReasonWithTag--
- (void)passReason:(NSString *)reason andTag:(NSInteger)tag
{
    switch (tag) {
        case 204:
            self.wkFinishwork = reason;
            [self.user setObject:self.wkFinishwork forKey:@"wkFinishwork"];
            break;
        case 205:
            self.wkSummarywork = reason;
            [self.user setObject:self.wkSummarywork forKey:@"wkSummarywork"];
            break;
        case 206:
            self.wkWorkplan = reason;
            [self.user setObject:self.wkWorkplan forKey:@"wkWorkplan"];
            break;
        case 207:
            self.wkNeedcoor = reason;
            [self.user setObject:self.wkNeedcoor forKey:@"wkNeedcoor"];
            break;
        default:
            break;
    }
}
- (void)passPickViewFormLeaveForApproveCell:(UIView *)view
{
    [self.view addSubview:view];
}

// 设置审批流，获取审批流id
#pragma mark --passApproveIdFromLeaveCell--
- (void)passApproveIdFromLeaveCell:(NSString *)apId
{
    self.approveId = apId;
}

#pragma mark --按钮block--
- (void)clickChooseBut:(UIButton *)sender
{
    SpecialPJTViewController *spjtVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SPJTVC"];
    spjtVC.title = @"项目列表";
    spjtVC.delegate = self;
    spjtVC.name = @"xmbx";
    [self.navigationController pushViewController:spjtVC animated:YES];
}

#pragma mark --passProjectDataFromSpecialPJTVC--
- (void)passProjectDataWithModel:(SpecialPJTModel *)model
{
    self.projectName = model.piName;
    self.pjtId = model.piId;
    [self.weeklyTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    for (NSString *string in _companyArr) {
        if ([type isEqualToString:string]) {
            _company = type;
            break;
        }
    }
    if ([type isEqualToString:@"项目部"]) {
        self.isPJT = 1;
    }else if ([type isEqualToString:@"分公司项目部"]) {
        self.isPJT = 2;
    }else if ([type isEqualToString:@"本部"]) {
        self.isPJT = -1;
    }else if ([type isEqualToString:@"周报"]) {
        _zbType = type;
    }else if ([type isEqualToString:@"月报"]) {
        _zbType = type;
    }else if ([type isEqualToString:@"年报"]) {
        _zbType = type;
    }else {
        self.isPJT = 3;
    }
    
    if (self.isPJT != 3) {
        [self.weeklyTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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
