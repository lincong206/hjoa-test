//
//  ClickApproveViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/30.
//  Copyright © 2017年 huajian. All rights reserved.
//

/**
 点击审批列表弹出的界面
 */

#import "ClickApproveViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "ClickApproveModel.h"
#import "ApproveUICell.h"
#import "ApproveProcedureModel.h"
#import "ApproveProcedureCell.h"
#import "ApproveIdeaCell.h"
#import "ApproveButView.h"
#import "ApproveEnclosureCell.h"
#import "ApproveEnclosureModel.h"
#import "ApprovalOpinionsViewController.h"

// model
// 一般申请
#import "YBBXModel.h"
#import "TBBHAndXMBHModel.h" //
#import "HTYYModel.h"
#import "SWWJAndGCLWJModel.h" //
#import "YBJKSQModel.h"
#import "WTSModel.h"
#import "JSXModel.h"
#import "XMKZModel.h"
#import "FPSJModel.h"
#import "JYCWZLModel.h"
#import "YHKHModel.h"
#import "LWFBHTModel.h"
#import "LWHTModel.h"
// 项目相关申请
#import "XMBXModel.h"
#import "XMBZJModel.h"
#import "TXMBZJModel.h"
#import "ZBDLModel.h"
// 市场经营
#import "XMModel.h"
#import "XMYSModel.h"
#import "TBBZJModel.h"
#import "TTBBZJModel.h"
#import "SGModel.h"
#import "XMFZRModel.h"
#import "ZMSModel.h"
#import "BSJJModel.h"
#import "XMTBPSModel.h"
#import "BXMX.h"
#import "xmProjectModel.h"
#import "YCGZModel.h"
// 联营管理
#import "XMZJSQModel.h"
#import "WJZModel.h"
#import "LKDJModel.h"
#import "BFHQDModel.h"
#import "LWFKModel.h"
#import "XMDFModel.h"
#import "JKBXModel.h"
#import "JKSQModel.h"
#import "LWandCLModel.h"
// 公文申请
#import "CCSPModel.h"
#import "YZHSModel.h"
#import "CFSPModel.h"
#import "GCYWCCModel.h"
#import "IDQXModel.h"
#import "IDZKModel.h"
#import "QJModel.h"
#import "RSXQModel.h"
#import "SBGJJModel.h"
#import "PXSPModel.h"
#import "JSJSBModel.h"
#import "WPModel.h"
#import "WPDHModel.h"
#import "ERPLCBGModel.h"
#import "JSCYLYModel.h"
#import "HTSPModel.h"
#import "JDModel.h"
#import "YWCCModel.h"
#import "MPModel.h"
#import "YPSGModel.h"
#import "RSLHModel.h"
#import "YZWCModel.h"
#import "ZKModel.h"
#import "DKBKSQModel.h"

#import "ZBModel.h"
#import "FWGZModel.h"
#import "HYJYModel.h"
#import "CLCGFKModel.h"
#import "CLFKModel.h"
#import "CGHTModel.h"
#import "HTBGModel.h"
#import "BCHTModel.h"
#import "TBCHModel.h"
#import "JCBGModel.h"
#import "DAMModel.h"

#import "ZYLKModel.h"
#import "LWJDKModel.h"
#import "LWJSKModel.h"
#import "KPModel.h"
#import "KPListModel.h"
#import "SPModel.h"
#import "SPListModel.h"
#import "NKDJModel.h"

// Cell
#import "XMTableViewCell.h"
#import "TBBHAndXMBHCell.h"
#import "HTYYCell.h"
#import "SWWJAndGCLWJCell.h"
#import "XMBZJCell.h"
#import "TXMBZJCell.h"
#import "TBBZJCell.h"
#import "TTBBZJCell.h"
#import "FPSJCell.h"
#import "YBBXCell.h"
#import "JSXCell.h"
#import "WTSCell.h"
#import "YBJKSQCell.h"
#import "XMFZRCell.h"
#import "XMKZCell.h"
#import "BXMXCell.h"
#import "XMYSCell.h"
#import "XMProjectCell.h"
#import "ZMSCell.h"
#import "SGCell.h"
#import "SJCell.h"
#import "BSJJCell.h"
#import "XMTBPSCell.h"
#import "JYCWZLCell.h"
#import "XMBXCell.h"
#import "XMBX.h"//
#import "XMZJSQCell.h"
#import "WJZCell.h"
#import "LKDJCell.h"
#import "BFHQDCell.h"
#import "LWFKCell.h"
#import "XMDFCell.h"
#import "JKBXCell.h"
#import "JKSQCell.h"
#import "LWandCLCell.h"
#import "LKDJ.h"
#import "BFHQDForCostCell.h"
#import "HQDForRepaymentCell.h"
#import "YHKHCell.h"
#import "ZBDLCell.h"
#import "DKBKSQCell.h"
#import "YXBBCell.h"

#import "CCSPCell.h"
#import "CFSPCell.h"
#import "ERPLCBGCell.h"
#import "GCYWCCCell.h"
#import "HTSPCell.h"
#import "IDQXCell.h"
#import "IDZKCell.h"
#import "JDCell.h"
#import "JSCYLYCell.h"
#import "JSJSBCell.h"
#import "MPCell.h"
#import "RSXQCell.h"
#import "RSLHCell.h"
#import "PXSPCell.h"
#import "SBGJJCell.h"
#import "QJCell.h"
#import "WPDHMCell.h"
#import "WPCell.h"
#import "YPSGCell.h"
#import "YWCCCell.h"
#import "YZHSCell.h"
#import "YZWCCell.h"
#import "ZKCell.h"
#import "YCGZCell.h"

#import "ZBCell.h"
#import "FWGZCell.h"
#import "FWGZ.h"
#import "HYJYCell.h"
#import "CLCGFKCell.h"
#import "CLFKCell.h"
#import "CGHTCell.h"
#import "HTBGCell.h"
#import "BCHTCell.h"
#import "BCHT.h"
#import "TBCHCell.h"
#import "TBCH.h"
#import "JCBGCell.h"
#import "DAMCell.h"
#import "LWFBHTCell.h"
#import "LWHTCell.h"

#import "ZYLKCell.h"
#import "NowPhotosCell.h"
#import "LWJDKCell.h"
#import "LWJSKCell.h"
#import "KPCell.h"
#import "KPListCell.h"
#import "SPCell.h"
#import "SPListCell.h"
#import "NKDJCell.h"

@interface ClickApproveViewController () <UITableViewDelegate, UITableViewDataSource, changeApproveHeightDelegate, passButStatuDelegate, ApproveEnclosureCellDelegate, passHeightFromXMCell, passTBBHAndXMBHCellHeight, passHTYYCellHeight, passSWWJAndGCLWJCellHeight, passXMBZJCellHeight,passTXMBZJCellHeight, passTBBZJCellHeight, passTTBBZJCellHeight, passFPSJCellHeight, passYBBXCellHeight,passJSXCellHeight, passWTSCellHeight, passYBJKSQCellHeight, passXMFZRCellHeight, passXMKZCellHeight,passZMSCellHeight, passBSJJCellHeight, passXMTBPSHeight, passJYCWZLCellHeight, passXMBXCellHeight,passXMZJSQCellHeight,passWJZCellHeight,passLKDJCellHeight, passBFHQDCellHeight,passLWFKCellHeight, passXMDFCellHeight, passJKBXCellHeight, passJKSQCellHeight, passLwClCellHeight, passLKCellHeight, passCostCellHeight, passCCSPCellHeight, passYZHSCellHeight, passCFSPCellHeight, passGCYWCCCellHeight, passIDQXCellHeight, passIDZKCellHeight, passQJCellHeight, passRSXQCellHeight, passSBGJJCellHeight, passPXSPCellHeight, passJSJSBCellHeight, passWPCellHeight, passWPDHMCellHeight, passERPLCBGCellHeight, passJSCYLYCellHeight, passHTSPCellHeight, passJDCellHeight, passYWCCCellHeight, passMPCellHeight, passYPSGCellHeight, passRSLHCellHeight, passYZWCCellHeight, passZBCellHeight, passFWGZCellHeight, passSGCellHeight, passSJCellHeight, passHYJYCellHeight, passCLCGFKCellHeight, passCGHTCellHeight, passXMYSCellHeight, passHTBGCellHeight, passBCHTCellHeight, passBCHTHeight, passFWGZHeight, passTBCHCellHeight, passTBCHHeight, passYHKHHeight, passBXMXHeight, passAPCellHeight, refreApproveCellStatus, passZBDLHeight, passDKBKSQHeight, passJCBGHeight, passDAMHeight, passZYLKCellHeight, passYCGZCellHeight, passLWFBHTHeight, passLWJDKCellHeight, passLWJSKCellHeight, passKPCellHeight, passSPCellHeight, passLWHTHeight, passNKDJCellHeight>
{
    NSDictionary *_paras;       // 材料
    NSString *_url;
    NSString *_urlParameter1 ;
    NSString *_urlParameter2;
    NSString *_urlParameter3;
    NSInteger _shang; // 计算九宫格高度参数
}
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIView *activityView;
@property (strong, nonatomic) NSMutableArray *data;         // TableView 数据源
@property (strong, nonatomic) NSArray *titleArr;        // 左边文字数据
@property (strong, nonatomic) UITableView *ApproveTable;
@property (strong, nonatomic) NSArray *docType;
@property (assign, nonatomic) BOOL isType;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat bkHeight;
@property (strong, nonatomic) NSMutableArray *procedureData;    // 审批流程UI数据源
@property (assign, nonatomic) BOOL isLoad;// 有些数据丢失时，整个界面显示空白 后面审批都不显示
@property (strong, nonatomic) NSMutableArray *butData;    // 审批按钮UI数据源
@property (assign, nonatomic) BOOL isSlide;                 // 判断table是否滑动到了底部

@property (strong, nonatomic) NSMutableArray *EnclosureData;    // 审批附件数据源

@property (strong, nonatomic) NSMutableArray *itemized;         //  一般报销的明细数据
@property (strong, nonatomic) NSMutableArray *xmProject;         //  项目负责人曾经做过的项目

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) ApprovalOpinionsViewController *aoVC;
@property (strong, nonatomic) ApproveButView *ABView;
@property (strong, nonatomic) NSString *mctId;          // 预付款明细参数
@property (assign, nonatomic) NSInteger butStatus;
@property (strong, nonatomic) NSMutableArray *nowPhotos;    // 现场照片，九宫格显示

@end

@implementation ClickApproveViewController

- (NSMutableArray *)nowPhotos
{
    if (!_nowPhotos) {
        _nowPhotos = [NSMutableArray array];
    }
    return _nowPhotos;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activityView = [[UIView alloc] initWithFrame:self.view.bounds];
        _activityView.backgroundColor = [UIColor clearColor];
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.center = self.view.center;
        _activity.backgroundColor = [UIColor clearColor];
        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
        if ([_activity isAnimating]) {   //获取状态 ，0 NO 表示正在旋转，1 YES 表示没有旋转。
            _activityView.hidden = YES;
        }else {
            _activityView.hidden = NO;
        }
        [_activityView addSubview:_activity];
        [self.view addSubview:_activityView];
    }
    return _activity;
}

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSArray array];
    }
    return _titleArr;
}

- (NSMutableArray *)procedureData
{
    if (!_procedureData) {
        _procedureData = [NSMutableArray array];
    }
    return _procedureData;
}

- (NSMutableArray *)butData
{
    if (!_butData) {
        _butData = [NSMutableArray array];
    }
    return _butData;
}

- (NSMutableArray *)EnclosureData
{
    if (!_EnclosureData) {
        _EnclosureData = [NSMutableArray array];
    }
    return _EnclosureData;
}

- (NSMutableArray *)itemized
{
    if (!_itemized) {
        _itemized = [NSMutableArray array];
    }
    return _itemized;
}

- (NSMutableArray *)xmProject
{
    if (!_xmProject) {
        _xmProject = [NSMutableArray array];
    }
    return _xmProject;
}

- (NSArray *)docType
{
    if (!_docType) {
        _docType = @[@"YZHS", @"CFSP", @"GCYWCC", @"GCXMXC", @"QJSQ",
                     @"RSXQ", @"SBGJJ", @"CCSP", @"PXSP", @"JSJSBSQ",
                     @"IDZKSQ", @"IDQXSQ", @"YPSG", @"RSLH", @"YZWCSQ",
                     @"JDSQ", @"YWCC", @"MPSQ",@"HTSP", @"WPSQ",
                     @"WPDHSQ", @"ERPLCBG", @"JSCYLY"];
    }
    return _docType;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.tabBarController.tabBar.hidden = YES;
//    true 左边审批界面   false 右边申请界面
    if (self.isSelect) {
        if (self.model.arvStatus.integerValue == 1 || self.model.arvStatus.integerValue == 8) {
            _ABView = [[ApproveButView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 55, kscreenWidth, 55)];
            _ABView.Omodel = self.model;
            _ABView.passButStatuDelegate = self;
            [self.view addSubview:_ABView];
            self.isSlide = YES;
        }
    }
}

#pragma mark ----按钮的代理----
// 确定按钮
- (void)passButStatus:(NSString *)status
{
    ApprovalOpinionsViewController *aoVC = [[ApprovalOpinionsViewController alloc] init];
    if ([status isEqualToString:@"延审"]) {
        aoVC.inputText.text = @"请输入延审意见(必填)";
        
    }else {
        aoVC.inputText.text = @"请输入审批意见(非必填)";
    }
    aoVC.refreCellDelegate = self;
    aoVC.butName = status;
    aoVC.Omodel = self.model;
    [self.navigationController pushViewController:aoVC animated:YES];
}

// 传递按钮的状态码
- (void)refreApproveCellStatus:(NSInteger)status
{
    [self.passStatusDelegate passApproveStatus:status];
}

//- (void)pushAOViewController:(ApprovalOpinionsViewController *)aoVC andButStatus:(NSString *)status
//{
//    self.aoVC = aoVC;
//    self.status = status;
////    NSLog(@"aoVC---%@,status---%@",[self.aoVC class],self.status);
//    self.aoVC.butName = self.status;
//    [self.navigationController pushViewController:self.aoVC animated:YES];
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.activity startAnimating];
    _activityView.hidden = NO;
    
    _ApproveTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kscreenWidth, kscreenHeight-64-56) style:UITableViewStylePlain];
    _ApproveTable.delegate = self;
    _ApproveTable.dataSource = self;
    _ApproveTable.estimatedRowHeight = 0;
    _ApproveTable.estimatedSectionHeaderHeight = 0;
    _ApproveTable.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_ApproveTable];
    
    // 申明Cell
    [self declareTableViewCell];
    
    [self startMonitorNetWork];
    
    [self.ApproveTable reloadData];
    
}

#pragma mark ----注册cell----
- (void)declareTableViewCell
{
    // 审批流程Cell
    [_ApproveTable registerNib:[UINib nibWithNibName:@"ApproveProcedureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"apCell"];
    // 审批附件Cell
    [_ApproveTable registerNib:[UINib nibWithNibName:@"ApproveEnclosureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aeCell"];
    // 九宫格显示图片
    [_ApproveTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
    // XM   Cell                                // 项目立项
    if ([_model.piType isEqualToString:@"XM"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmCell"];
    }
    // TBBHAndXMBH  Cell                        // 投标保函  项目保函
    if ([_model.piType isEqualToString:@"TBBH"] || [_model.piType isEqualToString:@"XMBH"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"TBBHAndXMBHCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"txCell"];
    }
    // HTYY Cell
    if ([_model.piType isEqualToString:@"HTYY"]) {  // 合同用印
        [_ApproveTable registerNib:[UINib nibWithNibName:@"HTYYCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"htyyCell"];
    }
    // SWWJAndGCLWJ Cell                            // 工程 商务 用印
    if ([_model.piType isEqualToString:@"SWWJ"] || [_model.piType isEqualToString:@"GCLWJ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"SWWJAndGCLWJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"sgCell"];
    }
    // XMBZJ    Cell
    if ([_model.piType isEqualToString:@"XMBZJ"]) { // 项目保证金
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMBZJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmbzjCell"];
    }
    // TXMBZJ   Cell
    if ([_model.piType isEqualToString:@"TXMBZJ"]) { // 退项目保证金
        [_ApproveTable registerNib:[UINib nibWithNibName:@"TXMBZJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"txmbzjCell"];
    }
    // TBBZJ    Cell
    if ([_model.piType isEqualToString:@"TBBZJ"]) { // 投标保证金
        [_ApproveTable registerNib:[UINib nibWithNibName:@"TBBZJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tbbzjCell"];
    }
    // TTBBZJ   Cell
    if ([_model.piType isEqualToString:@"TTBBZJ"]) { // 退投标保证金
        [_ApproveTable registerNib:[UINib nibWithNibName:@"TTBBZJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ttbbzjCell"];
    }
    // FPSJ     Cell
    if ([_model.piType isEqualToString:@"FPSJ"]) { //发票/收据申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"FPSJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fpsjCell"];
    }
    // YBBX     Cell
    if ([_model.piType isEqualToString:@"YBBX"]) { //一般报销
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YBBXCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ybbxCell"];
    }
    // JSX      Cell                                //一般介绍信  介绍信
    if ([_model.piType isEqualToString:@"YBJSX"] || [_model.piType isEqualToString:@"JSX"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JSXCell.h" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jsxCell"];
    }
    // WTS      Cell
    if ([_model.piType isEqualToString:@"WTS"]) { //一般委托书
        [_ApproveTable registerNib:[UINib nibWithNibName:@"WTSCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"wtsCell"];
    }
    // YBJKSQ   Cell
    if ([_model.piType isEqualToString:@"YBJKSQ"]) { //  一般借款申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YBJKSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ybjksqCell"];
    }
    // XMFZR    Cell
    if ([_model.piType isEqualToString:@"XMFZR"]) { //   项目负责人
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMFZRCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmfzrCell"];
    }
    // XMKZ     Cell
    if ([_model.piType isEqualToString:@"XMKZ"]) { //    项目刻章
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMKZCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmkCell"];
    }
    // BXMX      Cell
    if ([_model.piType isEqualToString:@"YBBX"]) { //一般报销
        [_ApproveTable registerNib:[UINib nibWithNibName:@"BXMXCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bxmxCell"];
    }
    // XMFZR      Cell
    if ([_model.piType isEqualToString:@"XMFZR"]) { //项目负责人
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMProjectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmpCell"];
    }
    // ZMS      Cell
    if ([_model.piType isEqualToString:@"ZMS"]) { // 法人授权证明书
        [_ApproveTable registerNib:[UINib nibWithNibName:@"ZMSCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"zmsCell"];
    }
    // SG      Cell
    if ([_model.piType isEqualToString:@"SG"]) { // 施工合同
        [_ApproveTable registerNib:[UINib nibWithNibName:@"SGCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"sgCell"];
    }
    // SJ      Cell
    if ([_model.piType isEqualToString:@"SJ"]) { // 设计合同
        [_ApproveTable registerNib:[UINib nibWithNibName:@"SJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"sjCell"];
    }
    // BSJJ      Cell
    if ([_model.piType isEqualToString:@"BSJJ"]) { // 投标交接查询
        [_ApproveTable registerNib:[UINib nibWithNibName:@"BSJJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bsjjCell"];
    }
    // XMTBPS      Cell
    if ([_model.piType isEqualToString:@"XMTBPS"]) { // 项目投标评审
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMTBPSCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmtbpsCell"];
    }
    // JYCWZL      Cell
    if ([_model.piType isEqualToString:@"JYCWZL"]) { // 借阅财务资料申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JYCWZLCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jycwzlCell"];
    }
    // XMBX      Cell
    if ([_model.piType isEqualToString:@"XMBX"]) { // 项目费用报销申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMBXCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmbxCell"];
    }
    // XMBX      Cell
    if ([_model.piType isEqualToString:@"XMBX"]) { // 项目费用报销申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMBX" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmbx"];
    }
    // XMZJSQ      Cell
    if ([_model.piType isEqualToString:@"XMZJSQ"]) { // 项目资金申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMZJSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmzjsqCell"];
    }
    // WJZ      Cell
    if ([_model.piType isEqualToString:@"WJZ"]) { // 外经证申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"WJZCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"wjzCell"];
    }
    // 营联
    // LKDJ     Cell
    if ([_model.piType isEqualToString:@"LKDJ"]) { // 来款登记
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LKDJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lkdjCell"];
    }
    // BFHQD    cell
    if ([_model.piType isEqualToString:@"BK"]) { // 拨付会签单管理
        [_ApproveTable registerNib:[UINib nibWithNibName:@"BFHQDCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bfhqdCell"];
    }
    // LWFK     Cell
    if ([_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"QTFK"]) { // 劳务付款管理    材料付款    其他付款
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LWFKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lwfkCell"];
        // LWandCL     Cell
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LWandCLCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lwclCell"];
    }
    // JKSQ    Cell
    if ([_model.piType isEqualToString:@"JKSQ"]) { // 项目借款申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JKSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jksqCell"];
    }
    // JKBX     Cell
    if ([_model.piType isEqualToString:@"JKBX"]) { // 借款报销申请
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JKBXCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jkbxCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMBX" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmbx"];
    }
    // XMDF     Cell
    if ([_model.piType isEqualToString:@"XMDF"]) { // 项目代付管理
        [_ApproveTable registerNib:[UINib nibWithNibName:@"XMDFCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xmdfCell"];
    }
    
    if ([_model.piType isEqualToString:@"LKDJ"]) { // 来款登记
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LKDJ" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lkdj"];
    }
    if ([_model.piType isEqualToString:@"BK"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"BFHQDForCostCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"costCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"HQDForRepaymentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"repayCell"];
    }
    // HYJY     Cell
    if ([_model.piType isEqualToString:@"HYJY"]) { // 会议纪要
        [_ApproveTable registerNib:[UINib nibWithNibName:@"HYJYCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"hyjyCell"];
    }
    // 周报
    if ([_model.piType isEqualToString:@"ZBSPL"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"ZBCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"zbCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
    }
    // 法务跟踪
    if ([_model.piType isEqualToString:@"FWGZ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"FWGZCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fwgzCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"FWGZ" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fwgz"];
    }
    // 材料付款 材料预付款
    if ([_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"CLCGFKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"clcgfkCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"CLFKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"clfkCell"];
    }
    // 材料合同
    if ([_model.piType isEqualToString:@"CGHT"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"CGHTCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cghtCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"CLFKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"clfkCell"];
    }
    
    // 施工/设计合同 变更
    if ([_model.piType isEqualToString:@"HTBG"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"HTBGCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"htbgCell"];
    }
    // 施工/设计合同 补充
    if ([_model.piType isEqualToString:@"BCHT"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"BCHTCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bchtCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"BCHT" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bcht"];
    }
    
    // 投标策划
    if ([_model.piType isEqualToString:@"TBCH"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"TBCHCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tbchCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"TBCH" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tbch"];
    }
    // 银行开户
    if ([_model.piType isEqualToString:@"YHKH"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YHKHCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"yhkhCell"];
    }
    // 招标代理
    if ([_model.piType isEqualToString:@"ZBDL"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"ZBDLCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"zbdlCell"];
    }
    // 打卡补卡申请
    if ([_model.piType isEqualToString:@"DKBKSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"DKBKSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"dkbksqCell"];
    }
    
    // 公文申请
    //出差
    if ([_model.piType isEqualToString:@"CCSP"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"CCSPCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ccspCell"];
    }
    //印章回收审批
    if ([_model.piType isEqualToString:@"YZHS"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YZHSCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"yzhsCell"];
    }
    //处罚审批
    if ([_model.piType isEqualToString:@"CFSP"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"CFSPCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cfspCell"];
    }
    //工程业务出差审批 工程项目巡查出差审批
    if ([_model.piType isEqualToString:@"GCYWCC"] || [_model.piType isEqualToString:@"GCXMXC"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"GCYWCCCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"gcywccCell"];
    }
    //ID门禁卡权限申请审批流程
    if ([_model.piType isEqualToString:@"IDQXSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"IDQXSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"idqxCell"];
    }
    //ID门禁卡制卡申请审批流程
    if ([_model.piType isEqualToString:@"IDZKSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"IDZKSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"idzksCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"ZKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"zkCell"];
    }
    //请假申请
    if ([_model.piType isEqualToString:@"QJSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"QJSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qjCell"];
    }
    //人事人力需求
    if ([_model.piType isEqualToString:@"RSXQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"RSXQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"rsxqCell"];
    }
    //社保及公积金缴纳
    if ([_model.piType isEqualToString:@"SBGJJ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"SBGJJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"sbgjjCell"];
    }
    //培训申请流程
    if ([_model.piType isEqualToString:@"PXSP"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"PXSPCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"pxspCell"];
    }
    //计算机设备申请
    if ([_model.piType isEqualToString:@"JSJSBSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JSJSBSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jsjsbCell"];
    }
    //外派人员申请审批流程
    if ([_model.piType isEqualToString:@"WPSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"WPSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"wpCell"];
    }
    //外派人员调回申请审批流程
    if ([_model.piType isEqualToString:@"WPDHSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"WPDHSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"wpdhCell"];
    }
    //ERP流程变更申请表
    if ([_model.piType isEqualToString:@"ERPLCBG"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"ERPLCBGCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"erpCell"];
    }
    //酒水茶叶领用审批
    if ([_model.piType isEqualToString:@"JSCYLY"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JSCYLYCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jscyCell"];
    }
    //合同审批流程
    if ([_model.piType isEqualToString:@"HTSP"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"HTSPCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"htspCell"];
    }
    //接待申请
    if ([_model.piType isEqualToString:@"JDSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JDSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jdCell"];
    }
    //业务出差审批流程
    if ([_model.piType isEqualToString:@"YWCC"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YWCCCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ywccCell"];
    }
    //名片申请审批流程
    if ([_model.piType isEqualToString:@"MPSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"MPSQCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mpCell"];
    }
    //用品申购表申请表单
    if ([_model.piType isEqualToString:@"YPSG"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YPSGCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ypCell"];
    }
    //人事落户申请审批流程
    if ([_model.piType isEqualToString:@"RSLH"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"RSLHCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"rslhCell"];
    }
    //印章外出使用申请
    if ([_model.piType isEqualToString:@"YZWCSQ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YZWCCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"yzwcCell"];
    }
    //报表
    if ([_model.piType isEqualToString:@"YXBB"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YXBBCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"yxbbCell"];
    }
    // 检查报告
    if ([_model.piType isEqualToString:@"JCBG"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"JCBGCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"jcbgCell"];
    }
    // 检查报告
    if ([_model.piType isEqualToString:@"DAM"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"DAMCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"damCell"];
    }
    // 项目管控 -> 收款详情
    if ([_model.piType isEqualToString:@"ZYLK"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"ZYLKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"zylkCell"];
    }
    // 负责人违规
    if ([_model.piType isEqualToString:@"YCGZ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"YCGZCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ycgzCell"];
    }
    // 劳务合同
    if ([_model.piType isEqualToString:@"LWFBHT"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LWFBHTCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lwfbhtCell"];
    }
    // 劳务合同 (营联)
    if ([_model.piType isEqualToString:@"LWHT"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LWHTCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lwhtCell"];
    }
    // 劳务进度款
    if ([_model.piType isEqualToString:@"LWJDK"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LWJDKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lwjdkCell"];
    }
    // 劳务结算款
    if ([_model.piType isEqualToString:@"LWJSK"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"LWJSKCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lwjskCell"];
    }
    // 开票
    if ([_model.piType isEqualToString:@"KP"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"KPCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"kpCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"KPListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"kpListCell"];
    }
    // 收票
    if ([_model.piType isEqualToString:@"SPGL"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"SPCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"spCell"];
        [_ApproveTable registerNib:[UINib nibWithNibName:@"SPListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"spListCell"];
    }
    // 诺款登记
    if ([_model.piType isEqualToString:@"NKDJ"]) {
        [_ApproveTable registerNib:[UINib nibWithNibName:@"NKDJCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nkdjCell"];
    }
}

// 检查网络状态
- (void)startMonitorNetWork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果有网络:
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            // 旧公文
//            [self getViewDataFromSevers];
            // 新公文
            [self loadDataFromSevers];
            // 获取审批流程数据
            [self loadApproveProcedureDataFromSevers];
            // 获取审批附件数据
            [self loadApproveEnclosureDataFromSevers];
        }else {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"无网络状态" andTitle:@"提示" andIsPre:YES];
        }
    }];
}

// 判断类型，生成不同的url去获取数据 旧公文(弃用)
- (void)getViewDataFromSevers
{
    // 公文
    NSString *modelType = [NSString stringWithFormat:@"%@",_model.piType];
    for (NSString *type in self.docType) {
        if ([type isEqualToString:modelType]) {
            self.isType = true;
            break;
        }
        else {
            self.isType = false;
        }
    }
    if (self.isType) {
        _url = [NSString stringWithFormat:@"%@?drId=%@",docData,_model.piId];
        // 请求docType网络数据
        [self loadDocTypeViewDataWithUrl:_url];
    }else {
        //项目预审
        if ([_model.piType isEqualToString:@"XMYS"]) {
            [self loadXMYS];
        }else if ([_model.piType isEqualToString:@"TBCH"]) {
            [self loadTBCH];
        }else {
            //  获取项目负责人 曾完成的代表项目
            if ([_model.piType isEqualToString:@"XMFZR"]) {
                [self loadProjectManagerHistorical];
            }
            // 材料付款明细
            if ([_model.piType isEqualToString:@"CLCGFK"]) {
                [self loadPayForMaterialDetails];
            }
        
            [self loadGeneralTypeViewDataWithUrl:[self getGeneralUrl]];
        }
    }
}

// 获取数据 (新的)
- (void)loadDataFromSevers
{
    self.isType = false;
    //  获取项目负责人 曾完成的代表项目
    if ([_model.piType isEqualToString:@"XMFZR"]) {
        [self loadProjectManagerHistorical];
    }
    // 当有接口的时候，才请求
    if (![_model.piType isEqualToString:@"YXBB"]) {
        [self loadGeneralTypeViewDataWithUrl:[self getGeneralUrl]];
    }
    
    //项目预审
    if ([_model.piType isEqualToString:@"XMYS"]) {
        [self loadXMYS];
    }else if ([_model.piType isEqualToString:@"TBCH"]) {//投标策划
        [self loadTBCH];
    }else if ([_model.piType isEqualToString:@"YXBB"]) {
        self.isLoad = true;
    }
    
}

//投标策划
- (void)loadTBCH
{
    _url = [NSString stringWithFormat:@"%@/bsProjectinfo/findInfoAndEnrollAndPreAndPlot?typeString=touBiaoCeHua&piId=%@",intranetURL,_model.piId];
    [self.manager POST:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject[@"status"] isEqualToString:@"success"]) {
            [self.activity stopAnimating];
            [self showAlertControllerMessage:@"该数据已不存在" andTitle:@"提示" andIsPre:NO];
            _ABView.hidden = YES;
            self.isLoad = false;
        }else {
            self.isLoad = true;
            // 主要数据
            NSDictionary *dic = responseObject[@"rows"];
            TBCHModel *model = [[TBCHModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.data addObject:model];
            // 表格数据
            NSDictionary *bsProjectbidplot = responseObject[@"rows"][@"bsProjectbidplot"];
            TBCHModel *tbch = [[TBCHModel alloc] init];
            [tbch setValuesForKeysWithDictionary:bsProjectbidplot];
            [self.itemized addObject:model];
        }
        [self.ApproveTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _ABView.hidden = YES;
        [self showAlertControllerMessage:@"数据丢失" andTitle:@"提示" andIsPre:NO];
    }];
}

// 先获取项目预审的参数，再请求数据
- (void)loadXMYS
{
    _url = [NSString stringWithFormat:@"%@/bsProjectPre/findpiIdByppId?ppId=%@",intranetURL,_model.piId];
    
    [self.manager POST:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.mctId = responseObject[@"result"];
        if (self.mctId) {
            [self loadGeneralTypeViewDataWithUrl:[self getGeneralUrl]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertControllerMessage:@"访问出错" andTitle:@"提示" andIsPre:NO];
    }];
}

// 获取generalType子系列的url 每一个都不一样
#pragma mark ----获取url----
- (NSString *)getGeneralUrl
{
    if ([_model.piType isEqualToString:@"XM"]) {    // 项目立项
        _urlParameter1 = @"bsProjectinfo";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"piId";
    }else if ([_model.piType isEqualToString:@"TBBH"] || [_model.piType isEqualToString:@"XMBH"]) {// 投标保函  项目保函
        _urlParameter1  = @"oaGuaranteeApply";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"gaId";
    }else if ([_model.piType isEqualToString:@"HTYY"]) {    // 合同用印
        _urlParameter1  = @"oaContract";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"ybId";
    }else if ([_model.piType isEqualToString:@"SWWJ"] || [_model.piType isEqualToString:@"GCLWJ"]) {// 工程 商务 用印
        _urlParameter1  = @"oaBuseiness";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"swId";
    }else if ([_model.piType isEqualToString:@"XMBZJ"]) {   // 项目保证金
        _urlParameter1  = @"bsProjectDeposit";
        _urlParameter2 = @"findBypdId";
        _urlParameter3 = @"pdId";
    }else if ([_model.piType isEqualToString:@"TXMBZJ"]) {  // 退项目保证金
        _urlParameter1  = @"bsProjectDepositReturn";
        _urlParameter2 = @"findBypdrId";
        _urlParameter3 = @"pdrId";
    }else if ([_model.piType isEqualToString:@"TBBZJ"]) {   // 投标保证金
        _urlParameter1  = @"bsBidDeposit";
        _urlParameter2 = @"findBybpId";
        _urlParameter3 = @"bpId";
    }else if ([_model.piType isEqualToString:@"TTBBZJ"]) {  // 退投标保证金
        _urlParameter1  = @"bsBidDepositReturn";
        _urlParameter2 = @"findBybdrId";
        _urlParameter3 = @"bdrId";
    } else if ([_model.piType isEqualToString:@"FPSJ"]) { //发票/收据申请
        _urlParameter1  = @"oaBillAndReceipt";
        _urlParameter2 = @"findBytrId";
        _urlParameter3 = @"trId";
    } else if ([_model.piType isEqualToString:@"YBBX"]) { //一般报销
        _urlParameter1  = @"oaGeneralExpenses";
        _urlParameter2 = @"findBygeId";
        _urlParameter3 = @"geId";
    } else if ([_model.piType isEqualToString:@"YBJSX"] || [_model.piType isEqualToString:@"JSX"]) { //一般介绍信  介绍信
        _urlParameter1  = @"bsProjectreference";
        _urlParameter2 = @"findBprById";
        _urlParameter3 = @"bprId";
    } else if ([_model.piType isEqualToString:@"WTS"]) { //一般委托书
        _urlParameter1  = @"oaMandate";
        _urlParameter2 = @"findByenId";
        _urlParameter3 = @"enId";
    } else if ([_model.piType isEqualToString:@"YBJKSQ"]) { //  一般借款申请
        _urlParameter1  = @"oaGeneralBorrow";
        _urlParameter2 = @"findBygbId";
        _urlParameter3 = @"gbId";
    } else if ([_model.piType isEqualToString:@"XMFZR"]) { //   项目负责人
        _urlParameter1  = @"bsProjectManager";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"pmId";
    } else if ([_model.piType isEqualToString:@"XMKZ"]) { //    项目刻章
        _urlParameter1  = @"oaStampApply";
        _urlParameter2 = @"findBystId";
        _urlParameter3 = @"stId";
    } else if ([_model.piType isEqualToString:@"ZMS"]) { // 法人授权证明书
        _urlParameter1  = @"BsProjectcertificate";
        _urlParameter2 = @"findBpcById";
        _urlParameter3 = @"bpcId";
    } else if ([_model.piType isEqualToString:@"SG"] || [_model.piType isEqualToString:@"SJ"]) { // 设计合同管理 施工合同管理
        _urlParameter1  = @"bsProjectcontract";
        _urlParameter2 = @"finById";
        _urlParameter3 = @"bpcId";
    } else if ([_model.piType isEqualToString:@"BSJJ"]) { // 投标交接查询
        _urlParameter1  = @"bsBidhandover";
        _urlParameter2 = @"findInfoById";
        _urlParameter3 = @"pbjId";
    } else if ([_model.piType isEqualToString:@"XMTBPS"]) { // 项目投标评审
        _urlParameter1  = @"bsBiddingEvaluation";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"beId";
    } else if ([_model.piType isEqualToString:@"JYCWZL"]) { // 借阅财务资料申请
        _urlParameter1  = @"oaBorrowFinanceData";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"bfdId";
    } else if ([_model.piType isEqualToString:@"XMBX"]) { // 项目费用报销申请
        _urlParameter1  = @"projectCostRsApply";
        _urlParameter2 = @"queryById";
        _urlParameter3 = @"pcId";
    } else if ([_model.piType isEqualToString:@"XMZJSQ"]) { // 项目资金申请
        _urlParameter1  = @"ProjectMoneyApply";
        _urlParameter2 = @"prIdById";
        _urlParameter3 = @"prId";
    } else if ([_model.piType isEqualToString:@"WJZ"]) { // 外经证申请
        _urlParameter1  = @"oaBusinessapply";
        _urlParameter2 = @"findBybaId";
        _urlParameter3 = @"baId";
    } else if ([_model.piType isEqualToString:@"LKDJ"]) { // 来款登记
        _urlParameter1  = @"rsPayeeRecord";
        _urlParameter2 = @"findByprId";
        _urlParameter3 = @"prId";
    } else if ([_model.piType isEqualToString:@"BK"]) { // 拨付会签单管理
        _urlParameter1  = @"rsAppropriationRecord";
        _urlParameter2 = @"findByarId";
        _urlParameter3 = @"arId";
    } else if ([_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"QTFK"]) { // 劳务付款管理    材料付款    其他付款
        _urlParameter1 = @"rsPayLabourMaterialOther";
        _urlParameter2 = @"findByploId";
        _urlParameter3 = @"ploId";
    } else if ([_model.piType isEqualToString:@"JKSQ"]) { // 项目借款申请
        _urlParameter1 = @"rsProjectBorrowerApply";
        _urlParameter2 = @"findBypbaId";
        _urlParameter3 = @"pbaId";
    } else if ([_model.piType isEqualToString:@"JKBX"]) { // 借款报销申请
        _urlParameter1 = @"rsProjectBorrowErexpense";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"pbeId";
    } else if ([_model.piType isEqualToString:@"XMDF"]) { // 项目代付管理
        _urlParameter1 = @"rsProjectAnotherpay";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"papId";
    } else if ([_model.piType isEqualToString:@"FWGZ"]) { //法务跟踪
        _urlParameter1 = @"oaLawtailFowller";
        _urlParameter2 = @"selectAllByltfId";
        _urlParameter3 = @"ltfId";
    } else if ([_model.piType isEqualToString:@"HYJY"]) { //会议纪要
        _urlParameter1 = @"oaMeetingService";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"msId";
    } else if ([_model.piType isEqualToString:@"ZBSPL"]) {  //  周报
        _urlParameter1 = @"PaWeekly";
        _urlParameter2 = @"queryByWkIdDpe";
        _urlParameter3 = @"wkId";
    } else if ([_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"]) { //材料付款 材料预付款
        _urlParameter1  = @"mcMaterialPayment";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"mpId";
    } else if ([_model.piType isEqualToString:@"CGHT"]) { //材料合同    (申请零星材料付款)
        _urlParameter1  = @"mcMaterialContract";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"mctId";
    } else if ([_model.piType isEqualToString:@"XMYS"]) { //项目预审
        _urlParameter1  = @"bsProjectPre";
        _urlParameter2 = @"findPreAndEnrollAndInfo";
        _urlParameter3 = @"piId";
    }else if ([_model.piType isEqualToString:@"HTBG"]) {  //施工/设计 合同变更
        _urlParameter1  = @"bsProjectContractAlter";
        _urlParameter2 = @"finById";
        _urlParameter3 = @"pcaId";
    }else if ([_model.piType isEqualToString:@"BCHT"]) {  //施工/设计 合同补充
        _urlParameter1  = @"bsProjectContractSupply";
        _urlParameter2 = @"finById";
        _urlParameter3 = @"pcsId";
    }else if ([_model.piType isEqualToString:@"YHKH"]) {  //银行开户
        _urlParameter1  = @"oaOpenAccount";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"baId";
    }else if ([_model.piType isEqualToString:@"ZBDL"]) {  //招标代理
        _urlParameter1  = @"bsBidagency";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"bpaId";
    }else if ([_model.piType isEqualToString:@"DKBKSQ"]) {  //打卡补卡申请
        _urlParameter1  = @"caCardApplication";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"caId";
    }else if ([_model.piType isEqualToString:@"JCBG"]) {  //检查报告
        _urlParameter1  = @"bsInspectionreport";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"birId";
    }else if ([_model.piType isEqualToString:@"WDJC"]) {  //文档借阅
        _urlParameter1  = @"paRecordMy";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"rfmId";
    }else if ([_model.piType isEqualToString:@"YCGZ"]) {  //负责人违规情况
        _urlParameter1  = @"paPartnerAnomalyTail";
        _urlParameter2 = @"findAllInfo";
        _urlParameter3 = @"pagId";
    }
    else if ([_model.piType isEqualToString:@"CCSP"]) { //出差
        _urlParameter1 = @"oaDocEvectionApprove";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"deaId";
    } else if ([_model.piType isEqualToString:@"YZHS"]) { //印章回收审批
        _urlParameter1  = @"oaDocsealRecycle";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dsrId";
    } else if ([_model.piType isEqualToString:@"CFSP"]) { //处罚审批
        _urlParameter1  = @"oaDocpunishApprove";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dpaId";
    } else if ([_model.piType isEqualToString:@"GCYWCC"] || [_model.piType isEqualToString:@"GCXMXC"]) { //工程业务出差审批 工程项目巡查出差审批
        _urlParameter1  = @"oaDocpbe";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dpbeId";
    } else if ([_model.piType isEqualToString:@"IDQXSQ"]) { //ID门禁卡权限申请审批流程
        _urlParameter1  = @"oaDocIdjeg";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"dijeId";
    } else if ([_model.piType isEqualToString:@"IDZKSQ"]) { //ID门禁卡制卡申请审批流程
        _urlParameter1  = @"oaDocIdceg";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"diceId";
    } else if ([_model.piType isEqualToString:@"QJSQ"]) { //请假申请
        _urlParameter1  = @"oaDocleaveApply";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dlaId";
    } else if ([_model.piType isEqualToString:@"RSXQ"]) { //人事人力需求
        _urlParameter1  = @"oaDocpmd";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dpmdId";
    } else if ([_model.piType isEqualToString:@"SBGJJ"]) { //社保及公积金缴纳
        _urlParameter1  = @"oaDocsssaaf";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dssaId";
    } else if ([_model.piType isEqualToString:@"PXSP"]) { //培训申请流程
        _urlParameter1  = @"oaDocTrainApply";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dtaId";
    } else if ([_model.piType isEqualToString:@"JSJSBSQ"]) { //计算机设备申请
        _urlParameter1  = @"oaDocComputerea";
        _urlParameter2 = @"selectById";
        _urlParameter3 = @"dceaId";
    } else if ([_model.piType isEqualToString:@"WPSQ"]) { //外派人员申请审批流程
        _urlParameter1  = @"oaDocEaa";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"deaaId";
    } else if ([_model.piType isEqualToString:@"WPDHSQ"]) { //外派人员调回申请审批流程
        _urlParameter1  = @"oaDocEara";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"dearId";
    } else if ([_model.piType isEqualToString:@"ERPLCBG"]) { //ERP流程变更申请表
        _urlParameter1  = @"oaDocErpFlowca";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"defcaId";
    } else if ([_model.piType isEqualToString:@"JSCYLY"]) { //酒水茶叶领用审批
        _urlParameter1  = @"oaDocDrinksTeaRegister";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"ddtrId";
    } else if ([_model.piType isEqualToString:@"HTSP"]) { //合同审批流程
        _urlParameter1  = @"oaDocContractApprove";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"dcaId";
    } else if ([_model.piType isEqualToString:@"JDSQ"]) { //接待申请
        _urlParameter1  = @"OaDocReceptionApply";
        _urlParameter2 = @"query";
        _urlParameter3 = @"draId";
    } else if ([_model.piType isEqualToString:@"YWCC"]) { //业务出差审批流程
        _urlParameter1  = @"OaDocBea";
        _urlParameter2 = @"query";
        _urlParameter3 = @"dbeaId";
    } else if ([_model.piType isEqualToString:@"MPSQ"]) { //名片申请审批流程
        _urlParameter1  = @"OaDocBca";
        _urlParameter2 = @"query";
        _urlParameter3 = @"dbcaId";
    } else if ([_model.piType isEqualToString:@"YPSG"]) { //用品申购表申请表单
        _urlParameter1  = @"OaDocGoodsapplybuy";
        _urlParameter2 = @"query";
        _urlParameter3 = @"dgabId";
    } else if ([_model.piType isEqualToString:@"RSLH"]) { //人事落户申请审批流程
        _urlParameter1  = @"OaDocPsa";
        _urlParameter2 = @"query";
        _urlParameter3 = @"dpsaId";
    } else if ([_model.piType isEqualToString:@"YZWCSQ"]) { //印章外出使用申请
        _urlParameter1  = @"OaDocSgoua";
        _urlParameter2 = @"query";
        _urlParameter3 = @"dsgaId";
    }
    else if ([_model.piType isEqualToString:@"ZYLK"]) { //付款详情
        _urlParameter1 = @"rsSelfPayeeRecord";
        _urlParameter2 = @"findBysprId";
        _urlParameter3 = @"sprId";
    } else if ([_model.piType isEqualToString:@"LWFBHT"]) { // 劳务合同
        _urlParameter1 = @"rsLabourcontract";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"rlcId";
    } else if ([_model.piType isEqualToString:@"LWHT"]) { // 劳务合同 (营联)
        _urlParameter1 = @"rsServiceContract";
        _urlParameter2 = @"findById";
        _urlParameter3 = @"laId";
    } else if ([_model.piType isEqualToString:@"LWJDK"]) { // 劳务进度款
        _urlParameter1 = @"rsLabourpayment";
        _urlParameter2 = @"findByIdInfo";
        _urlParameter3 = @"rlpId";
    } else if ([_model.piType isEqualToString:@"LWJSK"]) { // 劳务结算款
        _urlParameter1 = @"rsLaboursetpayment";
        _urlParameter2 = @"findByIdInfo";
        _urlParameter3 = @"rspId";
    } else if ([_model.piType isEqualToString:@"KP"]) { // 开票
        _urlParameter1 = @"fnOpenInvoice";
        _urlParameter2 = @"findByoiIdInfo";
        _urlParameter3 = @"oiId";
    } else if ([_model.piType isEqualToString:@"SPGL"]) { // 收票
        _urlParameter1 = @"fnOpenInvoice";
        _urlParameter2 = @"findByBillInfo";
        _urlParameter3 = @"oiId";
    } else if ([_model.piType isEqualToString:@"NKDJ"]) { // 诺款登记
        _urlParameter1 = @"rsEmbezzleMoneyRecord";
        _urlParameter2 = @"findByemId";
        _urlParameter3 = @"emId";
    }

    _url = [NSString stringWithFormat:@"%@/%@/%@?%@=%@",intranetURL,_urlParameter1,_urlParameter2,_urlParameter3,_model.piId];
    return _url;
}

#pragma mark --model--
// 请求generalType网络数据
- (void)loadGeneralTypeViewDataWithUrl:(NSString *)url
{
//    NSLog(@"%@",url);
    if ([_model.piType isEqualToString:@"XMYS"]) {
        url = [url componentsSeparatedByString:@"="].firstObject;
        url = [NSString stringWithFormat:@"%@=%@&page=1&rows=15",url,self.mctId];
    }
    
    [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject[@"rows"]);
        if (![responseObject[@"status"] isEqualToString:@"success"]) {
            [self.activity stopAnimating];
            [self showAlertControllerMessage:@"该数据已不存在" andTitle:@"提示" andIsPre:NO];
            _ABView.hidden = YES;
            self.isLoad = false;
        }else {
            self.isLoad = true;
            /*  提取控件信息
             1、先判断是一般申请中的哪个类型
             2、创建不同的Model载装数据
             */
            if ([responseObject[@"status"] isEqualToString:@"success"]) {
                if ([_model.piType isEqualToString:@"XM"]) {
                    NSArray *arr = responseObject[@"rows"];
                    for (NSDictionary *dic in arr) {
                        XMModel *xm = [[XMModel alloc] init];
                        [xm setValuesForKeysWithDictionary:dic];
                        [self.data addObject:xm];
                    }
                    
                }else if ([_model.piType isEqualToString:@"TBBH"] || [_model.piType isEqualToString:@"XMBH"]) {
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        TBBHAndXMBHModel *TXModel = [[TBBHAndXMBHModel alloc] init];
                        [TXModel setValuesForKeysWithDictionary:dic];
                        [self.data addObject:TXModel];
                    }
                }else if ([_model.piType isEqualToString:@"HTYY"]) {
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        HTYYModel *htyy = [[HTYYModel alloc] init];
                        [htyy setValuesForKeysWithDictionary:dic];
                        [self.data addObject:htyy];
                    }
                }else if ([_model.piType isEqualToString:@"SWWJ"] || [_model.piType isEqualToString:@"GCLWJ"]) {
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        SWWJAndGCLWJModel *sgModel = [[SWWJAndGCLWJModel alloc] init];
                        [sgModel setValuesForKeysWithDictionary:dic];
                        [self.data addObject:sgModel];
                    }
                }else if ([_model.piType isEqualToString:@"XMBZJ"]) {
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMBZJModel *xmbzj = [[XMBZJModel alloc] init];
                        [xmbzj setValuesForKeysWithDictionary:dic];
                        [self.data addObject:xmbzj];
                    }
                }else if ([_model.piType isEqualToString:@"TXMBZJ"]) {
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        TXMBZJModel *txmbzj = [[TXMBZJModel alloc] init];
                        [txmbzj setValuesForKeysWithDictionary:dic];
                        [self.data addObject:txmbzj];
                    }
                }else if ([_model.piType isEqualToString:@"TBBZJ"]) {
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        TBBZJModel *tbbzj = [[TBBZJModel alloc] init];
                        [tbbzj setValuesForKeysWithDictionary:dic];
                        [self.data addObject:tbbzj];
                    }
                }else if ([_model.piType isEqualToString:@"TTBBZJ"]) {
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        TTBBZJModel *ttbbz = [[TTBBZJModel alloc] init];
                        [ttbbz setValuesForKeysWithDictionary:dic];
                        [self.data addObject:ttbbz];
                    }
                } else if ([_model.piType isEqualToString:@"FPSJ"]) { //发票/收据申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        FPSJModel *fpsj = [[FPSJModel alloc] init];
                        [fpsj setValuesForKeysWithDictionary:dic];
                        [self.data addObject:fpsj];
                    }
                } else if ([_model.piType isEqualToString:@"YBBX"]) { //一般报销
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        YBBXModel *ybbx = [[YBBXModel alloc] init];
                        [ybbx setValuesForKeysWithDictionary:dic];
                        [self.data addObject:ybbx];
                    }
                    for (NSDictionary *dic in responseObject[@"rows1"]) {
                        BXMX *model = [[BXMX alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.itemized addObject:model];
                    }
                    
                } else if ([_model.piType isEqualToString:@"YBJSX"] || [_model.piType isEqualToString:@"JSX"]) { //一般介绍信  介绍信
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JSXModel *jsx = [[JSXModel alloc] init];
                        [jsx setValuesForKeysWithDictionary:dic];
                        [self.data addObject:jsx];
                    }
                } else if ([_model.piType isEqualToString:@"WTS"]) { //一般委托书
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        WTSModel *wts = [[WTSModel alloc] init];
                        [wts setValuesForKeysWithDictionary:dic];
                        [self.data addObject:wts];
                    }
                } else if ([_model.piType isEqualToString:@"YBJKSQ"]) { //一般借款申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        YBJKSQModel *ybjksq = [[YBJKSQModel alloc] init];
                        [ybjksq setValuesForKeysWithDictionary:dic];
                        [self.data addObject:ybjksq];
                    }
                } else if ([_model.piType isEqualToString:@"XMFZR"]) { //项目负责人
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMFZRModel *xmfz = [[XMFZRModel alloc] init];
                        [xmfz setValuesForKeysWithDictionary:dic];
                        [self.data addObject:xmfz];
                    }
                    
                } else if ([_model.piType isEqualToString:@"XMKZ"]) { //项目刻章
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMKZModel *xmkz = [[XMKZModel alloc] init];
                        [xmkz setValuesForKeysWithDictionary:dic];
                        [self.data addObject:xmkz];
                    }
                } else if ([_model.piType isEqualToString:@"ZMS"]) { //法人授权证明书
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        ZMSModel *zms = [[ZMSModel alloc] init];
                        [zms setValuesForKeysWithDictionary:dic];
                        zms.uiName = dic[@"bsProjectinfo"][@"piName"];
                        [self.data addObject:zms];
                    }
                } else if ([_model.piType isEqualToString:@"SG"] || [_model.piType isEqualToString:@"SJ"]) { //施工合同管理
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        SGModel *sg = [[SGModel alloc] init];
                        [sg setValuesForKeysWithDictionary:dic];
                        [self.data addObject:sg];
                    }
                } else if ([_model.piType isEqualToString:@"BSJJ"]) { //标书交接
                    BSJJModel *bsjj = [[BSJJModel alloc] init];
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        if (![dic isKindOfClass:[NSNull class]]) {
                            [bsjj setValuesForKeysWithDictionary:dic];
                            bsjj.bidHandOverInfoVo = responseObject[@"bidHandOverInfoVo"];
                            [self.data addObject:bsjj];
                        }else {
                            self.isLoad = NO;
                        }
                    }
                }else if ([_model.piType isEqualToString:@"XMTBPS"]) { //项目投标评审
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMTBPSModel *xmtbps = [[XMTBPSModel alloc] init];
                        [xmtbps setValuesForKeysWithDictionary:dic];
                        [self.data addObject:xmtbps];
                    }
                } else if ([_model.piType isEqualToString:@"JYCWZL"]) { //借阅财务资料申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JYCWZLModel *jycwzl = [[JYCWZLModel alloc] init];
                        [jycwzl setValuesForKeysWithDictionary:dic];
                        [self.data addObject:jycwzl];
                    }
                } else if ([_model.piType isEqualToString:@"XMBX"]) { //项目费用报销申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMBXModel *xmbx = [[XMBXModel alloc] init];
                        [xmbx setValuesForKeysWithDictionary:dic];
                        [self.data addObject:xmbx];
                    }
                    for (NSDictionary *dic in responseObject[@"rowsEx"]) {
                        BXMX *model = [[BXMX alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.itemized addObject:model];
                    }
                } else if ([_model.piType isEqualToString:@"XMZJSQ"]) { //项目资金申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMZJSQModel *xmzjsq = [[XMZJSQModel alloc] init];
                        [xmzjsq setValuesForKeysWithDictionary:dic];
                        [self.data addObject:xmzjsq];
                    }
                } else if ([_model.piType isEqualToString:@"WJZ"]) { //外经证申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        WJZModel *wjz = [[WJZModel alloc] init];
                        [wjz setValuesForKeysWithDictionary:dic];
                        [self.data addObject:wjz];
                    }
                } else if ([_model.piType isEqualToString:@"LKDJ"]) { //来款登记  工程款支付
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        LKDJModel *lkdj = [[LKDJModel alloc] init];
                        [lkdj setValuesForKeysWithDictionary:dic];
                        [self.data addObject:lkdj];
                        [self.itemized addObject:lkdj];
                    }
                } else if ([_model.piType isEqualToString:@"BK"]) { //拨付会签单管理
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        BFHQDModel *bfhqd = [[BFHQDModel alloc] init];
                        [bfhqd setValuesForKeysWithDictionary:dic];
                        [self.data addObject:bfhqd];
                        [self.itemized addObject:bfhqd];
                    }
                } else if ([_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"QTFK"]) { //劳务付款管理    材料付款    其他付款
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        LWFKModel *lwfk = [[LWFKModel alloc] init];
                        [lwfk setValuesForKeysWithDictionary:dic];
                        [self.data addObject:lwfk];
                    }
                    for (NSDictionary *dic1 in responseObject[@"rows1"]) {
                        LWandCLModel *model = [[LWandCLModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic1];
                        [self.itemized addObject:model];
                    }
                    
                } else if ([_model.piType isEqualToString:@"XMDF"]) { //项目代付
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMDFModel *XMDF = [[XMDFModel alloc] init];
                        [XMDF setValuesForKeysWithDictionary:dic];
                        [self.data addObject:XMDF];
                    }
                } else if ([_model.piType isEqualToString:@"JKBX"]) { //借款报销
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JKBXModel *JKBX = [[JKBXModel alloc] init];
                        [JKBX setValuesForKeysWithDictionary:dic];
                        [self.data addObject:JKBX];
                    }
                    for (NSDictionary *dic1 in [responseObject[@"rows"] firstObject] [@"rsProjectBorrowErexpenseDetail"]) {
                        BXMX *model = [[BXMX alloc] init];
                        [model setValuesForKeysWithDictionary:dic1];
                        [self.itemized addObject:model];
                    }
                } else if ([_model.piType isEqualToString:@"JKSQ"]) { //借款申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JKSQModel *JKSQ = [[JKSQModel alloc] init];
                        [JKSQ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:JKSQ];
                    }
                } else if ([_model.piType isEqualToString:@"ZBSPL"]) { //周报
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        ZBModel *ZB = [[ZBModel alloc] init];
                        [ZB setValuesForKeysWithDictionary:dic];
                        [self.data addObject:ZB];
                    }
                }else if ([_model.piType isEqualToString:@"FWGZ"]) { //法务跟踪
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        FWGZModel *FWGZ = [[FWGZModel alloc] init];
                        [FWGZ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:FWGZ];
                    }
                    // 法务跟踪明细
                    for (NSDictionary *row in responseObject[@"rows1"]) {
                        FWGZModel *FWGZ = [[FWGZModel alloc] init];
                        [FWGZ setValuesForKeysWithDictionary:row];
                        [self.itemized addObject:FWGZ];
                    }
                    
                }else if ([_model.piType isEqualToString:@"HYJY"]) { //会议纪要
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        HYJYModel *HYJY = [[HYJYModel alloc] init];
                        [HYJY setValuesForKeysWithDictionary:dic];
                        [self.data addObject:HYJY];
                    }
                }else if ([_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"]) { //材料付款  材料预付款
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        CLCGFKModel *clcgfk = [[CLCGFKModel alloc] init];
                        [clcgfk setValuesForKeysWithDictionary:dic];
                        [self.data addObject:clcgfk];
                        self.mctId = [responseObject[@"rows"] firstObject][@"mctId"];
                    }
                    [self getCLCGFKDetailsWithMctId:self.mctId andModel:self.data.firstObject];
                    [self loadPayForMaterialDetails];
                }else if ([_model.piType isEqualToString:@"CGHT"]) { //材料合同
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        CGHTModel *CGHT = [[CGHTModel alloc] init];
                        [CGHT setValuesForKeysWithDictionary:dic];
                        [self.data addObject:CGHT];
                    }
                    // 明细
                    self.mctId = [responseObject[@"rows"] firstObject] [@"mctId"];
                    [self loadPayForMaterialDetails];
                }else if ([_model.piType isEqualToString:@"XMYS"]) {    // 项目预审
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        XMYSModel *model = [[XMYSModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.data addObject:model];
                    }
                }else if ([_model.piType isEqualToString:@"HTBG"]) {    //施工/设计合同 变更
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        HTBGModel *HTBG = [[HTBGModel alloc] init];
                        [HTBG setValuesForKeysWithDictionary:dic];
                        [self.data addObject:HTBG];
                    }
                }else if ([_model.piType isEqualToString:@"BCHT"]) {    //施工/设计合同 补充
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        BCHTModel *BCHT = [[BCHTModel alloc] init];
                        [BCHT setValuesForKeysWithDictionary:dic];
                        [self.data addObject:BCHT];
                    }
                        BCHTModel *model = [[BCHTModel alloc] init];
                        model.bsProjectContractPays = [responseObject[@"rows"] firstObject][@"bsProjectContractPays"];
                        [self.itemized addObject:model];
                    
                }else if ([_model.piType isEqualToString:@"YHKH"]) {    //银行开户
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        YHKHModel *YHKH = [[YHKHModel alloc] init];
                        [YHKH setValuesForKeysWithDictionary:dic];
                        [self.data addObject:YHKH];
                    }
                }else if ([_model.piType isEqualToString:@"ZBDL"]) {    //招标代理
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        ZBDLModel *ZBDL = [[ZBDLModel alloc] init];
                        [ZBDL setValuesForKeysWithDictionary:dic];
                        [self.data addObject:ZBDL];
                    }
                }else if ([_model.piType isEqualToString:@"DKBKSQ"]) {    //打卡补卡申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        DKBKSQModel *DKBK = [[DKBKSQModel alloc] init];
                        [DKBK setValuesForKeysWithDictionary:dic];
                        [self.data addObject:DKBK];
                    }
                }else if ([_model.piType isEqualToString:@"JCBG"]) {    //检查报告  birExamined
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JCBGModel *JCBG = [[JCBGModel alloc] init];
                        [JCBG setValuesForKeysWithDictionary:dic];
                        JCBG.piName = dic[@"bsProjectinfo"][@"piName"];
                        JCBG.piAddresspca = dic[@"bsProjectinfo"][@"piAddresspca"];
                        JCBG.piAdress = dic[@"bsProjectinfo"][@"piAdress"];
                        JCBG.bpcSupplyfee = dic[@"bsProjectcontract"][@"bpcSupplyfee"];
                        JCBG.bpcRealcontractid = dic[@"bsProjectcontract"][@"bpcRealcontractid"];
                        JCBG.bpcStartdate = dic[@"bsProjectcontract"][@"bpcStartdate"];
                        JCBG.bpcWorkeddate = dic[@"bsProjectcontract"][@"bpcWorkeddate"];
                        [self.data addObject:JCBG];
                    }
                }else if ([_model.piType isEqualToString:@"WDJC"]) {  //文档借阅
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        DAMModel *model = [[DAMModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.data addObject:model];
                    }
                }
                
                // 公文申请
                else if ([_model.piType isEqualToString:@"CCSP"]) { //出差
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        CCSPModel *CCSP = [[CCSPModel alloc] init];
                        [CCSP setValuesForKeysWithDictionary:dic];
                        [self.data addObject:CCSP];
                    }
                }else if ([_model.piType isEqualToString:@"YZHS"]) { //印章回收审批
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        YZHSModel *YZHS = [[YZHSModel alloc] init];
                        [YZHS setValuesForKeysWithDictionary:dic];
                        [self.data addObject:YZHS];
                    }
                }else if ([_model.piType isEqualToString:@"CFSP"]) { //处罚审批
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        CFSPModel *CFSP = [[CFSPModel alloc] init];
                        [CFSP setValuesForKeysWithDictionary:dic];
                        [self.data addObject:CFSP];
                    }
                }else if ([_model.piType isEqualToString:@"GCYWCC"] || [_model.piType isEqualToString:@"GCXMXC"]) { // 工程业务出差审批 工程项目巡查出差审批
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        GCYWCCModel *GCYWCC = [[GCYWCCModel alloc] init];
                        [GCYWCC setValuesForKeysWithDictionary:dic];
                        [self.data addObject:GCYWCC];
                    }
                }else if ([_model.piType isEqualToString:@"IDQXSQ"]) { //ID门禁卡权限
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        IDQXModel *IDQX = [[IDQXModel alloc] init];
                        [IDQX setValuesForKeysWithDictionary:dic];
                        [self.data addObject:IDQX];
                    }
                }else if ([_model.piType isEqualToString:@"IDZKSQ"]) { //ID门禁卡制卡
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        IDZKModel *IDZK = [[IDZKModel alloc] init];
                        [IDZK setValuesForKeysWithDictionary:dic];
                        [self.data addObject:IDZK];
                    }
                    for (NSDictionary *dic in [responseObject[@"rows"] firstObject][@"oaDocIdcardProposer"]) {
                        ZKModel *model = [[ZKModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.itemized addObject:model];
                    }
                    
                }else if ([_model.piType isEqualToString:@"QJSQ"]) { //请假
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        QJModel *QJ = [[QJModel alloc] init];
                        [QJ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:QJ];
                    }
                }else if ([_model.piType isEqualToString:@"RSXQ"]) { //人事人力需求
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        RSXQModel *RSXQ = [[RSXQModel alloc] init];
                        [RSXQ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:RSXQ];
                    }
                }else if ([_model.piType isEqualToString:@"SBGJJ"]) { //社保及公积金
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        SBGJJModel *SBGJJ = [[SBGJJModel alloc] init];
                        [SBGJJ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:SBGJJ];
                    }
                }else if ([_model.piType isEqualToString:@"PXSP"]) { //培训
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        PXSPModel *PXSP = [[PXSPModel alloc] init];
                        [PXSP setValuesForKeysWithDictionary:dic];
                        [self.data addObject:PXSP];
                    }
                }else if ([_model.piType isEqualToString:@"JSJSBSQ"]) { //计算机设备
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JSJSBModel *JSJSB = [[JSJSBModel alloc] init];
                        [JSJSB setValuesForKeysWithDictionary:dic];
                        [self.data addObject:JSJSB];
                    }
                }else if ([_model.piType isEqualToString:@"WPSQ"]) { //外派人员
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        WPModel *WP = [[WPModel alloc] init];
                        [WP setValuesForKeysWithDictionary:dic];
                        [self.data addObject:WP];
                    }
                }else if ([_model.piType isEqualToString:@"WPDHSQ"]) { //外派人员调回申请
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        WPDHModel *WPDH = [[WPDHModel alloc] init];
                        [WPDH setValuesForKeysWithDictionary:dic];
                        [self.data addObject:WPDH];
                    }
                }else if ([_model.piType isEqualToString:@"ERPLCBG"]) { //ERP流程变更
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        ERPLCBGModel *ERPLCBG = [[ERPLCBGModel alloc] init];
                        [ERPLCBG setValuesForKeysWithDictionary:dic];
                        [self.data addObject:ERPLCBG];
                    }
                }else if ([_model.piType isEqualToString:@"JSCYLY"]) { //酒水茶叶领用
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JSCYLYModel *JSCYLY = [[JSCYLYModel alloc] init];
                        [JSCYLY setValuesForKeysWithDictionary:dic];
                        [self.data addObject:JSCYLY];
                    }
                }else if ([_model.piType isEqualToString:@"HTSP"]) { //合同审批
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        HTSPModel *HTSP = [[HTSPModel alloc] init];
                        [HTSP setValuesForKeysWithDictionary:dic];
                        [self.data addObject:HTSP];
                    }
                }else if ([_model.piType isEqualToString:@"JDSQ"]) { //接待
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        JDModel *JDSQ = [[JDModel alloc] init];
                        [JDSQ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:JDSQ];
                    }
                }else if ([_model.piType isEqualToString:@"YWCC"]) { //业务出差
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        YWCCModel *YWCC = [[YWCCModel alloc] init];
                        [YWCC setValuesForKeysWithDictionary:dic];
                        [self.data addObject:YWCC];
                    }
                }else if ([_model.piType isEqualToString:@"MPSQ"]) { //名片
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        MPModel *MPSQ = [[MPModel alloc] init];
                        [MPSQ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:MPSQ];
                    }
                }else if ([_model.piType isEqualToString:@"YPSG"]) { //用品申购
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        YPSGModel *YPSG = [[YPSGModel alloc] init];
                        [YPSG setValuesForKeysWithDictionary:dic];
                        [self.data addObject:YPSG];
                    }
                }else if ([_model.piType isEqualToString:@"RSLH"]) { //人事落户
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        RSLHModel *RSLH = [[RSLHModel alloc] init];
                        [RSLH setValuesForKeysWithDictionary:dic];
                        [self.data addObject:RSLH];
                    }
                }else if ([_model.piType isEqualToString:@"YZWCSQ"]) { //印章外出使用
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        YZWCModel *YZWCSQ = [[YZWCModel alloc] init];
                        [YZWCSQ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:YZWCSQ];
                    }
                }else if ([_model.piType isEqualToString:@"ZYLK"]) { //项目管控 ->收款详情
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        ZYLKModel *ZYLK = [[ZYLKModel alloc] init];
                        [ZYLK setValuesForKeysWithDictionary:dic];
                        [self.data addObject:ZYLK];
                    }
                }else if ([_model.piType isEqualToString:@"YCGZ"]) { //负责人违规
                    YCGZModel *YCGZ = [[YCGZModel alloc] init];
                    [YCGZ setValuesForKeysWithDictionary:responseObject[@"rows"]];
                    [YCGZ setValuesForKeysWithDictionary:responseObject[@"rows"] [@"paPartnerAnomaly"]];
                    [self.data addObject:YCGZ];
                }else if ([_model.piType isEqualToString:@"LWFBHT"]) { //劳务合同
                    LWFBHTModel *LWFBHT = [[LWFBHTModel alloc] init];
                    [LWFBHT setValuesForKeysWithDictionary:responseObject[@"rows"]];
                    [self.data addObject:LWFBHT];
                }else if ([_model.piType isEqualToString:@"LWHT"]) { //劳务合同
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        LWHTModel *LWHT = [[LWHTModel alloc] init];
                        [LWHT setValuesForKeysWithDictionary:dic];
                        [self.data addObject:LWHT];
                    }
                }else if ([_model.piType isEqualToString:@"LWJDK"]) { //劳务进度款
                    LWJDKModel *LWJDK = [[LWJDKModel alloc] init];
                    [LWJDK setValuesForKeysWithDictionary:responseObject[@"rows"]];
                    [LWJDK setValuesForKeysWithDictionary:responseObject[@"rows"] [@"rsLabourcontract"]];
                    [self.data addObject:LWJDK];
                }else if ([_model.piType isEqualToString:@"LWJSK"]) { //劳务结算款
                    LWJSKModel *LWJSK = [[LWJSKModel alloc] init];
                    [LWJSK setValuesForKeysWithDictionary:responseObject[@"rows"]];
                    [LWJSK setValuesForKeysWithDictionary:responseObject[@"rows"] [@"rsLabourcontract"]];
                    [self.data addObject:LWJSK];
                }else if ([_model.piType isEqualToString:@"KP"]) { //开票
                    for (NSDictionary *dic in responseObject[@"rows"][@"detailList"]) {
                        KPListModel *kpList = [[KPListModel alloc] init];
                        [kpList setValuesForKeysWithDictionary:dic];
                        [self.xmProject addObject:kpList];
                    }
                    KPModel *KP = [[KPModel alloc] init];
                    [KP setValuesForKeysWithDictionary:responseObject[@"rows"]];
                    [KP setValuesForKeysWithDictionary:responseObject[@"rows"] [@"oaBillAndReceipt"]];
                    [self.data addObject:KP];
                }else if ([_model.piType isEqualToString:@"SPGL"]) { //收票
                    // 基本
                    SPModel *SP = [[SPModel alloc] init];
                    SP.oiOthers = responseObject[@"rows"] [@"oiOthers"];
                    SP.oiOtheres = responseObject[@"rows"] [@"oiOtheres"];
                    if ([SP.oiOtheres isEqualToString:@"LWHT"]) {
                        [SP setValuesForKeysWithDictionary:responseObject[@"rows"] [@"rsLabourcontract"]];
                    }else {
                        [SP setValuesForKeysWithDictionary:responseObject[@"rows"] [@"mcMaterialcontract"]];
                    }
                    [self.data addObject:SP];
                    // 详情
                    for (NSDictionary *dic in responseObject[@"rows"] [@"fnList"]) {
                        SPListModel *spListmodel = [[SPListModel alloc] init];
                        [spListmodel setValuesForKeysWithDictionary:dic];
                        [self.xmProject addObject:spListmodel];
                    }
                }else if ([_model.piType isEqualToString:@"NKDJ"]) { //诺款登记
                    for (NSDictionary *dic in responseObject[@"rows"]) {
                        NKDJModel *NKDJ = [[NKDJModel alloc] init];
                        [NKDJ setValuesForKeysWithDictionary:dic];
                        [self.data addObject:NKDJ];
                    }
                }
            }
            [self.ApproveTable reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"此申请属于新增功能，更新APP后审批，或直接到PC进行审批操作" andTitle:@"提示" andIsPre:YES];
        }
    }];
}

// 材料付款详情数据
- (void)getCLCGFKDetailsWithMctId:(NSString *)mctId andModel:(CLCGFKModel *)model
{
    _url = [NSString stringWithFormat:@"%@/mcMaterialContract/findById?mctId=%@",intranetURL,mctId];
    [self.manager POST:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                [model setValuesForKeysWithDictionary:dic];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//  材料付款明细
- (void)loadPayForMaterialDetails
{
    if ([_model.piType isEqualToString:@"CLCGFK"]) {
        _url = [NSString stringWithFormat:@"%@/%@/%@?%@=%@&page=1&&rows=15",intranetURL,@"mcPaymentDetailController",@"findBymctIdAndmpId",@"pdMpid",_model.piId];
    }else if ([_model.piType isEqualToString:@"CLCGYFK"] || [_model.piType isEqualToString:@"CGHT"]) {
        _url = [NSString stringWithFormat:@"%@/%@/%@?%@=%@&page=1&&rows=15",intranetURL,@"mcContractdetail",@"findBymctId",@"mctId",self.mctId];
    }
    
    [self.manager POST:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                CLFKModel *model = [[CLFKModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.xmProject addObject:model];
            }
        }
        [self.ApproveTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activity stopAnimating];
        _activityView.hidden = YES;
        [self showAlertControllerMessage:@"该数据已不存在" andTitle:@"提示" andIsPre:NO];
    }];
}

- (void)loadProjectManagerHistorical
{
    _url = [NSString stringWithFormat:@"%@/%@/%@?%@=%@",intranetURL,@"bsProjectManagerHistorical",@"findByPmId",@"pmId",_model.piId];
    [self.manager POST:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"rows"]) {
            xmProjectModel *model = [[xmProjectModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.xmProject addObject:model];
        }
        [self.ApproveTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activity stopAnimating];
        _activityView.hidden = YES;
        [self showAlertControllerMessage:@"该数据已不存在" andTitle:@"提示" andIsPre:NO];
    }];
}

// 请求docType网络数据
- (void)loadDocTypeViewDataWithUrl:(NSString *)url
{
//    NSLog(@"docTypeurl--%@",url);
    [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"status"] isEqualToString:@"success"]) {
            self.isLoad = false;
            _ABView.hidden = YES;
            [self.activity stopAnimating];
            [self showAlertControllerMessage:@"该数据已不存在" andTitle:@"提示" andIsPre:NO];
        }else {
            self.isLoad = true;
            // 提取控件信息
            NSArray *arr = responseObject[@"rows"];
            for (NSDictionary *dic1 in arr) {
                ClickApproveModel *caModel = [[ClickApproveModel alloc] init];
                // 公文
                if (self.isType) {
                    caModel.ddValue = dic1[@"ddValue"];
                    caModel.drId = dic1[@"drId"];
                    NSDictionary *docFromName = dic1[@"docFromName"];
                    caModel.fnTitle = docFromName[@"fnTitle"];
                    caModel.fnFromat = docFromName[@"fnFromat"];
                    if ([docFromName[@"fnFromat"] isEqualToString:@"radio"]) {
                        caModel.fnOption = docFromName[@"fnOption"];
                    }
                }
                //  fnTitle 为Id 的不加
                if (![caModel.fnTitle isEqualToString:@"Id"]) {
                    [self.data addObject:caModel];                }
            }
            [self.ApproveTable reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"数据出错,请重新加载" andTitle:@"提示" andIsPre:YES];
        }
    }];
}

// 获取审批附件数据
- (void)loadApproveEnclosureDataFromSevers
{
    // 清除附件数据源的数据
    [self.EnclosureData removeAllObjects];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:self.model.piId forKey:@"piId"];
    [parameters setValue:self.model.piType forKey:@"piType"];
    
    if ([_model.piType isEqualToString:@"JCBG"] || [_model.piType isEqualToString:@"ZBSPL"]) {
        for (int i = 0; i < 2; i ++) {
            if (i == 0) {
                [self requestSeversWithParameters:parameters withIsNow:NO];
            }else {
                if ([_model.piType isEqualToString:@"JCBG"]) {
                    // 现场照片
                    [parameters setValue:[NSString stringWithFormat:@"%@T",self.model.piType] forKey:@"piType"];
                }else if ([_model.piType isEqualToString:@"ZBSPL"]) {
                    // 现场照片
                    [parameters setValue:@"ZBSG" forKey:@"piType"];
                }
                [self requestSeversWithParameters:parameters withIsNow:YES];
            }
        }
    }else {
        [self requestSeversWithParameters:parameters withIsNow:NO];
    }
}
// 获取附件
#pragma mark --附件--
- (void)requestSeversWithParameters:(NSMutableDictionary *)parameters withIsNow:(BOOL)isNow
{
    [self.manager POST:documentsApprove parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"stauts"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"rows"]) {
                ApproveEnclosureModel *aeModel = [[ApproveEnclosureModel alloc] init];
                [aeModel setValuesForKeysWithDictionary:dic];
                if (isNow) {
                    [self.nowPhotos addObject:aeModel];
                }else {
                    [self.EnclosureData addObject:aeModel];
                }
            }
            if (isNow) {
                if (self.nowPhotos.count) {
                    if (self.nowPhotos.count%3 == 0) {
                        _shang = self.nowPhotos.count/3;
                    }else {
                        _shang = (NSInteger)(self.nowPhotos.count/3) + 1;
                    }
                }
            }
        }
        [self.ApproveTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"访问出错" andTitle:@"提示" andIsPre:YES];
        }
    }];
}

//  获取审批流程数据
#pragma mark --审批流程--
- (void)loadApproveProcedureDataFromSevers
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:self.model.piId forKey:@"piId"];
    [parameters setValue:self.model.piType forKey:@"piType"];
    _url = [NSString stringWithFormat:@"%@?piId=%@&piType=%@",approveProcedureUrl,self.model.piId,self.model.piType];
//    NSLog(@"审批流程url---%@",url);
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
        [self.ApproveTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self.activity stopAnimating];
            _activityView.hidden = YES;
            [self showAlertControllerMessage:@"服务器访问出错" andTitle:@"提示" andIsPre:YES];
        }
    }];
}

// 段数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isLoad) {
        if ([_model.piType isEqualToString:@"XMFZR"]) {
            return 5;
        }else if ([_model.piType isEqualToString:@"YBBX"]) {
            return 5;
        }else if ([_model.piType isEqualToString:@"XMBX"] || [_model.piType isEqualToString:@"JKBX"] || [_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"LKDJ"] || [_model.piType isEqualToString:@"IDZKSQ"] || [_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"] || [_model.piType isEqualToString:@"CGHT"] || [_model.piType isEqualToString:@"BCHT"] || [_model.piType isEqualToString:@"TBCH"] || [_model.piType isEqualToString:@"KP"] || [_model.piType isEqualToString:@"SPGL"]) {
            return 5;
        }else if ([_model.piType isEqualToString:@"BK"]) {
            return 6;
        }else if ([_model.piType isEqualToString:@"FWGZ"]){
            return 5;
        }else {
            return 5;
        }
    }else {
        return 0;
    }
}

// 段高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isLoad) {
        
        if ([_model.piType isEqualToString:@"BK"]) {
            if (section == 0) {
                return 0;
            }else if (section == 1) {   //  应扣费用
                return 50;
            }else if (section == 2) {   //  拨付金额及方式
                return 50;
            }else if (section == 3) {   //  附件
                if (self.EnclosureData.count == 0) {
                    return 0;
                }else {
                    return 50;
                }
            }else if (section == 4) {   //  现场照片
                if (self.nowPhotos.count == 0) {
                    return 0;
                }else {
                    return 50;
                }
            }else if (section == 5) {   //  审批流程
                if (self.procedureData.count == 0) {
                    return 0;
                }else {
                    return 50;
                }
            }else {
                return 0;
            }
        }else {
            if (section == 0) {
                return 0;
            }else if (section == 1) {   //  动态报销内容
                if (self.xmProject.count + self.itemized.count == 0 || [_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"IDZKSQ"]) {
                    return 0;
                }else {
                    return 50;
                }
            }else if (section == 2) {   //  附件
                if (self.EnclosureData.count == 0) {
                    return 0;
                }else {
                    return 50;
                }
            }else if (section == 3) {   //  现场照片
                if (self.nowPhotos.count == 0) {
                    return 0;
                }else {
                    return 50;
                }
            }else if (section == 4) {   //  审批流程
                if (self.procedureData.count == 0) {
                    return 0;
                }else {
                    return 50;
                }
            }else {
                return 0;
            }
        }
    }else {
        return 0;
    }
}

// 段字符串
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isLoad) {
        
        if ([_model.piType isEqualToString:@"BK"]) {
            if (section == 3) {
                return @"审批附件";
            } else if (section == 4) {
                return @"现场照片";
            } else if (section == 5) {
                return @"审批流程";
            } else if (section == 1) {
                return @"应扣费用";
            } else if (section == 2) {
                return @"拨付金额及方式";
            }
        }else {
            if (section == 2) {
                return @"审批附件";
            } else if (section == 3) {
                return @"现场照片";
            }  else if (section == 4) {
                return @"审批流程";
            } else if (section == 1) {
                if ([_model.piType isEqualToString:@"XMFZR"]) {
                    return @"曾完成的代表项目";
                }else if ([_model.piType isEqualToString:@"YBBX"]) {
                    return @"报销内容";
                }else if ([_model.piType isEqualToString:@"XMBX"] || [_model.piType isEqualToString:@"JKBX"]) {
                    return @"费用明细";
                }else if ([_model.piType isEqualToString:@"CLCGFK"]) {
                    return @"材料付款明细";
                }else if ([_model.piType isEqualToString:@"CLCGYFK"]) {
                    return @"材料预付款明细";
                }else if ([_model.piType isEqualToString:@"CGHT"]) {
                    return @"材料明细";
                }else if ([_model.piType isEqualToString:@"BCHT"]) {
                    return @"收款计划";
                }else if ([_model.piType isEqualToString:@"LKDJ"] || [_model.piType isEqualToString:@"BK"]) {
                    return @"应扣费用";
                }else if ([_model.piType isEqualToString:@"IDZKSQ"]) {
                    return @"申请人信息";
                }else if ([_model.piType isEqualToString:@"FWGZ"]) {
                    return @"法务追踪";
                }else if ([_model.piType isEqualToString:@"TBCH"]) {
                    return @"投标策划信息";
                }else if ([_model.piType isEqualToString:@"KP"] || [_model.piType isEqualToString:@"SPGL"]) {
                    return @"开票信息";
                }
                else {
                    return nil;
                }
            }
        }
    }else {
        return nil;
    }
    return nil;
}

// 每段多少个Cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isLoad) {
        if ([_model.piType isEqualToString:@"BK"]) {
            if (section == 0) {
                return self.data.count;
            }else if (section == 1) {
                return self.itemized.count;
            }else if (section == 2) {   // 拨付金额及方式
                return self.itemized.count;
            }else if (section == 3) {   // 审批附件数据源
                return self.EnclosureData.count;
            }else if (section == 4) {   // 现场照片
                return 1;
            }else if (section == 5) {   // 审批流程UI数据源
                return self.procedureData.count;
            }else {
                return 0;
            }
        }else {
            if (section == 0) {
                if ([_model.piType isEqualToString:@"YXBB"]) {
                    return 1;
                }else {
                    return self.data.count;
                }
            }else if (section == 1) {
                if ([_model.piType isEqualToString:@"XMFZR"]) {
                    return self.xmProject.count;
                }else if ([_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"] || [_model.piType isEqualToString:@"CGHT"] || [_model.piType isEqualToString:@"BCHT"] || [_model.piType isEqualToString:@"KP"] || [_model.piType isEqualToString:@"SPGL"]) {
                    return 1;
                }else if ([_model.piType isEqualToString:@"YBBX"] || [_model.piType isEqualToString:@"XMBX"] || [_model.piType isEqualToString:@"JKBX"] || [_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"LKDJ"] || [_model.piType isEqualToString:@"BK"] || [_model.piType isEqualToString:@"IDZKSQ"]) {
                    return self.itemized.count;
                }else if ([_model.piType isEqualToString:@"FWGZ"] || [_model.piType isEqualToString:@"TBCH"]){
                    return self.itemized.count;
                }else {
                    return 0;
                }
            }else if (section == 2) {   // 审批附件数据源
                return self.EnclosureData.count;
            }else if (section == 3) {   // 现场照片
                return 1;
            }else if (section == 4) {   // 审批流程UI数据源
                return self.procedureData.count;
            }else {
                return 0;
            }
        }
    }else {
        return 0;
    }
}

#pragma mark ---Cell---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.activity stopAnimating];

    if (indexPath.section == 0) {
        // 公文申请需要调用的方法
        if (self.isType) {
            // 显示数据UI
            ApproveUICell *cell = [[ApproveUICell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            // 不可编辑状态
            [cell isEditable:NO];
            cell.isType = self.isType;
            cell.officeModel = self.model;
            cell.approveHeightDelegate = self;
            [cell creatApproveUIWithModel:self.data[indexPath.row]];
            return cell;
        }else {
            NSString *type = _model.piType;
            if ([type isEqualToString:@"XM"]) {
                //  项目立项
                XMTableViewCell *cell = [[XMTableViewCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"TBBH"] || [type isEqualToString:@"XMBH"]) {
                //  投标保函 & 项目保函
                TBBHAndXMBHCell *cell = [[TBBHAndXMBHCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                if ([type isEqualToString:@"TBBH"]) {
                    cell.nameCell = @"投标保函申请";
                }else {
                    cell.nameCell = @"项目保函申请";
                }
                [cell creatTBBHAndXMBApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"HTYY"]) {
                //  合同用印
                HTYYCell *cell = [[HTYYCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatHTYYApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"XMYS"]) {
                //  项目预审
                XMYSCell *cell = [[XMYSCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMYSApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"SWWJ"] || [type isEqualToString:@"GCLWJ"]) {
                //  工程类文件 商务文件 用印
                SWWJAndGCLWJCell *cell = [[SWWJAndGCLWJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                if ([type isEqualToString:@"SWWJ"]) {
                    cell.nameCell = @"商务文件用印";
                }else {
                    cell.nameCell = @"工程类文件用印";
                }
                [cell creatSWWJAndGCLWJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"XMBZJ"]) {
                // 项目保证金
                XMBZJCell *cell = [[XMBZJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMBZJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"TXMBZJ"]) {
                // 退项目保证金
                TXMBZJCell *cell = [[TXMBZJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatTXMBZJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"TBBZJ"]) {
                // 投标保证金
                TBBZJCell *cell = [[TBBZJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatTBBZJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([type isEqualToString:@"TTBBZJ"]) {
                // 退投标保证金
                TTBBZJCell *cell = [[TTBBZJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatTTBBZJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([type isEqualToString:@"FPSJ"]) {
                //发票/收据申请
                FPSJCell *cell = [[FPSJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatFPSJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"YBBX"]) {
                //一般报销
                YBBXCell *cell = [[YBBXCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYBBXApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"YBJSX"] || [_model.piType isEqualToString:@"JSX"]) {
                //一般介绍信  介绍信
                JSXCell *cell = [[JSXCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJSXApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"WTS"]) {
                //一般委托书
                WTSCell *cell = [[WTSCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatWTSApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"YBJKSQ"]) {
                //一般借款申请
                YBJKSQCell *cell = [[YBJKSQCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYBJKSQApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"XMFZR"]) {
                //项目负责人
                XMFZRCell *cell = [[XMFZRCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMFZRApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"XMKZ"]) {
                //项目刻章
                XMKZCell *cell = [[XMKZCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMKZApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"ZMS"]) {
                //法人授权证明书
                ZMSCell *cell = [[ZMSCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatZMSApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"SG"]) {
                //施工
                SGCell *cell = [[SGCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatSGApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"SJ"]) {
                //设计
                SJCell *cell = [[SJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatSJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"BSJJ"]) {
                //投标交接查询
                BSJJCell *cell = [[BSJJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatBSJJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"XMTBPS"]) {
                //项目投标评审
                XMTBPSCell *cell = [[XMTBPSCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMTBPSApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"JYCWZL"]) {
                //借阅财务资料申请
                JYCWZLCell *cell = [[JYCWZLCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJYCWZLApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"XMBX"]) {
                //项目费用报销申请
                XMBXCell *cell = [[XMBXCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMBXApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"XMZJSQ"]) {
                //项目资金申请
                XMZJSQCell *cell = [[XMZJSQCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMZJSQApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"WJZ"]) {
                //外经证申请
                WJZCell *cell = [[WJZCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatWJZApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"LKDJ"]) {
                // 来款登记
                LKDJCell *cell = [[LKDJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatLKDJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"BK"]) {
                // 拨付会签
                BFHQDCell *cell = [[BFHQDCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatBFHQDApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"QTFK"]) {
                // 劳务付款管理    材料付款    其他付款
                LWFKCell *cell = [[LWFKCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatLWFKApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            }else if ([_model.piType isEqualToString:@"XMDF"]) {
                // 项目代付
                XMDFCell *cell = [[XMDFCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatXMDFApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"JKBX"]) {
                // 借款报销
                JKBXCell *cell = [[JKBXCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJKBXApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"JKSQ"]) {
                // 借款申请
                JKSQCell *cell = [[JKSQCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJKSQApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"DKBKSQ"]) {
                // 打卡补卡申请
                DKBKSQCell *cell = [[DKBKSQCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatDKBKSQApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"JCBG"]) {
                // 检查报告
                JCBGCell *cell = [[JCBGCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJCBGApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            }else if ([_model.piType isEqualToString:@"WDJC"]) {
                // 文档借阅
                DAMCell *cell = [[DAMCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatDAMApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            }
            
            // 公文申请
            else if ([_model.piType isEqualToString:@"CCSP"]) { //出差
                CCSPCell *cell = [[CCSPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatCCSPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"YZHS"]) { //印章回收审批
                YZHSCell *cell = [[YZHSCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYZHSApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"CFSP"]) { //处罚审批
                CFSPCell *cell = [[CFSPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatCFSPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"GCYWCC"] || [_model.piType isEqualToString:@"GCXMXC"]) { //工程业务出差审批 工程项目巡查出差审批
                GCYWCCCell *cell = [[GCYWCCCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatGCYWCCApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"IDQXSQ"]) { //ID门禁卡权限申请审批流程
                IDQXCell *cell = [[IDQXCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatIDQXApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"IDZKSQ"]) { //ID门禁卡制卡申请审批流程
                IDZKCell *cell = [[IDZKCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatIDZKApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"QJSQ"]) { //请假申请
                QJCell *cell = [[QJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatQJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"RSXQ"]) { //人事人力需求
                RSXQCell *cell = [[RSXQCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatRSXQApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"SBGJJ"]) { //社保及公积金缴纳
                SBGJJCell *cell = [[SBGJJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatSBGJJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"PXSP"]) { //培训申请流程
                PXSPCell *cell = [[PXSPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatPXSPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"JSJSBSQ"]) { //计算机设备申请
                JSJSBCell *cell = [[JSJSBCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJSJSBApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"WPSQ"]) { //外派人员申请审批流程
                WPCell *cell = [[WPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatWPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"WPDHSQ"]) { //外派人员调回申请审批流程
                WPDHMCell *cell = [[WPDHMCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatWPDHApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"ERPLCBG"]) { //ERP流程变更申请表
                ERPLCBGCell *cell = [[ERPLCBGCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatERPLCBGApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"JSCYLY"]) { //酒水茶叶领用审批
                JSCYLYCell *cell = [[JSCYLYCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJSCYLYApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"HTSP"]) { //合同审批流程
                HTSPCell *cell = [[HTSPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatHTSPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"JDSQ"]) { //接待申请
                JDCell *cell = [[JDCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatJDApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"YWCC"]) { //业务出差审批流程
                YWCCCell *cell = [[YWCCCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYWCCApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"MPSQ"]) { //名片申请审批流程
                MPCell *cell = [[MPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatMPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"YPSG"]) { //用品申购表申请表单
                YPSGCell *cell = [[YPSGCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYPSGApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"RSLH"]) { //人事落户申请审批流程
                RSLHCell *cell = [[RSLHCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatRSLHApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"YZWCSQ"]) { //印章外出使用申请
                YZWCCell *cell = [[YZWCCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYZWCApproveUIWithModel:self.data[indexPath.row]];
                return cell;
             
            } else if ([_model.piType isEqualToString:@"ZBSPL"]) { //周报
                ZBCell *cell = [[ZBCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatZBApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"FWGZ"]) { //法务跟踪
                FWGZCell *cell = [[FWGZCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatFWGZApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"HYJY"]) { //会议纪要
                HYJYCell *cell = [[HYJYCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatHYJYApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"]) { //材料付款  材料预付款
                CLCGFKCell *cell = [[CLCGFKCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatCLCGFKApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"CGHT"]) { //材料合同
                CGHTCell *cell = [[CGHTCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatCGHTApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"HTBG"]) { //施工/设计合同 变更
                HTBGCell *cell = [[HTBGCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatHTBGApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"BCHT"]) { //施工/设计合同 补充
                BCHTCell *cell = [[BCHTCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatBCHTApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"TBCH"]) { //投标策划
                TBCHCell *cell = [[TBCHCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatTBCHApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"YHKH"]) { //银行开户
                YHKHCell *cell = [[YHKHCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYHKHApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"ZBDL"]) { //招标代理
                ZBDLCell *cell = [[ZBDLCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatZBDLApproveUIWithModel:self.data[indexPath.row]];
                return cell;
                
            } else if ([_model.piType isEqualToString:@"YXBB"]) { //报表
                YXBBCell *cell = [[YXBBCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell loadWeb:_model.piId];
                return cell;
            } else if ([_model.piType isEqualToString:@"ZYLK"]) { //项目管控 -> 收款详情
                ZYLKCell *cell = [[ZYLKCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatZYLKApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"YCGZ"]) { //负责人违规
                YCGZCell *cell = [[YCGZCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatYCGZApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"LWFBHT"]) { //劳务合同
                LWFBHTCell *cell = [[LWFBHTCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatLWFBHTApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"LWHT"]) { //劳务合同
                LWHTCell *cell = [[LWHTCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatLWHTApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"LWJDK"]) { //劳务进度款
                LWJDKCell *cell = [[LWJDKCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatLWJDKApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"LWJSK"]) { //劳务结算款
                LWJSKCell *cell = [[LWJSKCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatLWJSKApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"KP"]) { // 开票
                KPCell *cell = [[KPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatKPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"SPGL"]) { // 收票
                SPCell *cell = [[SPCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatSPApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            } else if ([_model.piType isEqualToString:@"NKDJ"]) { //诺款登记
                NKDJCell *cell = [[NKDJCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.passHeightDelegate = self;
                [cell creatNKDJApproveUIWithModel:self.data[indexPath.row]];
                return cell;
            }
            
        }
    } else if (indexPath.section == 1) {
        // 显示报销内容 或 项目负责人曾完成的项目
        if ([_model.piType isEqualToString:@"YBBX"]) {
            BXMXCell *cell = [[BXMXCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.itemized.count) {
                cell.passHeightDelegate = self;
                [cell referUIWithModel:self.itemized[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"] || [_model.piType isEqualToString:@"CGHT"]) {  // 材料付款明细  材料预付款明细  材料明细
            CLFKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clfkCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell refreCLFKUIWithData:self.xmProject];
            return cell;
            
        }else if ([_model.piType isEqualToString:@"XMFZR"]) {   // 项目负责人
            XMProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xmpCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.xmProject.count) {
                [cell referUIWithModel:self.xmProject[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"XMBX"]) {    // 项目报销
            XMBX *cell = [tableView dequeueReusableCellWithIdentifier:@"xmbx" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.itemized.count) {
                [cell referUIWithModel:self.itemized[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"JKBX"]) {    // 借款报销
            XMBX *cell = [tableView dequeueReusableCellWithIdentifier:@"xmbx" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.itemized.count) {
                [cell referJKBXUIWithModel:self.itemized[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"]) {     // 劳务 材料
            LWandCLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lwclCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([_model.piType isEqualToString:@"LWFK"]) {
                cell.titleArr = @[@"劳务合同编号",@"劳务合同名称",@"劳务公司",@"班组名称",@"劳务合同价格",
                                  @"本次拨付金额",@"本次补差金额",@"累计拨付金额",@"累计补差金额",@"备注"];
            }else {
                cell.titleArr = @[@"材料合同编号",@"材料合同名称",@"材料供应商",@"材料合同价格",@"本次拨付金额",
                                  @"本次补差金额",@"累计拨付金额",@"累计补差金额",@"备注"];
            }
            if (self.itemized.count) {
                [cell referLWClWithModel:self.itemized[indexPath.row]];
                cell.passHeightDelegate = self;
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"LKDJ"]) {    // 来款登记   工程款支付
            LKDJ *cell = [tableView dequeueReusableCellWithIdentifier:@"lkdj" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.titleArr = @[@"费用名称",@"比例(%)",@"金额(元)",@"累计金额",@"备注"];
            if (self.itemized.count) {
                [cell referLKDJUIWithModel:self.itemized[indexPath.row]];
                cell.passDelegate = self;
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"BK"]) {  //
            BFHQDForCostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"costCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.itemized.count) {
                [cell referCostUIWithModel:self.itemized[indexPath.row]];
                cell.passheightDelegate = self;
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"IDZKSQ"]) {  // 制卡
            ZKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zkCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.itemized.count) {
                [cell refreZKUIWithModel:self.itemized[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"BCHT"]) {  // 施工/设计 合同 补充
            BCHT *cell = [tableView dequeueReusableCellWithIdentifier:@"bcht" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.titleArr = @[@"收款时间",@"收款金额",@"收款条件",@"备注"];
            if (self.itemized.count) {
                [cell refreBCHTUIWithModel:self.itemized[indexPath.row]];
                cell.passHeightDelegate = self;
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"FWGZ"]) {  // 法务跟踪明细
            FWGZ *cell = [tableView dequeueReusableCellWithIdentifier:@"fwgz" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.itemized.count) {
                [cell refreFWGZUIWithModel:self.itemized[indexPath.row]];
                cell.passHeightDelegate = self;
                return cell;
            }else {
                return nil;
            }
            
        }else if ([_model.piType isEqualToString:@"TBCH"]) {  // 投标策划
            TBCH *cell = [tableView dequeueReusableCellWithIdentifier:@"tbch" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            if (self.itemized.count) {
                [cell refreTBCHUIWithModel:self.itemized[indexPath.row]];
                cell.passHeightDelegate = self;
                return cell;
            }else {
                return nil;
            }
        }else if ([_model.piType isEqualToString:@"KP"]) {  // 开票
            KPListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kpListCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell refreKPListUIWithData:self.xmProject];
            return cell;
        }else if ([_model.piType isEqualToString:@"SPGL"]) {  // 开票
            SPListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spListCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell refreSPListUIWithData:self.xmProject];
            return cell;
        }
        
    }
    if ([_model.piType isEqualToString:@"BK"]) {    // 拨付会签单管理
        if (indexPath.section == 2) {
            //
            HQDForRepaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repayCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleArr = @[@"分项类型",@"分项比例(%)",@"分项金额(元)",@"预计拨付金额(元)",@"累计已拨付金额(元)",
                              @"未拨付金额(元)",@"备注"];
            if (self.itemized.count) {
                [cell referRepayWithModel:self.itemized[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
        } else if (indexPath.section == 3) {
            // 显示审批附件
            ApproveEnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aeCell" forIndexPath:indexPath];
            cell.ApproveEnclosureCelldelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.EnclosureData.count) {
                [cell referUIWithModel:self.EnclosureData[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
        } else if (indexPath.section == 4) {
            NowPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nowPhotosCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.nowPhotos.count) {
                [cell loadNowPhotosFromData:self.nowPhotos];
            }
            return cell;
        } else if (indexPath.section == 5) {
            // 显示审批流程UI
            ApproveProcedureCell *cell = [[ApproveProcedureCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.isOldDocType = self.isType;
            cell.passHeightDelegate = self;
            [cell refreAPCellUIWithModel:self.procedureData[indexPath.row]];
            if (indexPath.row == self.procedureData.count) {
                [self.activity stopAnimating];
                _activityView.hidden = YES;
            }
            return cell;
        }
    }else {
        if (indexPath.section == 2) {
            // 显示审批附件
            ApproveEnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aeCell" forIndexPath:indexPath];
            cell.ApproveEnclosureCelldelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.EnclosureData.count) {
                [cell referUIWithModel:self.EnclosureData[indexPath.row]];
                return cell;
            }else {
                return nil;
            }
        } else if (indexPath.section == 3) {
            NowPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nowPhotosCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.nowPhotos.count) {
                [cell loadNowPhotosFromData:self.nowPhotos];
            }
            return cell;
        }  else if (indexPath.section == 4) {
            // 显示审批流程UI
            ApproveProcedureCell *cell = [[ApproveProcedureCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.ApproveTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.isOldDocType = self.isType;
            cell.passHeightDelegate = self;
            [cell refreAPCellUIWithModel:self.procedureData[indexPath.row]];
            if (indexPath.row == self.procedureData.count) {
                [self.activity stopAnimating];
                _activityView.hidden = YES;
            }
            return cell;
        }
    }
    return nil;
}

#pragma mark -----ApproveEnclosureCellDelegate-----
- (void)EnclosureCellPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --传递UI高度--
- (void)passHeightFromNKDJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromLWHT:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromSPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromKPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromLWJSKCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromLWJDKCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromLWFBHT:(CGFloat)height
{
    _height = height;
}

- (void)changeApproveHeight:(CGFloat)heith
{
    _height = heith;
}

- (void)passHeightFromXMCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromTBBHAndXMBHCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromHTYYCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromSWWJAndGCLWJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMBZJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromTXMBZJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromTBBZJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromTTBBZJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromFPSJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromYBBXCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJSXCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromWTSCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromYBJKSQCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMFZRCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMKZCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromZMSCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromBSJJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJYCWZLCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMBXCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMZJSQCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromWJZCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromLKDJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromBFHQDCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromLWFKCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMDFCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJKBXCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJKSQCell:(CGFloat)height
{
    _height = height;
}

- (void)passLwClCellHeight:(CGFloat)height
{
    _height = height;
}

- (void)passLKCellHeight:(CGFloat)height
{
    _height = height;
}

- (void)passCostCellHeight:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromCCSPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromYZHSCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromCFSPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromGCYWCCCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromIDQXCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromIDZKCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromQJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromRSXQCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromSBGJJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromPXSPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJSJSBCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromWPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromWPDHMCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromERPLCBGCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJSCYLYCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromHTSPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJDCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromYWCCCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromMPCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromYPSGCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromRSLHCell:(CGFloat)height

{
    _height = height;
}

- (void)passHeightFromYZWCCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromZBCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromFWGZCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromSGCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromSJCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromHYJYCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromCLCGFKCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromCGHTCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMYSCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromHTBGCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromBCHTCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromBCHT:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromFWGZ:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromXMTBPS:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromTBCHCell:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromTBCH:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromYHKH:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromBXMX:(CGFloat)height
{
    _height = height;
}

- (void)passAPCellHeight:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromZBDL:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromDKBKSQ:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromJCBG:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromDAM:(CGFloat)height
{
    _height = height;
}

- (void)passHeightFromZYLKCell:(CGFloat)height
{
    _height = height;
}
- (void)passHeightFromYCGZCell:(CGFloat)height
{
    _height = height;
}
// 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([_model.piType isEqualToString:@"YXBB"]) {
            return kscreenHeight*0.7;
        }else {
            return _height;
        }
    }else if (indexPath.section == 1) {
        // 报销内容
        if ([_model.piType isEqualToString:@"XMFZR"]) {
            return 110;
        }else if ([_model.piType isEqualToString:@"CLCGFK"] || [_model.piType isEqualToString:@"CLCGYFK"] || [_model.piType isEqualToString:@"CGHT"] || [_model.piType isEqualToString:@"KP"] || [_model.piType isEqualToString:@"SPGL"]) {
            return ((self.xmProject.count+1) * 25) + 20;
        }else if ([_model.piType isEqualToString:@"IDZKSQ"]) {
            return 125;
        }else if ([_model.piType isEqualToString:@"LWFK"] || [_model.piType isEqualToString:@"CLFK"] || [_model.piType isEqualToString:@"LKDJ"] || [_model.piType isEqualToString:@"BK"] || [_model.piType isEqualToString:@"BCHT"]) {
            return _height;
        }else if ([_model.piType isEqualToString:@"FWGZ"]) {
            return _height;
        }else if ([_model.piType isEqualToString:@"YBBX"] || [_model.piType isEqualToString:@"TBCH"]) {
            return _height;
        }else if ([_model.piType isEqualToString:@"XMBX"] || [_model.piType isEqualToString:@"JKBX"]) {
            return 90;
        }
        else {
            return 0;
        }
    }
    if ([_model.piType isEqualToString:@"BK"]) {
        if (indexPath.section == 2) {
            return 160;
        }else if (indexPath.section == 3) {
            // 审批附件UI高度
            return 100;
        }else if (indexPath.section == 4) {
            // 现场照片
            return _shang*((kscreenWidth-40)/3) + (_shang * 10);
        }else if (indexPath.section == 5) {
            // 审批流UI高度
            return _height;
        }else {
            return 0;
        }
    }else {
        if (indexPath.section == 4) {
            // 审批流UI高度
            return _height;
        }else if (indexPath.section == 2) {
            // 审批附件UI高度
            return 100;
        }else if (indexPath.section == 3) {
            // 现场照片
            return _shang*((kscreenWidth-40)/3) + (_shang * 10);
        }else {
            return 0;
        }
    }
}

// 判断table是否加载完成
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

// 判断Tab是否滑动到底部
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffsetY;
//    NSLog(@"height--%f,contentOffsetY--%f,distanceFromBottom--%f",height,contentOffsetY,distanceFromBottom);
    if (distanceFromBottom <= height)
    {
        if (self.isSlide) {
            // 滑动到底部
            self.ApproveTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, distanceFromBottom, kscreenWidth, 0)];
        }else {
            self.ApproveTable.tableFooterView = [[UIView alloc] init];
        }
    }
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsPre:(BOOL)isP;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isP) {
            // 回到上个页面
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
