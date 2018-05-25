//
//  RectifySheetViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/3/26.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  修改整改单内容

#import "RectifySheetViewController.h"
#import "Header.h"
#import "AFNetworking.h"

#import "LeaveDaysCell.h"
#import "QCDetailsCell.h"
#import "QCAddNewsCell.h"
#import "QCContentCell.h"
#import "QCResultCell.h"
#import "QCStatusButCell.h"
#import "NowPhotosCell.h"
#import "ApproveEnclosureCell.h"
#import "QCRectifyCell.h"

#import "QCNoticePersonViewController.h"
#import "addressModel.h"

#import "QualityCheckViewController.h"
#import "QualityCheckListViewController.h"

@interface RectifySheetViewController () <UITableViewDelegate, UITableViewDataSource, passQCContentCellHeight, passQCResultCellHeight, passQCAddNewsCellText, passNoticePerson>
{
    NSArray *_name;
    NSArray *_icon;
    CGFloat _height;
    CGFloat _shang;
    NSString *_checkString;     // 整改内容
    NSString *_rectifyName;     // 整改人
    NSString *_rectifyId;       // 整改人id
    NSString *_finishTime;
}
@property (strong, nonatomic) UITableView *rectifyTable;

@property (strong, nonatomic) UIView *pickBackView;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation RectifySheetViewController

- (UIView *)pickBackView
{
    if (!_pickBackView) {
        _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kscreenHeight*0.6, kscreenWidth, kscreenHeight*0.4)];
        _pickBackView.backgroundColor = [UIColor whiteColor];
    }
    return _pickBackView;
}
- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kscreenHeight*0.6 + 30, kscreenWidth, kscreenHeight*0.4 - 30)];
        _datePicker.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        [_datePicker addTarget:self action:@selector(rollAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
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

- (UITableView *)rectifyTable
{
    if (!_rectifyTable) {
        _rectifyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-50) style:UITableViewStylePlain];
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonOnClicked:)];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 生成整改单
- (void)doneButtonOnClicked:(UIButton *)sender
{
//    bsQualityimprovement/save 这个接口  bqiType =ZLZG    birId=页面id   bqiReporter =当前登录人id   uiId =整改人   bqiTime 生成时间  bqiRequire= 整改要求
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    [paras setValue:@"ZLZG" forKey:@"bqiType"];
    [paras setValue:self.birId forKey:@"birId"];
    [paras setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"bqiReporter"];
    if (_rectifyId && _finishTime && _checkString) {
        [paras setValue:_rectifyId forKey:@"uiId"];
        [paras setValue:_finishTime forKey:@"bqiTime"];
        [paras setValue:_checkString forKey:@"bqiRequire"];
        
        [manager POST:creatRectify parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                [self.passStatusDelegate passUpdataStatusWithRSVC:@"success"];
                //  完成返回质量检查列表。手动改变状态
                for (UIViewController *vc in self.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[QualityCheckListViewController class]]) {
                        QualityCheckListViewController *qcListVC = (QualityCheckListViewController *)vc;
                        
                        [self.navigationController popToViewController:qcListVC animated:YES];
                    }
                }
                [self showAlertControllerMessage:@"整改单生成成功" andTitle:@"提示"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error) {
                [self showAlertControllerMessage:@"整改单生成失败，请重新提交" andTitle:@"提示"];
            }
        }];
    }else {
        [self showAlertControllerMessage:@"请填写完整改信息" andTitle:@"提示"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 计算高度 现场照片
    if (self.nowPhotos.count%3 == 0) {
        _shang = self.nowPhotos.count/3;
    }else {
        _shang = (NSInteger)(self.nowPhotos.count/3) + 1;
    }
    
    [self.view addSubview:self.rectifyTable];
    
    [self registCell];
    
    [self addDataPickView];
    
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)addDataPickView
{
    [self.view addSubview:self.pickBackView];
    [self.pickBackView addSubview:self.confirmButton];
    [self.view addSubview:self.datePicker];
    self.pickBackView.hidden = YES;
    self.datePicker.hidden = YES;
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.rectifyTable.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.rectifyTable.contentInset = UIEdgeInsetsZero;
}

- (void)registCell
{
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcDetailsCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCAddNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcAddNewsCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcContentCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCResultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcResultCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCStatusButCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcStatusButCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"ApproveEnclosureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aeCell"];
    [self.rectifyTable registerNib:[UINib nibWithNibName:@"QCRectifyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcRectifyCell"];
}

#pragma mark --tableDelegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 0;
    }else if (section == 2) {
        return 50;
    }else if (section == 3) {
        if (self.nowPhotos.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }else if (section == 4) {
        if (self.dataPhotos.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }else if (section == 5) {
        return 10;
    }else if (section == 6) {
        return 0;
    }else if (section == 7) {
        return 0;
    }else {
        return 0;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else if (section == 1) {
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
        return @" ";
    }else {
        return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {         // 基本数据
        return 5;
    }else if (section == 2) {   // 检查结果
        return 2;
    }else if (section == 3) {   // 现场照片
        return 1;
    }else if (section == 4) {   // 附件
        return self.dataPhotos.count;
    }else if (section == 5) {   // 整改要求
        return 1;
    }else if (section == 6) {   // 人物
        return 2;
    }else if (section == 7) {   // 审批流
        return 0;
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
    }
    else if (indexPath.section == 1) {       // 基本数据
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
        if (self.nowPhotos.count) {
            [cell loadNowPhotosFromData:self.nowPhotos];
        }
        return cell;
    }else if (indexPath.section == 4) { // 附件
        // 显示审批附件
        ApproveEnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataPhotos.count) {
            [cell referUIWithModel:self.dataPhotos[indexPath.row]];
            return cell;
        }else {
            return nil;
        }
    }else if (indexPath.section == 5) { // 整改要求
        QCAddNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcAddNewsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name.text = @"整改要求";
        cell.icon.image = [UIImage imageNamed:@"qc_content"];
        cell.passTextDelegate = self;
        if (_checkString) {
            cell.text.text = _checkString;
        }
        return cell;
        
    }else if (indexPath.section == 6) { // 人物
        _name = @[@"整改人:",@"完成日期:"];
        QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = _name[indexPath.row];
        cell.icon.image = [UIImage imageNamed:@"qc_person"];
        if (indexPath.row == 0) {
            if (_rectifyName) {
                cell.content.text = _rectifyName;
            }else {
                cell.content.text = @"";
            }
        }else if (indexPath.row == 1) {
            if (_finishTime) {
                cell.content.text = _finishTime;
            }else {
                cell.content.text = @"";
            }
        }
        return cell;
    }else if (indexPath.section == 7) { // 审批流
        return nil;
    }
    return nil;
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
    }else if (indexPath.section == 4) {
        return 100;
    }else if (indexPath.section == 5) {
        return 120;
    }else if (indexPath.section == 6) {
        return 44;
    }else if (indexPath.section == 0) {
        return 50;
    }else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 6) {
        if (indexPath.row == 0) {
            QCNoticePersonViewController *noticeP = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"qcNoticePersonVC"];
            noticeP.isSingleSelected = YES;
            noticeP.passPersonDelegate = self;
            [self.navigationController pushViewController:noticeP animated:YES];
        }else {
            self.pickBackView.hidden = NO;
            self.datePicker.hidden = NO;
        }
    }
}

- (void)rollAction:(UIDatePicker *)datePick
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    _finishTime = [formatter stringFromDate:datePick.date];
    [self.rectifyTable reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)cancel:(UIButton *)but
{
    self.pickBackView.hidden = YES;
    self.datePicker.hidden = YES;
}
#pragma mark --passNoticePerson--
- (void)passNoticePersonFromVC:(NSMutableArray *)person
{
    for (addressModel *model in person) {
        _rectifyName = model.uiName;
        _rectifyId = model.uiId;
    }
    [self.rectifyTable reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark --passTextFromQCAddNewsCell--
- (void)passTextFromQCAddNewsCell:(NSString *)text
{
    _checkString = text;
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
