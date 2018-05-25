//
//  CostProjectViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/7/20.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  项目费用报销

#import "CostProjectViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "ApproveEnclosureModel.h"
#import "SpecialPJTViewController.h"
#import "ApproveEnclosureModel.h"
#import "ChooseProjectCell.h"
#import "LeaveTypeCell.h"
#import "LeaveDaysCell.h"
#import "CostListCell.h"
#import "LeavePhotoCell.h"
#import "PhotosCell.h"
#import "LeaveForApproveCell.h"
#import "SubmitView.h"
#import "DeleteBXMXCell.h"

#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"

@interface CostProjectViewController () <UITableViewDelegate, UITableViewDataSource, passProjectDataFromSpecialPJTVC, passPickViewFromTypeCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate, passPickViewFormLeaveForApproveCell, passTypeLabelFromTypeCell, UITextFieldDelegate, passApproveIdFromLeaveCell, passHeightFromLeaveCell, passStepDataFormLeaveCell, passSelectPhotos>

@property (weak, nonatomic) IBOutlet UITableView *costPjtTable;
@property (strong, nonatomic) NSString *projectName;
// 附件
@property (strong, nonatomic) UIImagePickerController *imagePick;
@property (strong, nonatomic) NSMutableArray *photoArr;

@property (assign, nonatomic) CGFloat costMoney;            // 总金额
@property (assign, nonatomic) NSString *bigChineseMoney;

@property (assign, nonatomic) BOOL isAdd;
@property (assign, nonatomic) NSInteger addSection;

@property (strong, nonatomic) NSString *type;   // 付款方式种类
@property (strong, nonatomic) NSString *pjtId;  // 项目id
@property (strong, nonatomic) NSString *payer;  // 付款人
@property (strong, nonatomic) NSString *bankName;  // 银行名字
@property (strong, nonatomic) NSString *bankAccount;  // 银行账号
@property (strong, nonatomic) NSString *approveId;  // 审批流id
// 参数
@property (strong, nonatomic) NSString *approveType;   // 审批类型
@property (strong, nonatomic) NSString *addMoneyString;// 金额
@property (strong, nonatomic) NSString *addCostUser;   // 用途
@property (strong, nonatomic) NSString *addFnote;       // 备注
@property (strong, nonatomic) NSMutableDictionary *DeleteDic;   // 删除明细
@property (strong, nonatomic) NSMutableArray *deleteArrM;
@property (assign, nonatomic) CGFloat approveCellHeight; // 审批高度

@property (strong, nonatomic) NSMutableArray *step;
@property (strong, nonatomic) NSMutableArray *stepPhotoArr;

@property (strong, nonatomic) NSMutableArray *addDeleteBXMXCellContentArr;    // 装删除明细cell中的内容

@property (strong, nonatomic) NSString *pcId;   // 申请成功返回的数据

@end

@implementation CostProjectViewController

- (UIImagePickerController *)imagePick
{
    if (!_imagePick) {
        _imagePick = [UIImagePickerController new];
        _imagePick.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePick.allowsEditing = YES;
    }
    return _imagePick;
}

- (NSMutableArray *)deleteArrM
{
    if (!_deleteArrM) {
        _deleteArrM = [NSMutableArray array];
    }
    return _deleteArrM;
}

- (NSMutableDictionary *)DeleteDic
{
    if (!_DeleteDic) {
        _DeleteDic = [NSMutableDictionary dictionary];
    }
    return _DeleteDic;
}

- (NSMutableArray *)addDeleteBXMXCellContentArr
{
    if (!_addDeleteBXMXCellContentArr) {
        _addDeleteBXMXCellContentArr = [NSMutableArray array];
    }
    return _addDeleteBXMXCellContentArr;
}

- (NSMutableArray *)stepPhotoArr
{
    if (!_stepPhotoArr) {
        _stepPhotoArr = [NSMutableArray array];
    }
    return _stepPhotoArr;
}

- (NSMutableArray *)step
{
    if (!_step) {
        _step = [NSMutableArray array];
    }
    return _step;
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
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBut)];
    SubmitView *submiView = [[SubmitView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 60, kscreenWidth, 60)];
    [submiView.but addTarget:self action:@selector(clickSubmitBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submiView];
}

- (void)clickSaveBut
{
    
}

/*
 10.1.20.27:80/projectCostRsApply/saveAndSubmit?pcType=XMBX&uiName=超级管理员&uiId=1&dpName=IT部&pcCurrency=0&pcCreatedate=2017-07-18&piId=12854&piName=测试联营管理整个流程ERP&pcDepositbalance=0&pcPaymentmethod=0&pcPayee=不高兴&pcBankfullname=中国银行&pcBankaccount=5556655654&pcAmountmoney=5555.0&pcAmountmoneycapital=伍仟伍佰伍拾伍元整&params={}
    params={"status":
            "stepReceives":
            "files":
            "curr":
            }
 */
// 提交
- (void)clickSubmitBut:(UIButton *)sender
{
    self.approveType = @"ZBSPL";
    //   上传数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //  参数拼接
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //  类型
    [params setObject:self.approveType forKey:@"pcType"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    // 用户姓名
    [params setValue:[user objectForKey:@"uiName"] forKey:@"uiName"];
    //  id
    [params setValue:[user objectForKey:@"uiId"] forKey:@"uiId"];
    //  部门名字
    [params setValue:[user objectForKey:@"uiPsname"] forKey:@"dpName"];
    //  币种
    [params setValue:@"zh" forKey:@"pcCurrency"];
    //  日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    [params setValue:dateTime forKey:@"pcCreatedate"];
    //  项目id
    [params setValue:self.pjtId forKey:@"piId"];
    //  项目名称
    [params setValue:self.projectName forKey:@"piName"];
    //  备用金金额
    [params setValue:@"0" forKey:@"pcDepositbalance"];
    //  付款方式
    [params setValue:self.type forKey:@"pcPaymentmethod"];
    //  收款人
    [params setValue:self.payer forKey:@"pcPayee"];
    //  银行
    [params setValue:self.bankName forKey:@"pcBankfullname"];
    //  银行账户
    [params setValue:self.bankAccount forKey:@"pcBankaccount"];
    //  金额
    [params setValue:[NSString stringWithFormat:@"%.2f",self.costMoney] forKey:@"pcAmountmoney"];
    //  金额大写
    self.bigChineseMoney = [self digitUppercase:[NSString stringWithFormat:@"%.2f",self.costMoney]];
    [params setValue:self.bigChineseMoney forKey:@"pcAmountmoneycapital"];
    
    //  params 参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //  status 第一个
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:self.approveId forKey:@"apId"];
    
    [dic1 setValue:@"" forKey:@"piId"];
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"项目费用报销;编号及名称:ZBSPL%@null,项目费用报销",nameStr];
    [dic1 setValue:nameStr forKey:@"astDocName"];
    [dic1 setValue:self.approveType forKey:@"piType"];
    [dic1 setValue:[user objectForKey:@"uiId"] forKey:@"uiId"];
    [dic1 setValue:[NSString stringWithFormat:@"%.2f",self.costMoney] forKey:@"piMoney"];
    [dic setObject:dic1 forKey:@"status"];
    
    //  stepReceives 第二个参数 审批流
    [dic setObject:self.step forKey:@"stepReceives"];
    
    //  files 第三个参数 上传图片
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    NSString *fileString = [[NSString alloc] init];
    // 有数据
    if (self.stepPhotoArr.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.stepPhotoArr) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setValue:model.baiName forKey:@"baiName"];
            [photos setValue:@"" forKey:@"baiState"];
            [photos setValue:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setValue:@"empty" forKey:@"piId"];
            [photos setValue:self.approveType forKey:@"piType"];
            [photos setValue:[user objectForKey:@"uiId"] forKey:@"uiId"];
            [photos setValue:model.baiSubsequent forKey:@"baiSubsequent"];
            [photos setValue:model.baiUrl forKey:@"baiUrl"];
            fileString = [NSString stringWithFormat:@"%@%@!",fileString,photos];
            
            fileString = [fileString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
            fileString = [fileString stringByReplacingOccurrencesOfString:@";" withString:@","];
            NSString *lastString = [fileString substringToIndex:fileString.length-4];
            fileString = [NSString stringWithFormat:@"%@}!",lastString];
        }
    }

    [dic3 setValue:fileString forKey:@"file"];
    [dic setObject:dic3 forKey:@"files"];
    
    //  curr    第四个参数  金额明细数据
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    NSMutableDictionary *reson = [NSMutableDictionary dictionary];
    NSString *conString = @"";
    if (self.addMoneyString) {
        [reson setObject:self.addMoneyString forKey:@"pcFmoney"];
    }else {
        [reson setObject:@"" forKey:@"pcFmoney"];
    }
    if (self.addCostUser) {
        [reson setObject:self.addCostUser forKey:@"pcFcapitaluses"];
    }else {
        [reson setObject:@"" forKey:@"pcFcapitaluses"];
    }
    if (self.addFnote) {
        [reson setObject:self.addFnote forKey:@"pcFnote"];
    }else {
        [reson setObject:@"" forKey:@"pcFnote"];
    }
    
    conString = [NSString stringWithFormat:@"%@",reson];
    
    conString = [conString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
    conString = [conString stringByReplacingOccurrencesOfString:@";" withString:@","];
    NSString *lastString = [conString substringToIndex:conString.length-3];
    conString = [NSString stringWithFormat:@"%@}",lastString];
    
    NSString *st = [[NSString alloc] init];
    NSString *postStr = @"";
    // 当没有点击增加明细时
    if (self.addSection == 0) {
        
    }else {
        for (NSMutableDictionary *dicM in self.deleteArrM) {
            st = [NSString stringWithFormat:@"%@%@!",st,dicM];
        }
        st = [st stringByReplacingOccurrencesOfString:@"=" withString:@":"];
        st = [st stringByReplacingOccurrencesOfString:@";" withString:@","];
        postStr = [NSString stringWithFormat:@"%@%@",postStr,st];

        NSArray *stArr = [st componentsSeparatedByString:@"!"];
        
        for (NSString *finaStr in stArr) {
            // 当不为空的时候
            if (![finaStr isEqualToString:@""]) {
                NSString *lastString = [finaStr substringToIndex:finaStr.length-3];
                st = [NSString stringWithFormat:@"%@}",lastString];
                st = [NSString stringWithFormat:@"%@!",st];
            }
        }
    }
    conString = [NSString stringWithFormat:@"%@!%@",conString,postStr];
    // 转码
    conString = [self logDic:conString];
    [dic4 setObject:conString forKey:@"con"];
    [dic setObject:dic4 forKey:@"curr"];
    
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:paramsStr forKey:@"params"];
    
    // 必填数据
    if ([self.projectName isEqualToString:@""] || self.projectName == nil) {
        [self showAlertControllerMessage:@"请选择项目名称" andTitle:@"提示" andIsReturn:NO];
    }else if ([self.type isEqualToString:@""] || self.type == nil) {
        [self showAlertControllerMessage:@"请选择付款方式" andTitle:@"提示" andIsReturn:NO];
    }else if (self.costMoney == 0) {
        [self showAlertControllerMessage:@"请填写费用金额" andTitle:@"提示" andIsReturn:NO];
    }else if (self.step.count == 0) {
        [self showAlertControllerMessage:@"请选择审批流程" andTitle:@"提示" andIsReturn:NO];
    }else {
        
        [manager POST:projectCostUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                //  成功上传
                self.pcId = responseObject[@"pcId"];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"ChooseProjectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"choosePjtCell"];
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"LeaveTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ltypeCell"];
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"CostListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"costListCell"];
    
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
    
    [self.costPjtTable registerNib:[UINib nibWithNibName:@"DeleteBXMXCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"deleteCell"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isAdd) {
        [self.deleteArrM removeAllObjects];
        return 9 + self.addSection;
    }
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2 || section == 3 || section == 4) {
        return 10;
    }
    if (section == 5) {
        return 30;
    }
    if (self.isAdd) {
        if (section == 6+self.addSection) {
            return 30;
        }
        if (section == 7+self.addSection) {
            return 0.01;
        }
        return 10;
    }else {
        if (section == 6) {
            return 30;
        }
        if (section == 7) {
            return 0.01;
        }
        return 10;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 5) {
        return @"费用明细";
    }
    if (self.isAdd) {
        if (section == 6+self.addSection) {
            return [NSString stringWithFormat:@"总金额 %.2f元",self.costMoney];
        }
    }else {
        if (section == 6) {
            return [NSString stringWithFormat:@"总金额 %.2f元",self.costMoney];
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark --passHeightFromLeaveCell--
- (void)passHeightFromLeaveCell:(CGFloat)height
{
    if (height == 0) {
        _approveCellHeight = height;
    }else {
        _approveCellHeight = height - 50;
    }
    [self.costPjtTable reloadSections:[NSIndexSet indexSetWithIndex:7+self.addSection] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 5) {
        return 50;
    }
    if (indexPath.section == 5) {
        return 150;
    }
    if (self.isAdd) {
        if (indexPath.section ==6+self.addSection) {
            return 50;
        }
        if (indexPath.section == 7+self.addSection) {
            if (self.photoArr.count) {
                return 100;
            }else {
                return 0;
            }
        }
        if (indexPath.section == 8+self.addSection) {
            return _approveCellHeight + 110;
        }
        return 100;
    }else {
        if (indexPath.section == 6) {
            return 50;
        }
        if (indexPath.section == 7) {
            if (self.photoArr.count) {
                return 100;
            }else {
                return 0;
            }
        }
        if (indexPath.section == 8) {
            return _approveCellHeight + 110;
        }
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ChooseProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choosePjtCell" forIndexPath:indexPath];
        cell.chooseBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        cell.chooseBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [cell.chooseBut addTarget:self action:@selector(clickChooseBut:) forControlEvents:UIControlEventTouchUpInside];
        if (self.projectName != nil) {
            [cell.chooseBut setTitle:self.projectName forState:UIControlStateNormal];
        }else {
            [cell.chooseBut setTitle:@"==请选择==" forState:UIControlStateNormal];
        }
        return cell;
    }else if (indexPath.section == 1) {
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"请选择(必填)",@"转账",@"支票",@"现金",@"回单"];
        cell.pickData = [NSArray arrayWithArray:arr];
        cell.typeName.text = @"付款方式";
        cell.passTypeDelegate = self;
        cell.typeCellDelegate = self;
        return cell;
    }else if (indexPath.section > 1 && indexPath.section < 5) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *titleArr = @[@"收款人",@"开户银行",@"银行账户"];
        NSArray *placeholderArr = @[@"请输入收款人",@"请输入开户银行",@"请输入银行账户"];
        cell.titleName.text = titleArr[indexPath.section - 2];
        cell.days.placeholder = placeholderArr[indexPath.section - 2];
        cell.days.tag = indexPath.section + 200;
        cell.days.delegate = self;
        return cell;
    }else if (indexPath.section == 5) {
        CostListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"costListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.addCostBut setTitle:@"增加明细" forState:UIControlStateNormal];
        [cell.addCostBut addTarget:self action:@selector(clickAddMXBut:) forControlEvents:UIControlEventTouchUpInside];
        self.costMoney = cell.costMoneyLabel.text.floatValue;
        self.addMoneyString = [NSString stringWithFormat:@"%.2f",cell.costMoneyLabel.text.floatValue];
        self.addCostUser = cell.costUsedlabel.text;
        self.addFnote = cell.remakeText.text;
        return cell;
    }
    
    if (self.isAdd) {
        if (indexPath.section == 6+self.addSection) {
            LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = @"附件";
            cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
            return cell;
        }else if (indexPath.section == 7+self.addSection) {
            PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.costPjtTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.photoArr.count > 0) {
                [cell loadPhotosData:self.photoArr];
                cell.hidden = NO;
                return cell;
            }else {
                cell.hidden = YES;
                return cell;
            }
        }else if (indexPath.section == 8+self.addSection) {
            LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.type = @"YBBX";
            cell.leaveDelegate = self;
            return cell;
        }else {
            // 当点击增加明细的时候，添加的cell
            DeleteBXMXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            self.costMoney += cell.moneyText.text.floatValue;
            
            NSMutableDictionary *mxDicM = [NSMutableDictionary dictionary];
            [mxDicM setObject:[NSString stringWithFormat:@"%.2f",cell.moneyText.text.floatValue] forKey:@"pcFmoney"];
            [mxDicM setObject:cell.usedText.text forKey:@"pcFcapitaluses"];
            [mxDicM setObject:@"" forKey:@"pcFnote"];
            
            [self.deleteArrM addObject:mxDicM];
            
            [cell.deleteBut setTitle:@"删除明细" forState:UIControlStateNormal];
            [cell.deleteBut addTarget:self action:@selector(clickDeleteMXBut:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else {
        if (indexPath.section == 6) {
            LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = @"附件";
            cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
            return cell;
        }else if (indexPath.section == 7) {
            PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.costPjtTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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
            cell.type = @"XMBX";
            cell.leaveDelegate = self;
            cell.passApIdDelegate = self;
            cell.passHeightDelegate = self;
            cell.passStepDataDelegate = self;
            return cell;
        }
    }
    return nil;
}

#pragma mark --按钮block--
- (void)clickChooseBut:(UIButton *)sender
{
    SpecialPJTViewController *spjtVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SPJTVC"];
    spjtVC.title = @"项目列表";
    spjtVC.delegate = self;
    spjtVC.name = @"xmbx";
    spjtVC.pickData = @[@"负责人",@"项目名称",@"建设单位",@"业绩归属"];
    [self.navigationController pushViewController:spjtVC animated:YES];
}

//  点击增加按钮
- (void)clickAddMXBut:(UIButton *)sender
{
    self.addSection += 1;
    self.isAdd = true;
    [self.costPjtTable reloadData];
}

//  点击删除按钮
- (void)clickDeleteMXBut:(UIButton *)sender
{
    if (self.addSection > 0) {
        self.addSection -=1;
        self.isAdd = true;
        [self.costPjtTable reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 6+self.addSection) {
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
    [self.costPjtTable reloadSections:[NSIndexSet indexSetWithIndex:7+self.addSection] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self.costPjtTable reloadSections:[NSIndexSet indexSetWithIndex:7+self.addSection] withRowAnimation:UITableViewRowAnimationAutomatic];
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

#pragma mark --passProjectDataFromSpecialPJTVC--
- (void)passProjectDataWithModel:(SpecialPJTModel *)model
{
    self.projectName = model.piName;
    self.pjtId = model.piId;
    [self.costPjtTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark --typeCellDelegate--
- (void)passPickBackView:(UIView *)sender andPick:(UIPickerView *)pick
{
    [self.view addSubview:sender];
    [self.view addSubview:pick];
}


#pragma mark --leaveForApproveCellDelegate--
- (void)passPickViewFormLeaveForApproveCell:(UIView *)view
{
    // 上移TableView 显示
    [self.view addSubview:view];
}

#pragma mark --passApproveIdFromLeaveCell--
- (void)passApproveIdFromLeaveCell:(NSString *)apId
{
    self.approveId = apId;
}

#pragma mark --passTypeLabelFromTypeCell--
- (void)passTypeLabelFromTypeCell:(NSString *)type
{
    //@"转账",@"支票",@"现金",@"回单"
    if ([type isEqualToString:@"转账"]) {
        self.type = @"0";
    }else if ([type isEqualToString:@"支票"]) {
        self.type = @"1";
    }else if ([type isEqualToString:@"现金"]) {
        self.type = @"2";
    }else if ([type isEqualToString:@"回单"]) {
        self.type = @"3";
    }else if ([type isEqualToString:@"请选择(必填)"]) {
        self.type = @"";
    }
}

#pragma mark --UITextFieldDelegate--
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag - 200) {
        case 2:
            self.payer = textField.text;
            break;
        case 3:
            self.bankName = textField.text;
            break;
        case 4:
            self.bankAccount = textField.text;
            break;
        default:
            break;
    }
}

#pragma mark --金额转大写--
- (NSString *)digitUppercase:(NSString *)money
{
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    NSArray *MyScale=@[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSMutableString *M=[[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(NSInteger i = moneyStr.length;i>0;i--)
    {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [M appendString:MyBase[MyData]];
        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2)
        {
            [M appendString:@"元整"];
            break;
        }
        [M appendString:MyScale[i-1]];
    }
    return M;
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

// Unicode编码转中文
- (NSString *)logDic:(NSString *)dic {
    if (!dic) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListWithData:tempData
                                              options:NSPropertyListImmutable
                                               format:NULL
                                                error:NULL];
    return str;
}


@end
