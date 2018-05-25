//
//  Header.h
//  hjoa
//
//  Created by 华剑 on 2017/3/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "DataBaseManager.h"

// 获取屏幕尺寸
#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
#define Iphone6Scale(x) ((x) * kscreenWidth / 375.0f)

#define WX_App_ID           @"wx20243e2d74a621b8"            // URL Schemes
#define WX_AppSecret        @"96c44041e52c7c345de29366c468782d"
// 需要在微信·开放平台申请微信开放平台微信登录AppID、AppSecret
#define WX_ACCESS_TOKEN     @"access_token"
#define WX_OPEN_ID          @"openid"
#define WX_REFRESH_TOKEN    @"refresh_token"
#define WX_BASE_URL         @"https://api.weixin.qq.com/sns"

// 内网url
#define intranetURL @"http://10.1.30.68"
//10.1.30.68
//10.1.20.28                //  许
//10.1.20.29                //  吕
//10.1.20.27                //  涛
//10.1.20.26                //
//http://10.1.30.9:8080
//10.1.130.88

// 外网URL
#define outsideURL @"http://www.szhjerp.com"

// 头像url
#define headImageURL @"http://www.szhjerp.com/"

// 存储地址
#define preservePATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

// 登录页面 与推送url 是一样的  后面多加两个参数/paUserInfo/userLogin
#define LOGINURL [NSString stringWithFormat:@"%@/paUserInfo/userLogin",intranetURL]
//外网 http://www.szhjerp.com/hj/paUserInfo/userLogin?uiAccount=admin&uiPassword=admin666

// 推送  与登录url一样，多加两个参数
#define PushTokenURL @"http://10.1.30.68:8080/hj/oaUserinfo/loginUser?uiAccount= admin&&uiPassword=admin666&&pushid=%@&&deviceOS=iOS"

// 通讯录
#define addressULR [NSString stringWithFormat:@"%@/paUserInfo/findByLive",intranetURL]
//@"http://10.1.30.68:8080/hj/oaUserinfo/finByLive?params=0"

//  我的申请    params="审批状态,人员ID"&offset=第多少页
#define myApproveURL [NSString stringWithFormat:@"%@/apApprovalstatus/myApplication",intranetURL]
//更新接口 http://10.1.30.9:8080/hjerp/apApprovalstatus/myApplication?userId=1&page=1&rows=15

//  我的审批
// http://10.1.30.9:8080/hjerp/apApprovalreceive/mbfindByAll?uiId=1&page=1&rows=15
#define approveListURL [NSString stringWithFormat:@"%@/apApprovalreceive/mbfindByAll",intranetURL]


// 点击申请
/**
 http://10.1.30.68:8081/hjerp/apApprovalreceive/findBypiId?piId=510&piType=YBSQ
 */
//#define clickApproveDetailsURL [NSString stringWithFormat:@"%@/hjerp/apApprovalreceive/findBypiId",intranetURL]
#define generalCost [NSString stringWithFormat:@"%@/oaGeneralApplyRecord/findById",intranetURL]

// 点击审批
#define docData [NSString stringWithFormat:@"%@/oaDocData/findById",intranetURL]

// 审批流程Url
//http://10.1.30.68:8081/hjerp/apApprovalreceive/findBypiId?piId=510&piType=YBSQ
#define approveProcedureUrl [NSString stringWithFormat:@"%@/apApprovalreceive/findBypiId",intranetURL]

// 新考勤 打卡信息 (已改)
#define newsRecordsUrl [NSString stringWithFormat:@"%@/caCardRecords/findAllByUiid",intranetURL]

// 新考勤 查询某日打卡信息 (已改)
#define inquiryRecordNewsUrl [NSString stringWithFormat:@"%@/caCardRecords/findRecordByDayAndUiId",intranetURL]

// 新考勤 上传打卡信息   (已改)
#define senderRecordNewsUrl [NSString stringWithFormat:@"%@/caCardRecords/save",intranetURL]

// 新考勤 查询考勤记录  我的考勤数据   (已改)
#define myRecordUrl [NSString stringWithFormat:@"%@/caCardRecords/findMyRecord",intranetURL]

// 新考勤 考勤月历 -> 月历数据查询   (已改)
#define monthCalenderUrl [NSString stringWithFormat:@"%@/caCardRecords/findRecordByDayAndUiId",intranetURL]

// 项目管控 -> 项目情况
#define projectPandectUrl [NSString stringWithFormat:@"%@/projectPandect/findProjectPandect",intranetURL]

// 项目管控 -> 完成进度
#define finishProgressUrl [NSString stringWithFormat:@"%@/bsScheduleform/findalltoContent",intranetURL]
// 项目管控 -> 完成进度详情
#define finishXQUrl [NSString stringWithFormat:@"%@/bsScheduleform/findall_info_to",intranetURL]

// 项目管控 -> 合同总额
#define contractMoneyUrl [NSString stringWithFormat:@"%@/bsProjectcontract/findContractBypiId",intranetURL]

// 项目管控 -> 收款进度
#define paymentScheduleUrl [NSString stringWithFormat:@"%@/rsSelfPayeeRecord/findByAll",intranetURL]

// 项目管控 -> 开票
#define billingUrl [NSString stringWithFormat:@"%@/fnOpenInvoice/findByAll",intranetURL]

// 项目管控 -> 合同支出
#define contractExpenditureUrl [NSString stringWithFormat:@"%@/projectPandect/findContractPayeeBypiId",intranetURL]
// 项目管控 -> 材料合同支出   piId=5559&page=1&rows=10
#define contractCLUrl [NSString stringWithFormat:@"%@/mcMaterialContract/findByAll",intranetURL]
// 项目管控 -> 劳务合同支出   piId=5559&page=1&rows=10
#define contractLWUrl [NSString stringWithFormat:@"%@/rsLabourcontract/findByAll",intranetURL]

// 新考勤 统计界面->月统计 (领导权限查看)   (已改)
#define monthRecordUrl [NSString stringWithFormat:@"%@/caCardRecords/findMouthManRecord",intranetURL]

// 新考勤 排行榜界面 -> 早到榜             (已改)
#define earlyListUrl [NSString stringWithFormat:@"%@/caCardRecords/findEarlyArrival",intranetURL]

// 新考勤 排行榜界面 -> 勤奋榜             (已改)
#define hardListUrl [NSString stringWithFormat:@"%@/caCardRecords/findHardWork",intranetURL]

// 新考勤 排行榜界面 -> 迟到榜             (已改)
#define lateListUrl [NSString stringWithFormat:@"%@/caCardRecords/findLateArrival",intranetURL]

// 新考勤 统计界面 -> 打卡明细             (已改)
#define recordDetailedUrl [NSString stringWithFormat:@"%@/caCardRecords/findManRecord",intranetURL]

// 新考勤 统计界面 -> 未激活              (已改)
#define recordNotActiveUrl [NSString stringWithFormat:@"%@/caCardRecords/findByInactive",intranetURL]

//  补卡申请
#define applyRecordUrl [NSString stringWithFormat:@"%@/caCardApplication/saveAndSubmit",intranetURL]


// 审批表单接口 固定接口
#define officailDocumentListURL [NSString stringWithFormat:@"%@/oaDocType/findByAll",intranetURL]

// 审批表单详情接口 http://10.1.30.68:8081/hjerp/oaDocFromName/findByIdtype?fnIdtype=YZHS
#define FormDetailsURL [NSString stringWithFormat:@"%@/oaDocFromName/findByIdtype",intranetURL]

// 审批按钮上传参数
#define postApproveButStatus [NSString stringWithFormat:@"%@/apApprovalreceive/save",intranetURL]

// 延审按钮上传参数
#define postLateApproveButStatus [NSString stringWithFormat:@"%@/apApprovalstatus/insertDelayed",intranetURL]

// 审批附件接口   申请文件的id"piId":"123"，审批类型"piType":"YBSQ"
#define documentsApprove [NSString stringWithFormat:@"%@/cmAttachmentInformation/loadFile",intranetURL]

//  制度管理->下载
#define downUrl [NSString stringWithFormat:@"%@/oaManageSystem/findByClassifyForApp",intranetURL]

//  企业要闻
#define news [NSString stringWithFormat:@"%@/oaNewsAnnouncement/findAll",intranetURL]

//  领导人信息
#define leadDataUrl [NSString stringWithFormat:@"%@/paStructure/findById?params=",intranetURL]

//  特定项目
#define specialPjtUrl [NSString stringWithFormat:@"%@/bsProjectinfo/findByAll",intranetURL]

//  SG项目 检查报告
#define sgCheckPjtUrl [NSString stringWithFormat:@"%@/bsProjectcontract/finByPageSearchsgType",intranetURL]

//  周报
#define weeklyUrl [NSString stringWithFormat:@"%@/PaWeekly/saveAndSubmit",intranetURL]

//  项目报销
#define projectCostUrl [NSString stringWithFormat:@"%@/projectCostRsApply/saveAndSubmit",intranetURL]

//  一般费用报销
#define ybbxUrl [NSString stringWithFormat:@"%@/oaGeneralExpenses/saveAndSubmit",intranetURL]

//  请假申请
#define qjsqUrl [NSString stringWithFormat:@"%@/oaDocleaveApply/saveAndSubmit",intranetURL]

//  出差申请
#define ccUrl [NSString stringWithFormat:@"%@/oaDocEvectionApprove/saveAndSubmit",intranetURL]

//  检查报告
#define jcbgUrl [NSString stringWithFormat:@"%@/bsInspectionreport/saveAndSubmint",intranetURL]

//  文档管理->下载
#define docDownUrl [NSString stringWithFormat:@"%@/paRecord/find_phone",intranetURL]

//  文档列表->查找
#define wdjcUrl [NSString stringWithFormat:@"%@/paRecord/find_phone",intranetURL]

//  文档列表->申请
#define wdsqUrl [NSString stringWithFormat:@"%@/paRecordMy/saveAndSubmint",intranetURL]

//  质量检查->列表
#define qcListUrl [NSString stringWithFormat:@"%@/bsInspectionreport/findByAll_phone",intranetURL]

//  质量检查->详情
#define qcDetailsUrl [NSString stringWithFormat:@"%@/bsInspectionreport/findById_phone",intranetURL]

//  质量检查->创建上传
#define qcCreatUrl [NSString stringWithFormat:@"%@/bsInspectionreport/saveAndSubmint",intranetURL]

//  质量整改->列表
#define qchangeListUrl [NSString stringWithFormat:@"%@/bsQualityimprovement/findByAll",intranetURL]

//  生成整改单 -> 按钮接口
#define creatRectify [NSString stringWithFormat:@"%@/bsQualityimprovement/save",intranetURL]

//  整改单详情
#define qrUrl [NSString stringWithFormat:@"%@/bsQualityimprovement/findByIdAll",intranetURL]

//  回复
#define qcRelpyUrl [NSString stringWithFormat:@"%@/bsRectificationrecheck/save",intranetURL]

//  回复上传图片
#define qcUploadImage [NSString stringWithFormat:@"%@/cmAttachmentInformation/save",intranetURL]

#endif /* Header_h */
