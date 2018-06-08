//
//  AddQualityCheckViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/2/27.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  新增 质量检查

#import "AddQualityCheckViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "LeaveDaysCell.h"
#import "QCDetailsCell.h"
#import "SpecialPJTViewController.h"
#import "QCAddNewsCell.h"
#import "QCResultStringCell.h"
#import "LeavePhotoCell.h"
#import "PhotosCell.h"
#import "QCStatusButCell.h"
#import "QCRectifyCell.h"
#import "NowPhotosCell.h"

#import "QCNatureViewController.h"
#import "QCNoticePersonViewController.h"

#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"
#import "ApproveEnclosureModel.h"
#import "LeaveForApproveCell.h"

@interface AddQualityCheckViewController () <UITableViewDelegate, UITableViewDataSource, passProjectDataFromSpecialPJTVC, passQCAddNewsCellText, passQCResultStringCellText, passButStatus, UIImagePickerControllerDelegate, UINavigationControllerDelegate, passSelectPhotos, passNature, passApproveIdFromLeaveCell, passPickViewFormLeaveForApproveCell, passStepDataFormLeaveCell, passHeightFromLeaveCell, passLeaveDaysCellText>
{
    NSString *_nameString;
    NSArray *_name;
    NSArray *_icon;
    NSString *_typeName;    // 项目名称
    NSString *_typeId;      // 项目id
    NSString *_time;        // 时间参数
    NSString *_checkString; // 检查项
    NSString *_resultString;    // 检查结果
    NSString *_checkTheme;        // 报告主题
    BOOL _isNow;
    NSString *_nature;          // 性质参数
    NSString *_natureName;          // 性质参数
    NSString *_resultState;     // 结果状态
    NSMutableArray *_step;      // 审批数据
    CGFloat _approveCellHeight; // 审批显示高度
    NSString *_apId;            // 审批id
    NSInteger _shang;
}
@property (strong, nonatomic) UITableView *addQCTable;

@property (strong, nonatomic) UIView *pickBackView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) UIImagePickerController *imagePick;
@property (strong, nonatomic) NSMutableArray *photosArr;
@property (strong, nonatomic) NSMutableArray *upPhotos;     // 上传附件
@property (strong, nonatomic) NSMutableArray *upNowPhotos;     // 上传附件
@property (strong, nonatomic) NSString *pcId;
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation AddQualityCheckViewController

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

- (NSMutableArray *)upPhotos
{
    if (!_upPhotos) {
        _upPhotos = [NSMutableArray array];
    }
    return _upPhotos;
}

- (NSMutableArray *)photosArr
{
    if (!_photosArr) {
        _photosArr = [NSMutableArray array];
    }
    return _photosArr;
}

- (NSMutableArray *)upNowPhotos
{
    if (!_upNowPhotos) {
        _upNowPhotos = [NSMutableArray array];
    }
    return _upNowPhotos;
}

- (UIView *)pickBackView
{
    if (!_pickBackView) {
        _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kscreenHeight*0.6, kscreenWidth, kscreenHeight*0.4)];
        _pickBackView.backgroundColor = [UIColor whiteColor];
    }
    return _pickBackView;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(kscreenWidth -70, 5, 40, 30)];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UITableView *)addQCTable
{
    if (!_addQCTable) {
        _addQCTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight - 50) style:UITableViewStylePlain];
        _addQCTable.delegate = self;
        _addQCTable.dataSource = self;
        _addQCTable.estimatedRowHeight = 0;
        _addQCTable.estimatedSectionHeaderHeight = 0;
        _addQCTable.estimatedSectionFooterHeight = 0;
        _addQCTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _addQCTable;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"新增质量检查";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonOnClicked:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 创建，上传参数
- (void)doneButtonOnClicked:(UIButton *)but
{
    
    [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"0" forKey:@"birRectification"];
    //  检查日期
    if (_time) {
        [params setObject:_time forKey:@"birTime"];
    }else {
        [params setObject:@"" forKey:@"birTime"];
    }
    if (_checkTheme) {
        [params setObject:_checkTheme forKey:@"birTheme"];
    }else {
        [params setObject:@"" forKey:@"birTheme"];
    }
    //  检查报告录入人
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiName"] forKey:@"birEntryperson"];
    //  检查报告内容
    if (_checkString) {
        [params setObject:_checkString forKey:@"birContent"];
    }else {
        [params setObject:@"" forKey:@"birContent"];
    }
    //  项目id
    if (_typeId) {
        [params setObject:_typeId forKey:@"piId"];
    }else {
        [params setObject:@"" forKey:@"piId"];
    }
    //  项目名称
    if (_typeName) {
        [params setObject:_typeName forKey:@"piName"];
    }else {
        [params setObject:@"" forKey:@"piName"];
    }
    //  检查结果
    if (_resultString) {
        [params setObject:_resultString forKey:@"birInspectionresult"];
    }else {
        [params setObject:@"" forKey:@"birInspectionresult"];
    }
    //  结果状态
    if (_resultState) {
        [params setObject:_resultState forKey:@"birResultstate"];
    }else {
        [params setObject:@"" forKey:@"birResultstate"];
    }
    //  检查性质
    if (_nature) {
        [params setObject:_nature forKey:@"birExamined"];
    }else {
        [params setObject:@"" forKey:@"birExamined"];
    }

    
//    NSLog(@"%@",params);
    
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"检查报告审批审批;编号及名称:JCBG%@null,检查报告审批",nameStr];
    [dic1 setObject:nameStr forKey:@"astDocName"];
    [dic1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"uiId"];
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
    NSString *nowString = @"";  // 现场图片
    // 有数据
    if (self.upPhotos.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.upPhotos) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:@"JCBG" forKey:@"piType"];
            [photos setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"uiId"];
            [photos setObject:model.baiSubsequent forKey:@"baiSubsequent"];
            [photos setObject:model.baiUrl forKey:@"baiUrl"];            fileString = [NSString stringWithFormat:@"%@%@!",fileString,photos];
            
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
            [photos setObject:@"JCBGT" forKey:@"piType"];
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
    
    // curr 第四个参数
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"" forKey:@"con"];
    [dic setObject:dic3 forKey:@"curr"];
    
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:paramsStr forKey:@"params"];
    
    if (_time == nil || [_time isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写检查日期" andTitle:@"提示" andIsReturn:NO];
    }else if (_typeName == nil || [_typeName isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请选择项目" andTitle:@"提示" andIsReturn:NO];
    }else {
        [self.manager POST:qcCreatUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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
    
    _nameString = [[NSUserDefaults standardUserDefaults] objectForKey:@"uiName"];

    _shang = 0;
    
    self.imagePick.delegate = self;
    [self.view addSubview:self.addQCTable];
    [self registerCell];
    [self addPickView];
    
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.addQCTable.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.addQCTable.contentInset = UIEdgeInsetsZero;
}

- (void)registerCell
{
    [self.addQCTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"QCDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcDetailsCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"QCAddNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcAddNewsCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"QCResultStringCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcRStingCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"QCStatusButCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcStatusButCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
    [self.addQCTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
}

- (void)addPickView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:self.pickBackView.bounds];
    self.datePicker.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [self.datePicker addTarget:self action:@selector(rollAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.pickBackView addSubview:self.datePicker];
    [self.pickBackView addSubview:self.confirmButton];
    
    self.pickBackView.hidden = YES;
    [self.view addSubview:self.pickBackView];
}

#pragma mark --TableViewDelegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 0;
    }else if (section == 2) {
        return 50;
    }else if (section == 3) {
        if (self.photosArr.count) {
            return 1;
        }else {
            return 10;
        }
    }else if (section == 5) {
        return 5;
    }else if (section == 8) {
        return 10;
    }else {
        return 0;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return @"检查结果:";
    }else {
        return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }else if (section == 2) {
        return 2;
    }else if (section == 0 || section == 3 || section == 4 || section == 5 || section == 6 || section == 7 || section == 8) {
        return 1;
    }else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     
     */
    if (indexPath.section == 0) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleName.text = @"检查主题";
        cell.passTextDelegate = self;
        if (_checkTheme) {
            cell.days.text = _checkTheme;
        }else {
            cell.days.placeholder = @"请输入检查主题";
        }
        return cell;
    } else if (indexPath.section == 1) {       // 基本资料
        _name = @[@"项目:",@"性质:",@"日期:",@"检查人:",@"检查项:"];
        _icon = @[@"qc_piname",@"qc_xz",@"qc_time",@"qc_person",@"qc_content"];
        if (indexPath.row != 4) {
            QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = _name[indexPath.row];
            cell.icon.image = [UIImage imageNamed:_icon[indexPath.row]];
            if (indexPath.row == 0) {
                if (_typeName) {
                    cell.content.text = _typeName;
                }else {
                    cell.content.text = @"";
                }
            }else if (indexPath.row == 1) {
                if (_natureName) {
                    cell.content.text = _natureName;
                }else {
                    cell.content.text = @"";
                }
            }else if (indexPath.row == 2) {
                if (_time) {
                    cell.content.text = _time;
                }else {
                    cell.content.text = @"";
                }
            }else if (indexPath.row == 3) {
                if (_nameString) {
                    cell.content.text = _nameString;
                }else {
                    cell.content.text = @"";
                }
            }
            return cell;
        }else {
            QCAddNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcAddNewsCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name.text = _name[indexPath.row];
            cell.icon.image = [UIImage imageNamed:_icon[indexPath.row]];
            cell.passTextDelegate = self;
            return cell;
        }
    }else if (indexPath.section == 2) {         // 检查结果输入和附件
        if (indexPath.row == 0) {
            QCResultStringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcRStingCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.passTextDelegate = self;
            return cell;
        }else if (indexPath.row == 1) {
            LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = @"附件";
            cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
            return cell;
        }
    }else if (indexPath.section == 3) {         // 附件照片
        PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.photosArr.count) {
            [cell loadPhotosData:self.photosArr];
            return cell;
        }else {
            cell.hidden = YES;
            return cell;
        }
    }else if (indexPath.section == 4) {  // 现场照片
        LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"现场照片";
        cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
        return cell;
    }else if (indexPath.section == 5) {     // 图片显示
        NowPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nowPhotosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.upNowPhotos.count) {
            [cell loadNowPhotosFromData:self.upNowPhotos];
        }
        return cell;
    }
    else if (indexPath.section == 6) {         // 按键
        QCStatusButCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcStatusButCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.butName = @[@"通过",@"口头警告",@"书面整改"];
        cell.passStatusDelegate = self;
        [cell loadQCStatusFromState:_resultState andUserEnabled:YES];
        return cell;
    }else if (indexPath.section == 7) {         // 人物
        QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = @"纪录人";
        cell.icon.image = [UIImage imageNamed:@"qc_person"];
        cell.content.text = _nameString;
        return cell;
    }else if (indexPath.section == 8) {
        LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = @"JCBG";
        cell.leaveDelegate = self;
        cell.passHeightDelegate = self;
        cell.passApIdDelegate = self;
        cell.passStepDataDelegate = self;
        return cell;
    }
    return nil;
}
#pragma mark --passHeightFromLeaveCell--
- (void)passHeightFromLeaveCell:(CGFloat)height
{
    _approveCellHeight = height;
    [self.addQCTable reloadSections:[NSIndexSet indexSetWithIndex:7] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row != 4) {
            return 44;
        }else {
            return 120;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 120;
        }else if (indexPath.row == 1) {
            return 50;
        }
    }else if (indexPath.section == 3) {
        if (self.photosArr.count) {
            return 100;
        }else {
            return 0;
        }
    }else if (indexPath.section == 4) {
        return 50;
    }else if (indexPath.section == 5) {
        return _shang*((kscreenWidth-40)/3) + (_shang * 10);
    }else if (indexPath.section == 6) {
        return 44;
    }else if (indexPath.section == 7) {
        return 44;
    }else if (indexPath.section == 8) {
        return _approveCellHeight + 80;
    }else if (indexPath.section == 0) {
        return 50;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SpecialPJTViewController *spjtVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SPJTVC"];
            spjtVC.title = @"项目列表";
            spjtVC.delegate = self;
            spjtVC.name = @"jcbg";
            spjtVC.pickData = @[@"负责人",@"项目名称",@"建设单位",@"业绩归属"];
            [self.navigationController pushViewController:spjtVC animated:YES];
        }else if (indexPath.row == 1) {     // 选择性质
            QCNatureViewController *natureVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"qcNatureVC"];
            natureVC.passNatureDelegate = self;
            [self.navigationController pushViewController:natureVC animated:YES];
        }else if (indexPath.row == 2) {     // 选择时间
            [self chooseTime];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 1) {           // 附件
            _isNow = false;
            [self creatAlertController];
        }
    }else if (indexPath.section == 4) {
        _isNow = true;
        [self creatAlertController];
    }
}

#pragma mark --检查主题--
- (void)passLeaveDaysCellWithText:(NSString *)text
{
    _checkTheme = text;
}
#pragma mark --性质选择--
- (void)passNatureFromVC:(NSString *)nature andCount:(NSString *)count
{
    _natureName = nature;
    _nature = count;
    [self.addQCTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark --项目选择--
- (void)passProjectDataWithModel:(SpecialPJTModel *)model
{
    _typeName = model.bpcName;
    _typeId = model.piId;
    [self.addQCTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark --时间选择--
- (void)chooseTime
{
    self.pickBackView.hidden = NO;
}
- (void)rollAction:(UIDatePicker *)datePick
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    _time = [formatter stringFromDate:datePick.date];
    [self.addQCTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)cancel:(UIButton *)but
{
    self.pickBackView.hidden = YES;
}
#pragma mark --passTextFromQCAddNewsCell--
- (void)passTextFromQCAddNewsCell:(NSString *)text
{
    _checkString = text;
}
#pragma mark --passTextFromQCResultStringCell--
- (void)passTextFromQCResultStringCell:(NSString *)text
{
    _resultString = text;
}
#pragma mark --passButStatus--
- (void)passButStatus:(NSString *)status andButTag:(NSInteger)tag
{
    _resultState = [NSString stringWithFormat:@"%ld",(long)tag-100];
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
        for (UIImage *image in selectArr) {
            [self upLoadImageWith:[self scaleImage:image ToWidth:1200] isNow:YES];
        }
        
    }else {         // 附件
        self.photosArr = selectArr;
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
    [self.photosArr addObject:img];
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
                [self.upPhotos addObject:model];
            }
        }
        if ([responseObject[@"status"] isEqualToString:@"yes"]) {
            [self showAlertControllerMessage:@"上传成功" andTitle:@"提示" andIsReturn:NO];
            if (isNow) {
                [self.addQCTable reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationAutomatic];
            }else {
                [self.addQCTable reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
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
