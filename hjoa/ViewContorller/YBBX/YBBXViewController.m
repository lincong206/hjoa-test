//
//  YBBXViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/7/18.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  一般费用报销

#import "YBBXViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "LeaveTypeCell.h"
#import "LeaveDaysCell.h"
#import "AddBXMXCell.h"
#import "LeavePhotoCell.h"
#import "LeaveForApproveCell.h"
#import "PhotosCell.h"
#import "DeleteBXMXCell.h"
#import "SpecialPJTViewController.h"
#import "SubmitView.h"
#import "ApproveEnclosureModel.h"

#import <Photos/Photos.h>
#import "PhotosViewController.h"    // 多附件上传页面
#import "PhotosModel.h"

@interface YBBXViewController () <UITableViewDelegate, UITableViewDataSource, passPickViewFromTypeCell,passPickViewFormLeaveForApproveCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate, passProjectDataFromSpecialPJTVC, passHeightFromLeaveCell, passStepDataFormLeaveCell, passTypeLabelFromTypeCell, UITextFieldDelegate, passApproveIdFromLeaveCell, passSelectPhotos>

@property (weak, nonatomic) IBOutlet UITableView *YBBXTable;
@property (strong, nonatomic) UIImagePickerController *imagePick;
@property (strong, nonatomic) NSMutableArray *photoArr;

@property (assign, nonatomic) NSInteger addSection;
@property (assign, nonatomic) BOOL isAdd;
@property (assign, nonatomic) CGFloat money;
@property (assign, nonatomic) NSString *bigChineseMoney;
@property (assign, nonatomic) NSString *projectId;
@property (assign, nonatomic) NSString *projectName;    // 增加明细中的项目名称

@property (assign, nonatomic) CGFloat approveCellHeight;

// 上传参数
@property (strong, nonatomic) NSString *approveType;   // 审批类型
@property (strong, nonatomic) NSString *approveId;          // 审批流id
@property (strong, nonatomic) NSMutableArray *ybbxStep;     // 审批流数据
@property (strong, nonatomic) NSMutableArray *ybbxPhotos;   // 图片数据
@property (strong, nonatomic) NSString *ybbxType;           // 费用归口参数
@property (strong, nonatomic) NSString *costType;           // 付款方式
@property (strong, nonatomic) NSString *isDeduction;        // 是否抵押
@property (strong, nonatomic) NSString *gePayeeunit;        // 收款单位
@property (strong, nonatomic) NSString *geOpenbank;         // 开户银行
@property (strong, nonatomic) NSString *geBankaccount;      // 银行账户
@property (strong, nonatomic) NSMutableArray *deleteArrM;   // 删除明细中的数据
@property (strong, nonatomic) NSString *ybbxMoney;          // 增加明细中的金额
@property (strong, nonatomic) NSString *ybbxUsed;           // 增加明细中的用途

@property (strong, nonatomic) NSString *pcId;           // 成功申请返回的数据

@end

@implementation YBBXViewController

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

- (NSMutableArray *)ybbxPhotos
{
    if (!_ybbxPhotos) {
        _ybbxPhotos = [NSMutableArray array];
    }
    return _ybbxPhotos;
}

- (NSMutableArray *)ybbxStep
{
    if (!_ybbxStep) {
        _ybbxStep = [NSMutableArray array];
    }
    return _ybbxStep;
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
    // 判断 有些选项不能为空。
    
    //    [self.navigationController popViewControllerAnimated:YES];
}

// 提交
- (void)clickSubmitBut:(UIButton *)sender
{
    self.approveType = @"YBBX";
    //  上传数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //  类型
    [params setObject:self.approveType forKey:@"geIdtype"];
    // 用户姓名
    [params setValue:[user objectForKey:@"uiName"] forKey:@"uiName"];
    //  部门名字
    [params setObject:[user objectForKey:@"uiPsname"] forKey:@"dpName"];
    // 资金使用人
    [params setObject:[user objectForKey:@"uiName"] forKey:@"geFunduse"];
    //  日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    [params setObject:dateTime forKey:@"geCreatetime"];
    //  费用归口
    if (self.ybbxType) {
        [params setObject:self.ybbxType forKey:@"geGui"];
    }else {
        [params setObject:@"" forKey:@"geGui"];
    }
    //  付款方式
    if (self.costType) {
        [params setObject:self.costType forKey:@"gePaytype"];
    }else {
        [params setObject:@"" forKey:@"gePaytype"];
    }
    //  是否抵押
    if (self.isDeduction) {
        [params setObject:self.isDeduction forKey:@"geIsdeduction"];
    }else {
        [params setObject:@"" forKey:@"geIsdeduction"];
    }
    // 收款单位
    if (self.gePayeeunit) {
        [params setObject:self.gePayeeunit forKey:@"gePayeeunit"];
    }else {
        [params setObject:@"" forKey:@"gePayeeunit"];
    }
    // 开户银行
    if (self.geOpenbank) {
        [params setObject:self.geOpenbank forKey:@"geOpenbank"];
    }else {
        [params setObject:@"" forKey:@"geOpenbank"];
    }
    // 银行账户
    if (self.geBankaccount) {
        [params setObject:self.geBankaccount forKey:@"geBankaccount"];
    }else {
        [params setObject:@"" forKey:@"geBankaccount"];
    }
    // 总金额
    [params setObject:[NSString stringWithFormat:@"%.2f",self.money] forKey:@"geTotalmoney"];
    // 总金额大写
    self.bigChineseMoney = [self digitUppercase:[NSString stringWithFormat:@"%.2f",self.money]];
    [params setObject:self.bigChineseMoney forKey:@"geTotalmoneyupper"];
    
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
    [dic1 setObject:self.approveType forKey:@"piType"];
    NSString *nameStr = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    nameStr = [NSString stringWithFormat:@"一般费用报销;编号及名称:YBBX%@null,一般费用报销",nameStr];
    [dic1 setObject:nameStr forKey:@"astDocName"];
    [dic1 setObject:[user objectForKey:@"uiId"] forKey:@"uiId"];
    [dic1 setObject:[NSString stringWithFormat:@"%.2f",self.money] forKey:@"piMoney"];
    [dic setObject:dic1 forKey:@"status"];
    
    //  stepReceives 第二个参数 审批流
    [dic setObject:self.ybbxStep forKey:@"stepReceives"];
    
    //  files 第三个参数 上传图片
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    NSString *fileString = @"";
    // 有数据
    if (self.ybbxPhotos.count == 0) {
        
    }else {
        for (ApproveEnclosureModel *model in self.ybbxPhotos) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:[NSString stringWithFormat:@"empty"] forKey:@"piId"];
            [photos setObject:self.approveType forKey:@"piType"];
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
    
    //  curr    第四个参数  金额明细数据
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    NSMutableDictionary *reson = [NSMutableDictionary dictionary];
    NSString *conString = @"";
    if (self.projectName) {
        [reson setObject:self.projectName forKey:@"piName"];
    }else {
        [reson setObject:@"" forKey:@"piName"];
    }
    if (self.ybbxMoney) {
        [reson setObject:self.ybbxMoney forKey:@"gedMoney"];
    }else {
        [reson setObject:@"" forKey:@"gedMoney"];
    }
    if (self.ybbxUsed) {
        [reson setObject:self.ybbxUsed forKey:@"gedUse"];
    }else {
        [reson setObject:@"" forKey:@"gedUse"];
    }
    [reson setObject:@"" forKey:@"gedRemark"];
    conString = [NSString stringWithFormat:@"%@",reson];
    
    conString = [conString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
    conString = [conString stringByReplacingOccurrencesOfString:@";" withString:@","];
    // 去掉 ， 操作
    NSString *lastString = [conString substringToIndex:conString.length-3];
    conString = [NSString stringWithFormat:@"%@}",lastString];
    
    NSString *st = @"";
    NSString *postStr = @"";
    // 当没有点击增加明细时
    if (self.addSection == 0) {
        
    }else {
        for (NSMutableDictionary *dicM in self.deleteArrM) {
            
            st = [NSString stringWithFormat:@"%@%@!",st,dicM];
        }
        st = [st stringByReplacingOccurrencesOfString:@"=" withString:@":"];
        st = [st stringByReplacingOccurrencesOfString:@";" withString:@","];
        
        NSArray *stArr = [st componentsSeparatedByString:@"!"];
        for (NSString *finaStr in stArr) {
            // 当不为空的时候
            if (![finaStr isEqualToString:@""]) {
                NSString *lastString = [finaStr substringToIndex:finaStr.length-3];
                st = [NSString stringWithFormat:@"%@}",lastString];
                st = [NSString stringWithFormat:@"%@!",st];
                postStr = [NSString stringWithFormat:@"%@%@",postStr,st];
                
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
    if ([self.ybbxType isEqualToString:@""] || self.ybbxType == nil) {
        [self showAlertControllerMessage:@"请选择费用归口" andTitle:@"提示" andIsReturn:NO];
    }else if ([self.costType isEqualToString:@""] || self.costType == nil) {
        [self showAlertControllerMessage:@"请选择付款方式" andTitle:@"提示" andIsReturn:NO];
    }else if ([self.isDeduction isEqualToString:@""] || self.isDeduction == nil) {
        [self showAlertControllerMessage:@"请选择是否抵押" andTitle:@"提示" andIsReturn:NO];
    }else if (self.money == 0) {
        [self showAlertControllerMessage:@"请填写费用金额" andTitle:@"提示" andIsReturn:NO];
    }else if (self.ybbxStep.count == 0) {
        [self showAlertControllerMessage:@"请选择审批流程" andTitle:@"提示" andIsReturn:NO];
    }else {
        
        [manager POST:ybbxUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.projectName = @"";
    
    self.imagePick.delegate = self;
    
    self.addSection = 0;
    self.isAdd = false;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self tableviewRegisterCell];
    
}

- (void)tableviewRegisterCell
{
    [self.YBBXTable registerNib:[UINib nibWithNibName:@"LeaveTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ltypeCell"];
    [self.YBBXTable registerNib:[UINib nibWithNibName:@"LeaveDaysCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ldaysCell"];
    [self.YBBXTable registerNib:[UINib nibWithNibName:@"AddBXMXCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"addCell"];
    [self.YBBXTable registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.YBBXTable registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"photosCell"];
    [self.YBBXTable registerNib:[UINib nibWithNibName:@"LeaveForApproveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lfaCell"];
    [self.YBBXTable registerNib:[UINib nibWithNibName:@"DeleteBXMXCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"deleteCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isAdd) {
        [self.deleteArrM removeAllObjects];
        return 10 + self.addSection;
    }
    return 10;
}

//  段高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2 || section == 3 || section == 4 || section == 5) {
        return 10;
    }
    if (section == 6) {
        return 30;
    }
    if (self.isAdd) {
        if (section == 7+self.addSection) {
            return 30;
        }else if (section == 8+self.addSection) {
            return 0.01;
        }else {
            return 10;
        }
    }else {
        if (section == 6 || section == 7) {
            return 30;
        }else if (section == 8 && self.photoArr.count) {
            return 0.01;
        }
        return 10;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isAdd) {
        if (section == 6) {
            return @"报销内容";
        }else if (section == 7+self.addSection) {
            return [NSString stringWithFormat:@"总金额  %.2f 元",self.money];
        }
        return nil;
    }else {
        if (section == 6) {
            return @"报销内容";
        }else if (section == 7) {
            return [NSString stringWithFormat:@"总金额  %.2f 元",self.money];
        }
        return nil;
    }
}

//  增加段头和段尾
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CGFloat width = tableView.bounds.size.width;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 100, 20)];
//    label.textColor = [UIColor blackColor];
//    label.textAlignment = NSTextAlignmentLeft;
//    label.text = @"报销内容";
//    
//    UIButton *deleteBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    deleteBut.frame = CGRectMake(width*0.9, 8, width*0.1, 20);
//    [deleteBut setTitle:@"删除" forState:UIControlStateNormal];
//    [deleteBut setTintColor:[UIColor blueColor]];
//    
//    if (self.isAdd) {
//        if (section == 6+self.addSection) {
//            [view addSubview:label];
//            [deleteBut addTarget:self action:@selector(clickDeleteBut:) forControlEvents:UIControlEventTouchUpInside];
//            [view addSubview:deleteBut];
//            return view;
//        }
//    }
//    return nil;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark --passHeightFromLeaveCell--
- (void)passHeightFromLeaveCell:(CGFloat)height
{
    _approveCellHeight = height;
    [self.YBBXTable reloadSections:[NSIndexSet indexSetWithIndex:8+self.addSection] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isAdd) {
        if (indexPath.section == 6) {
            return 150;
        }else if (indexPath.section == 9+self.addSection) {
            return _approveCellHeight + 100;
        }else if (indexPath.section == 8+self.addSection) {
            if (self.photoArr.count) {
                return 100;
            }else {
                return 0;
            }
        }else if (indexPath.section == 7+self.addSection) {
            return 50;
        }else if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5) {
            return 50;
        }else {
            return 100;
        }
    }else {
        if (indexPath.section == 6) {
            return 150;
        }else if (indexPath.section == 8) {
            if (self.photoArr.count) {
                return 100;
            }else {
                return 0;
            }
        }else if (indexPath.section == 9) {
            return _approveCellHeight + 100;
        }
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"请选择(必填)",@"工程公司",@"设计公司"];
        cell.pickData = [NSArray arrayWithArray:arr];
        cell.typeName.text = @"费用归口";
        cell.typeCellDelegate = self;
        cell.passTypeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 1) {
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"请选择(必填)",@"转账",@"支票",@"现金",@"回单"];
        cell.pickData = [NSArray arrayWithArray:arr];
        cell.typeName.text = @"付款方式";
        cell.typeCellDelegate = self;
        cell.passTypeDelegate = self;
        return cell;
        
    }else if (indexPath.section == 2) {
        LeaveTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"请选择(必填)",@"抵扣",@"不抵扣",@"非营销人员"];
        cell.pickData = [NSArray arrayWithArray:arr];
        cell.typeName.text = @"是否抵押";
        cell.typeCellDelegate = self;
        cell.passTypeDelegate = self;
        return cell;
        
    }else if (indexPath.section > 2 && indexPath.section < 6) {
        LeaveDaysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ldaysCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *titleArr = @[@"收款单位",@"收户银行",@"银行账号"];
        cell.titleName.text = titleArr[indexPath.section - 3];
        titleArr = @[@"请输入收款单位",@"请输入开户银行",@"请输入银行账号"];
        cell.days.placeholder = titleArr[indexPath.section - 3];
        cell.days.tag = indexPath.section + 200;
        cell.days.delegate = self;
        return cell;
    }else if (indexPath.section == 6) {
        AddBXMXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.money = cell.moneyText.text.floatValue;
        [cell.addBut setTitle:@"增加明细" forState:UIControlStateNormal];
        
        self.ybbxMoney = [NSString stringWithFormat:@"%.2f",cell.moneyText.text.floatValue];
        self.ybbxUsed = cell.usedText.text;
        
        
        [cell.addBut addTarget:self action:@selector(clickAddBut:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        cell.chooseBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        if (self.projectName == nil) {
            [cell.chooseBut setTitle:@"==请选择==" forState:UIControlStateNormal];
        }else {
            [cell.chooseBut setTitle:self.projectName forState:UIControlStateNormal];
        }
        [cell.chooseBut addTarget:self action:@selector(clickChoseBut:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (self.isAdd) {
        if (indexPath.section == 7+self.addSection) {
            LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = @"附件";
            cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
            return cell;
        }else if (indexPath.section == 8+self.addSection) {
            PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.YBBXTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.photoArr.count > 0) {
                [cell loadPhotosData:self.photoArr];
                cell.hidden = NO;
                return cell;
            }else {
                cell.hidden = YES;
                return cell;
            }
        }else if (indexPath.section == 9+self.addSection) {
            LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.type = @"YBBX";
            cell.leaveDelegate = self;
            return cell;
        }else {
            DeleteBXMXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.money += cell.moneyText.text.floatValue;
            
            NSMutableDictionary *mxDicM = [NSMutableDictionary dictionary];
            [mxDicM setObject:[NSString stringWithFormat:@"%.2f",cell.moneyText.text.floatValue] forKey:@"gedMoney"];
            [mxDicM setObject:cell.usedText.text forKey:@"gedUse"];
            [mxDicM setObject:self.projectName forKey:@"piName"];
            [mxDicM setObject:@"" forKey:@"gedRemark"];
            [self.deleteArrM addObject:mxDicM];
            
            [cell.deleteBut setTitle:@"删除明细" forState:UIControlStateNormal];
            [cell.deleteBut addTarget:self action:@selector(clickDeleteBut:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else { //  没有点击增加时的 默认按钮
        if (indexPath.section == 7) {
            LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = @"附件";
            cell.image.image = [UIImage imageNamed:@"adjunct_icon"];
            return cell;
        }else if (indexPath.section == 8) {
            PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.YBBXTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.photoArr.count > 0) {
                [cell loadPhotosData:self.photoArr];
                cell.hidden = NO;
                return cell;
            }else {
                cell.hidden = YES;
                return cell;
            }
        }else if (indexPath.section == 9) {
            LeaveForApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lfaCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.type = @"YBBX";
            cell.leaveDelegate = self;
            cell.passApIdDelegate = self;
            cell.passHeightDelegate = self;
            cell.passStepDataDelegate = self;
            return cell;
        }
    }
    return nil;
}

//  点击增加按钮
- (void)clickAddBut:(UIButton *)sender
{
    self.addSection += 1;
    self.isAdd = true;
    [self.YBBXTable reloadData];
}

//  点击删除按钮
- (void)clickDeleteBut:(UIButton *)sender
{
    if (self.addSection > 0) {
        self.addSection -=1;
        self.isAdd = true;
        [self.YBBXTable reloadData];
    }
}

- (void)clickChoseBut:(UIButton *)sender
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
    self.projectId = model.piId;
    [self.YBBXTable reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark --passApproveIdFromLeaveCell--
- (void)passApproveIdFromLeaveCell:(NSString *)apId
{
    self.approveId = apId;
}

- (void)passStepDataFormLeaveCellWithStepData:(NSMutableArray *)step
{
    self.ybbxStep = step;
}

#pragma mark --passTypeLabelFromTypeCell--
- (void)passTypeLabelFromTypeCell:(NSString *)type
{
    if ([type isEqualToString:@"工程公司"]) {
        self.ybbxType = @"0";
    }else if ([type isEqualToString:@"设计公司"]) {
        self.ybbxType = @"1";
    }else if ([type isEqualToString:@"转账"]) {// @"转账",@"支票",@"现金",@"回单"
        self.costType = @"0";
    }else if ([type isEqualToString:@"支票"]) {
        self.costType = @"1";
    }else if ([type isEqualToString:@"现金"]) {
        self.costType = @"2";
    }else if ([type isEqualToString:@"回单"]) {
        self.costType = @"3";
    }else if ([type isEqualToString:@"抵扣"]) {//@"抵扣",@"不抵扣",@"非营销人员"
        self.isDeduction = @"0";
    }else if ([type isEqualToString:@"不抵扣"]) {
        self.isDeduction = @"1";
    }else if ([type isEqualToString:@"非营销人员"]) {
        self.isDeduction = @"2";
    }else if ([type isEqualToString:@"请选择(必填)"]) {
        self.ybbxType = @"";
        self.costType = @"";
        self.isDeduction = @"";
    }
}

#pragma mark --UITextFieldDelegate--
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag - 200) {
        case 3:
            self.gePayeeunit = textField.text;
            break;
        case 4:
            self.geOpenbank = textField.text;
            break;
        case 5:
            self.geBankaccount = textField.text;
            break;
        default:
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (indexPath.section == 7+self.addSection) {
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
    // 上传图片
    [self upLoadImageWith:img];
    [self.photoArr addObject:img];
    [self.YBBXTable reloadSections:[NSIndexSet indexSetWithIndex:8+self.addSection] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self.YBBXTable reloadSections:[NSIndexSet indexSetWithIndex:8+self.addSection] withRowAnimation:UITableViewRowAnimationAutomatic];
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
                [self.ybbxPhotos addObject:model];
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


#pragma mark --leaveForApproveCellDelegate--
- (void)passPickViewFormLeaveForApproveCell:(UIView *)view
{
    // 上移TableView 显示
    [self.view addSubview:view];
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
