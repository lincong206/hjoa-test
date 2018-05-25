//
//  ZHTEModel.h
//  hjoa
//
//  Created by 华剑 on 2018/1/24.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ZHTEModel : JSONModel
// 总合同额
@property (strong, nonatomic) NSString *contractName;   // 项目
@property (strong, nonatomic) NSString *contractPrice;  // 金额
@property (strong, nonatomic) NSString *contractDate;   // 时间
@property (strong, nonatomic) NSString *projectAddress; // 地址
@property (strong, nonatomic) NSString *contractType;   // 类型
@property (strong, nonatomic) NSString *contractId;   // 
// 完成进度 明细
@property (strong, nonatomic) NSString *scVerifytime;   // 时间
@property (strong, nonatomic) NSString *seId;
@property (strong, nonatomic) NSString *scAccumulated;  // 进度
@property (strong, nonatomic) NSDictionary *bsSchedule;        // 项目编号piIdnum  项目经理paProjectleader
// 收款进度
@property (strong, nonatomic) NSString *piBuildcompany;   // 来款单位
@property (strong, nonatomic) NSString *sprId;  // 详情id
@property (strong, nonatomic) NSString *sprIdtype;  // 类型
@property (strong, nonatomic) NSString *uiManagername;  // 建设单位联系人
@property (strong, nonatomic) NSString *sprCurrentpaymoney; // 本次来款
@property (strong, nonatomic) NSString *sprCurrentpaydate; // 来款时间
// 开票
@property (strong, nonatomic) NSString *oiInvoicetitle;   // 发票/收据单位名称
@property (strong, nonatomic) NSString *oiTaxinclusive;  // 开票金额
@property (strong, nonatomic) NSString *oiCreatetime;  // 开票时间
@property (strong, nonatomic) NSString *trIdtype;  // 开票类型
@property (strong, nonatomic) NSString *trId;
// 合同支出
@property (strong, nonatomic) NSString *type;  // 名字
@property (strong, nonatomic) NSString *contractNum;  // 合同数量
@property (strong, nonatomic) NSString *priceTotal;  // 合同金额

@end
