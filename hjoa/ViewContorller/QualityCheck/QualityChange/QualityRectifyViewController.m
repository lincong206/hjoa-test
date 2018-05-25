//
//  QualityRectifyViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  质量整改 -> 详情

#import "QualityRectifyViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "ApproveEnclosureModel.h"
#import "ApproveProcedureModel.h"
#import "DRDetailsModel.h"
#import "LeaveDaysCell.h"
#import "QCDetailsCell.h"
#import "QCContentCell.h"
#import "QCResultCell.h"
#import "QCStatusButCell.h"
#import "QRDetailsCell.h"
#import "NowPhotosCell.h"
#import "ApproveEnclosureCell.h"
#import "ApproveProcedureCell.h"
#import "ZGGCCell.h"
#import "replyModel.h"
#import "ReplyQRButViewController.h"

@interface QualityRectifyViewController () <UITableViewDelegate, UITableViewDataSource, passQCContentCellHeight, passQCResultCellHeight, ApproveEnclosureCellDelegate, passAPCellHeight, passZGGCCellHeight, passZGFJStatus>
{
    NSInteger _shang;
    NSString *_url;
    CGFloat _height;
    NSArray *_name;
    NSArray *_icon;
    NSString *_rectificationstatus;     // 判断 0->待整改 1->待复检 2->完成
    NSString *_brrId;                    // 回复需要
    NSString *_uiId;                        // 整改人
    NSString *_reporter;                    // 复检人
}
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UITableView *rectifyTable;

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSMutableDictionary *getPhotosParas;
@property (strong, nonatomic) NSMutableArray *nowPhotosArr;         //现场照片
@property (strong, nonatomic) NSMutableArray *photosArr;            //复检
@property (strong, nonatomic) NSMutableArray *procedureData;        //审批数据

@property (strong, nonatomic) UIButton *QRBut;                      //底部回复按钮

@property (strong, nonatomic) NSMutableArray *replyZGData;            //整改信息
@property (strong, nonatomic) NSMutableArray *replyFJData;            //复检信息
@property (strong, nonatomic) NSMutableArray *replyData;            //复检信息
@end

@implementation QualityRectifyViewController

- (NSMutableArray *)replyData
{
    if (!_replyData) {
        _replyData = [NSMutableArray array];
    }
    return _replyData;
}

- (NSMutableArray *)replyZGData
{
    if (!_replyZGData) {
        _replyZGData = [NSMutableArray array];
    }
    return _replyZGData;
}

- (NSMutableArray *)replyFJData
{
    if (!_replyFJData) {
        _replyFJData = [NSMutableArray array];
    }
    return _replyFJData;
}

- (UIButton *)QRBut
{
    if (!_QRBut) {
        _QRBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _QRBut.frame = CGRectMake((kscreenWidth-200)/2, kscreenHeight-50, 200, 30);
        _QRBut.backgroundColor = [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0];
        _QRBut.titleLabel.font = [UIFont systemFontOfSize:14];
        [_QRBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_QRBut addTarget:self action:@selector(clickQRBut:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _QRBut;
}

- (NSMutableArray *)photosArr
{
    if (!_photosArr) {
        _photosArr = [NSMutableArray array];
    }
    return _photosArr;
}

- (NSMutableArray *)procedureData
{
    if (!_procedureData) {
        _procedureData = [NSMutableArray array];
    }
    return _procedureData;
}

- (NSMutableArray *)nowPhotosArr
{
    if (!_nowPhotosArr) {
        _nowPhotosArr = [NSMutableArray array];
    }
    return _nowPhotosArr;
}

- (NSMutableDictionary *)getPhotosParas
{
    if (!_getPhotosParas) {
        _getPhotosParas = [NSMutableDictionary dictionary];
    }
    return _getPhotosParas;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)rectifyTable
{
    if (!_rectifyTable) {
        if (kscreenHeight == 812) {
            _rectifyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-80) style:UITableViewStylePlain];
        }else {
            _rectifyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-50) style:UITableViewStylePlain];
        }
        _rectifyTable.backgroundColor = [UIColor whiteColor];
        _rectifyTable.delegate = self;
        _rectifyTable.dataSource = self;
        _rectifyTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _rectifyTable;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"质量整改单";
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shang = 0;
    [self.view addSubview:self.rectifyTable];
    // 注册cell
    [self registerCell];
    // 获取数据
    [self loadDataFromSevers];
    // 获取图片信息
    [self loadPhotos];
    [self loadNowPhotos];
    
}

#pragma mark --整改回复or复检回复--
- (void)clickQRBut:(UIButton *)sender
{
    ReplyQRButViewController *replyQRVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"replyQRVC"];
    replyQRVC.title = sender.titleLabel.text;
    replyQRVC.bqiId = self.bqiId;
    replyQRVC.brrId = _brrId;
    replyQRVC.passZGFJStatusDelegate = self;
    [self.navigationController pushViewController:replyQRVC animated:YES];
}
//  整改回复or复检回复 状态
- (void)passZGFJStatusWithRQRButVC:(NSString *)status
{
    [self.passReplyButStatusDelegate passReplyButStatus:status];
}

- (void)registerCell
{
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcDetailsCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcContentCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCResultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcResultCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCStatusButCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcStatusButCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"ApproveEnclosureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aeCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QRDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qrDetailsCell"];
    
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"ApproveProcedureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"apCell"];
    
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"ZGGCCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"zggcCell"];
}

//  获取基本数据
- (void)loadDataFromSevers
{
    [self.dataSource removeAllObjects];
    [self.manager POST:qrUrl parameters:@{@"bqiId":self.bqiId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                DRDetailsModel *model = [[DRDetailsModel alloc] init];
                // 基础信息
                model.birTheme = dic[@"birTheme"];
                model.birEntryperson = dic[@"bsInspectionreport"] [@"birEntryperson"];
                model.birTime = dic[@"bsInspectionreport"] [@"birTime"];
                model.piName = dic[@"piName"];
                model.birResultstate = dic[@"bsInspectionreport"] [@"birResultstate"];
                model.birExamined = dic[@"bsInspectionreport"] [@"birExamined"];
                model.birContent = dic[@"bsInspectionreport"] [@"birContent"];
                model.birInspectionresult = dic[@"bsInspectionreport"] [@"birInspectionresult"];
                // 回复部分
                model.bsRectificationrecheck = dic[@"bsRectificationrecheck"];
                // 回复图片信息
                model.cmAttachmentinformation = dic[@"cmAttachmentinformation"];
                // 整改要求人物和信息
                model.uiId = dic[@"uiId"];
                model.bqiTime = dic[@"bqiTime"];
                model.bqiRequire = dic[@"bqiRequire"];
                // 需要记录整改人和复检人
                _uiId = dic[@"uiId"];
                _reporter = dic[@"bqiReporter"];
                _rectificationstatus = dic[@"bqiRectificationstatus"];
                [self.dataSource addObject:model];
                _brrId = [dic[@"bsRectificationrecheck"] lastObject][@"brrId"];
            }
            [self reOrganizeTheReplyModel:self.dataSource.firstObject];
            [self BasedOnTheStateToAddBut];
            [self.rectifyTable reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"访问失败，请重新访问" andTitle:@"提示"];
        }
    }];
}

// 重新分配回复数据和回复图片    回复消息一条一个数据，图片消息可以多个
- (void)reOrganizeTheReplyModel:(DRDetailsModel *)model
{
    if (model.bsRectificationrecheck.count != 0) {  // 判断是否有值
        for (NSDictionary *replyDic in model.bsRectificationrecheck) {      // 回复数据
            NSMutableArray *ZGimageData = [NSMutableArray array];
            NSMutableArray *FJimageData = [NSMutableArray array];
            for (NSDictionary *imageDic in model.cmAttachmentinformation) { // 图片数据
                if ([replyDic[@"brrId"] integerValue] == [imageDic[@"piId"] integerValue]) {    // 判断唯一表示
                    if ([imageDic[@"piType"] isEqualToString:@"ZG"]) {      // 整改
                        [ZGimageData addObject:imageDic[@"baiUrl"]];
                    }else if ([imageDic[@"piType"] isEqualToString:@"FJ"]) {    // 复检
                        [FJimageData addObject:imageDic[@"baiUrl"]];
                    }
                }
            }
            // 过滤为null的信息
            if (![replyDic[@"brrRectificationuiid"] isEqual:[NSNull alloc]]) {
                replyModel *zgmodel = [[replyModel alloc] init];
                zgmodel.zgTime = replyDic[@"brrRectificationtime"];
                zgmodel.zgUiId = replyDic[@"brrRectificationuiid"];
                zgmodel.zgContent = replyDic[@"brrRectificationcontent"];
                zgmodel.zgImageArr = ZGimageData;
                [self.replyData addObject:zgmodel];
            }
            if (![replyDic[@"brrRecheckuiid"] isEqual:[NSNull alloc]]) {
                replyModel *fjmodel = [[replyModel alloc] init];
                fjmodel.fjTime = replyDic[@"brrRechecktime"];
                fjmodel.fjUiId = replyDic[@"brrRecheckuiid"];
                fjmodel.fjContent = replyDic[@"brrRecheckcontent"];
                fjmodel.status = replyDic[@"brrResultstatus"];
                fjmodel.fjImageArr = FJimageData;
                [self.replyData addObject:fjmodel];
            }
        }
    }
}

// 判断 整改人和复检人是否为当前登录人 yes-> 添加按钮 no-> 显示文字 整改回复or复检回复
- (void)BasedOnTheStateToAddBut
{
    if (_rectificationstatus.integerValue == 0) {   // 整改回复
        if (_uiId.integerValue == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] integerValue]) {
            [self.QRBut setTitle:@"整改回复" forState:UIControlStateNormal];
            [self.view addSubview:self.QRBut];
        }
    }else if (_rectificationstatus.integerValue == 1) { // 复检回复
        if (_reporter.integerValue == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] integerValue]) {
            [self.QRBut setTitle:@"复检回复" forState:UIControlStateNormal];
            [self.view addSubview:self.QRBut];
        }
    }else { // 完成 添加审批流
        [self loadApproveProcedureDataFromSevers];
    }
}
// 获取现场照片
- (void)loadNowPhotos
{
    [self.getPhotosParas setValue:self.birId forKey:@"piId"];
    [self.getPhotosParas setValue:@"JCBGT" forKey:@"piType"];
    [self requestSeversWithParameters:self.getPhotosParas andIsNowPhotos:YES];
}
// 获取附件图片
- (void)loadPhotos
{
    [self.getPhotosParas setValue:self.birId forKey:@"piId"];
    [self.getPhotosParas setValue:@"JCBG" forKey:@"piType"];
    [self requestSeversWithParameters:self.getPhotosParas andIsNowPhotos:NO];
}

// 获取附件
#pragma mark --现场照片和附件--
- (void)requestSeversWithParameters:(NSMutableDictionary *)parameters andIsNowPhotos:(BOOL)isNow
{
    [self.manager POST:documentsApprove parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"stauts"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                ApproveEnclosureModel *aeModel = [[ApproveEnclosureModel alloc] init];
                [aeModel setValuesForKeysWithDictionary:dic];
                if (isNow) {
                    [self.nowPhotosArr addObject:aeModel];
                }else {
                    [self.photosArr addObject:aeModel];
                }
            }
        }
        if (self.nowPhotosArr.count) {
            if (self.nowPhotosArr.count%3 == 0) {
                _shang = self.nowPhotosArr.count/3;
            }else {
                _shang = (NSInteger)(self.nowPhotosArr.count/3) + 1;
            }
        }
        [self.rectifyTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"访问失败，请重新访问" andTitle:@"提示"];
        }
    }];
}
//  获取审批流程数据
#pragma mark --审批流程--
- (void)loadApproveProcedureDataFromSevers
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:self.birId forKey:@"piId"];
    [parameters setValue:@"JCBG" forKey:@"piType"];
    _url = [NSString stringWithFormat:@"%@?piId=%@&piType=%@",approveProcedureUrl,self.birId,@"JCBG"];
    //    NSLog(@"审批流程url---%@",_url);
    [self.manager POST:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // arvTime arvStatus asrName uiName
        NSArray *arr = responseObject[@"rows"];
        for (NSDictionary *dic1 in arr) {
            ApproveProcedureModel *apModel = [[ApproveProcedureModel alloc] init];
            apModel.arvRemark = dic1[@"arvRemark"];
            apModel.arvStatus = dic1[@"arvStatus"];
            apModel.arvReceivetime = dic1[@"arvReceivetime"];
            apModel.arvTime = dic1[@"arvTime"];
            NSDictionary *dic2 = dic1[@"apApprovalstepreceive"];
            apModel.asrName = dic2[@"asrName"];
            NSDictionary *dic3 = dic1[@"paUserinfo"];
            apModel.uiName = dic3[@"uiName"];
            [self.procedureData addObject:apModel];
        }
        [self.rectifyTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"访问失败，请重新访问" andTitle:@"提示"];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 2) {
        return 50;
    }else if (section == 3) {
        if (self.nowPhotosArr.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }else if (section == 4) {
        if (self.photosArr.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }else if (section == 5) {
        return 10;
    }else if (section == 6) {
        return 0;
    }else if (section == 7) {
        if (self.replyData.count == 0) {        // 整改回复
            return 0;
        }else {
            return 50;
        }
    }else if (section == 8) {
        if (self.procedureData.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }else {
        return 0;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else if (section == 2) {
        return @"检查结果:";
    }else if (section == 3) {
        return @"现场照片";
    }else if (section == 4) {
        return @"附件";
    }else if (section == 5) {
        return @" ";
    }else if (section == 6) {
        return @" ";
    }else if (section == 7) {
        return @"整改回复";
    }else if (section == 8) {
        return @"审批流";
    }else {
        return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {         // 基本数据
        return 5;
    }else if (section == 2) {   // 检查结果
        return 2;
    }else if (section == 3) {   // 现场照片
        return 1;
    }else if (section == 4) {   // 附件
        return self.photosArr.count;
    }else if (section == 5) {   // 整改要求
        return 1;
    }else if (section == 6) {   // 人物
        return 2;
    }else if (section == 7) {   //
        return self.replyData.count;
    }else if (section == 8) {
        if (self.procedureData.count == 0) {
            return 0;
        }else {
            return self.procedureData.count;
        }
    }else if (section == 0) {
        return 1;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRDetailsModel *model = self.dataSource.firstObject;
    if (indexPath.section == 0) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleName.text = @"检查主题";
        if (![model.birTheme isEqual:[NSNull alloc]]) {
            cell.days.text = model.birTheme;
        }
        cell.days.enabled = false;
        return cell;
    }else if (indexPath.section == 1) {
        _name = @[@"项目:",@"性质:",@"日期:",@"检查人:",@"检查项:"];
        _icon = @[@"qc_piname",@"qc_xz",@"qc_time",@"qc_person",@"qc_content"];
        if (indexPath.row != 4) {
            QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = _name[indexPath.row];
            cell.icon.image = [UIImage imageNamed:_icon[indexPath.row]];
            [cell loadQRDetailsDataFromModel:self.dataSource.firstObject andRow:indexPath.row];
            return cell;
        }else {         // 检查项，多行文本
            QCContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcContentCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = _name[indexPath.row];
            cell.icon.image = [UIImage imageNamed:_icon[indexPath.row]];
            cell.passHeightDelegate = self;
            [cell loadQCContentFromDataSource:model.birContent];
            return cell;
        }
    }else if (indexPath.section == 2) { // 检查结果 和 显示按钮
        if (indexPath.row == 0) {
            QCResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcResultCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.passHeightDelegate = self;
            [cell loadQCResultFromDataSource:model.birInspectionresult];
            return cell;
        }else if (indexPath.row == 1) {
            QCStatusButCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcStatusButCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.butName = @[@"通过",@"口头警告",@"书面整改"];
            [cell loadQCStatusFromState:model.birResultstate andUserEnabled:NO];
            return cell;
        }
    }else if (indexPath.section == 3) { // 现场照片
        NowPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nowPhotosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.nowPhotosArr.count) {
            [cell loadNowPhotosFromData:self.nowPhotosArr];
        }
        return cell;
    }else if (indexPath.section == 4) { // 附件
        // 显示审批附件
        ApproveEnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.photosArr.count) {
            [cell referUIWithModel:self.photosArr[indexPath.row]];
            return cell;
        }else {
            return nil;
        }
    }else if (indexPath.section == 5) { // 整改要求
        QRDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qrDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refreshQRDetailsCellWithModel:self.dataSource.firstObject];
        return cell;
    }else if (indexPath.section == 6) { // 人物
        _name = @[@"整改人:",@"完成日期:"];
        QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = _name[indexPath.row];
        cell.icon.image = [UIImage imageNamed:@"qc_person"];
        [cell loadQRPersonDataFromModel:self.dataSource.firstObject andRow:indexPath.row];
        return cell;
    }else if (indexPath.section == 7) { //  整改回复
        ZGGCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zggcCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.rectifyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.passHeightDelegate = self;
        if (indexPath.row %2 == 0) {    // 整改
            [cell refreshZGCellWithModel:self.replyData[indexPath.row]];
        }else {     // 复检
            [cell refreshFJCellWithModel:self.replyData[indexPath.row]];
        }
        
        return cell;
    }else if (indexPath.section == 8) { // 审批流
        // 显示审批流程UI
        ApproveProcedureCell *cell = [[ApproveProcedureCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.rectifyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.isOldDocType = NO;
        cell.passHeightDelegate = self;
        [cell refreAPCellUIWithModel:self.procedureData[indexPath.row]];
        return cell;
    }
    return nil;
}

// 回复信息显示高度
- (void)passHeightFromZGGCCell:(CGFloat)height
{
    _height = height;
}

#pragma mark --passQCContentCellHeight--
- (void)passHeightFromQCContentCell:(CGFloat)height
{
    _height = height;
}
#pragma mark --passQCResultCellHeight--
- (void)passHeightFromQCResultCell:(CGFloat)height
{
    _height = height;
}
#pragma mark --passAPCellHeight--
- (void)passAPCellHeight:(CGFloat)height
{
    _height = height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 4) {
            return _height;
        }else {
            return 44;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return _height;
        }else {
            return 44;
        }
    }else if (indexPath.section == 3) {
        return _shang*((kscreenWidth-40)/3) + (_shang * 10);
    }else if (indexPath.section == 4 || indexPath.section == 5) {
        return 100;
    }else if (indexPath.section == 6) {
        return 44;
    }else if (indexPath.section == 7) {
        return 100+_height;
    }else if (indexPath.section == 8) {
        return _height;
    }else if (indexPath.section == 0) {
        return 50;
    }else {
        return 0;
    }
}

#pragma mark -----ApproveEnclosureCellDelegate-----
- (void)EnclosureCellPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}
@end
