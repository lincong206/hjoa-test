//
//  QualityCheckDetailsViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  检查报告->详情

#import "QualityCheckDetailsViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "QCDetailsModel.h"
#import "LeaveDaysCell.h"
#import "QCDetailsCell.h"
#import "QCContentCell.h"
#import "QCResultCell.h"
#import "QCStatusButCell.h"
#import "QCRectifyCell.h"

#import "NowPhotosCell.h"
#import "ApproveEnclosureModel.h"
#import "ApproveEnclosureCell.h"
#import "ApproveProcedureModel.h"
#import "ApproveProcedureCell.h"
#import "RectifySheetViewController.h"

@interface QualityCheckDetailsViewController () <UITableViewDelegate, UITableViewDataSource, passQCContentCellHeight, passQCResultCellHeight, ApproveEnclosureCellDelegate, passAPCellHeight, passUpdataStatus>
{
    NSArray *_name;
    NSArray *_icon;
    CGFloat _height;
    NSString *_url;
    NSInteger _shang;       // 现场照片参数
}
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSMutableDictionary *dataParas;   // 参数
@property (strong, nonatomic) NSMutableDictionary *getPhotosParas;        // 获取图片的参数
@property (strong, nonatomic) NSMutableArray *nowPhotosArr;     // 现场照片
@property (strong, nonatomic) NSMutableArray *photosArr;        // 附件图片
@property (strong, nonatomic) NSMutableArray *procedureData;    // 审批流程

@property (strong, nonatomic) UITableView *qcDetailsTable;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation QualityCheckDetailsViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)nowPhotosArr
{
    if (!_nowPhotosArr) {
        _nowPhotosArr = [NSMutableArray array];
    }
    return _nowPhotosArr;
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
- (UITableView *)qcDetailsTable
{
    if (!_qcDetailsTable) {
        _qcDetailsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-50) style:UITableViewStylePlain];
        _qcDetailsTable.delegate = self;
        _qcDetailsTable.dataSource = self;
        _qcDetailsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _qcDetailsTable;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableDictionary *)dataParas
{
    if (!_dataParas) {
        _dataParas = [NSMutableDictionary dictionary];
    }
    return _dataParas;
}

- (NSMutableDictionary *)getPhotosParas
{
    if (!_getPhotosParas) {
        _getPhotosParas = [NSMutableDictionary dictionary];
    }
    return _getPhotosParas;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"质量检查详情";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.birId) {
        [self.dataParas setObject:self.birId forKey:@"birId"];
        [self loadQCDetailsWithParas:self.dataParas];
    }
    _shang = 0;
    [self loadNowPhotos];
    [self loadPhotos];
    
    // 审批流
    [self loadApproveProcedureDataFromSevers];
    
    [self registCell];
    [self.view addSubview:self.qcDetailsTable];
}

- (void)registCell
{
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"QCDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcDetailsCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"QCContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcContentCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"QCResultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcResultCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"QCStatusButCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcStatusButCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"ApproveEnclosureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aeCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"QCRectifyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcRectifyCell"];
    [self.qcDetailsTable registerNib:[UINib nibWithNibName:@"ApproveProcedureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"apCell"];
}

#pragma mark --获取数据--
- (void)loadQCDetailsWithParas:(NSMutableDictionary *)paras
{
    [self.manager POST:qcDetailsUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                QCDetailsModel *model = [[QCDetailsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:model];
            }
        }else {
            [self showAlertControllerMessage:@"访问失败，请重新访问" andTitle:@"提示"];
        }
        [self.qcDetailsTable reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"访问失败，请重新访问" andTitle:@"提示"];
        }
    }];
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
        [self.qcDetailsTable reloadData];
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
        [self.qcDetailsTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"访问失败，请重新访问" andTitle:@"提示"];
        }
    }];
}

#pragma mark --delegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
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
    }else if (section == 7) {
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
    }else if (section == 7) {
        return @"审批流程";
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
    }else if (section == 3 || section == 6) {   // 现场照片
        return 1;
    }else if (section == 4) {   // 附件
        return self.photosArr.count;
    }else if (section == 5) {   // 人物
        return 1;
    }else if (section == 7) {   // 审批流
        return self.procedureData.count;
    }else if (section == 0) {
        return 1;
    }else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCDetailsModel *model = self.dataSource.firstObject;
    if (indexPath.section == 0) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleName.text = @"检查主题";
        if (![model.birTheme isEqual:[NSNull alloc]]) {
            cell.days.text = model.birTheme;
        }
        cell.days.enabled = false;
        return cell;
    }else if (indexPath.section == 1) {       // 基本数据
        _name = @[@"项目:",@"性质:",@"日期:",@"检查人:",@"检查项:"];
        _icon = @[@"qc_piname",@"qc_xz",@"qc_time",@"qc_person",@"qc_content"];
        if (indexPath.row != 4) {
            QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = _name[indexPath.row];
            cell.icon.image = [UIImage imageNamed:_icon[indexPath.row]];
            [cell loadQCDetailsDataFromModel:self.dataSource.firstObject andRow:indexPath.row];
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
    }else if (indexPath.section == 2) { // 检查结果
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
        cell.ApproveEnclosureCelldelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.photosArr.count) {
            [cell referUIWithModel:self.photosArr[indexPath.row]];
            return cell;
        }else {
            return nil;
        }
    }else if (indexPath.section == 5) { // 人物
        QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"纪录人";
        cell.icon.image = [UIImage imageNamed:@"qc_person"];
        [cell loadQCPersonDataFromModel:self.dataSource.firstObject];
        return cell;
    }else if (indexPath.section == 6) { // 按钮
        QCRectifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcRectifyCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.rectifySheet addTarget:self action:@selector(clickRectifySheet:) forControlEvents:UIControlEventTouchUpInside];
        QCDetailsModel *model = self.dataSource.firstObject;
        if (model.birRectification.integerValue == 0) {
            cell.hidden = NO;
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 7) { // 审批流
        // 显示审批流程UI
        ApproveProcedureCell *cell = [[ApproveProcedureCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.qcDetailsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.isOldDocType = NO;
        cell.passHeightDelegate = self;
        [cell refreAPCellUIWithModel:self.procedureData[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark --clickRectifySheet--
- (void)clickRectifySheet:(UIButton *)sender
{
    RectifySheetViewController *rsVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"rectifySheetVC"];
    rsVC.birId = self.birId;
    rsVC.dataSource = self.dataSource;
    rsVC.dataPhotos = self.photosArr;
    rsVC.nowPhotos = self.nowPhotosArr;
    rsVC.passStatusDelegate = self;
    [self.navigationController pushViewController:rsVC animated:YES];
}

- (void)passUpdataStatusWithRSVC:(NSString *)status
{
    [self.passQCListStatusDelegate passQCListStatusWithQCDetails:status];
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
#pragma mark -----ApproveEnclosureCellDelegate-----
- (void)EnclosureCellPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
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
    }else if (indexPath.section == 4) {
        return 100;
    }else if (indexPath.section == 5 || indexPath.section == 6) {
        return 44;
    }else if (indexPath.section == 7) {
        return _height;
    }else if (indexPath.section == 0) {
        return 50;
    }else {
        return 0;
    }
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
