//
//  officeModel.h
//  hjoa
//
//  Created by 华剑 on 2017/3/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface officeModel : JSONModel

@property (strong, nonatomic) NSString *apName;             // 审批流程名称
@property (strong, nonatomic) NSString *astStatus;          // 操作状态 -- 我的申请
@property (strong, nonatomic) NSString *arvStatus;          // 操作状态 -- 我的审批
@property (strong, nonatomic) NSString *arvState;           // 延时审批操作状态
@property (strong, nonatomic) NSString *piId;               // 功能编号
@property (strong, nonatomic) NSString *astId;              // 审批编号
@property (strong, nonatomic) NSString *piType;             // 审批项目类型
@property (strong, nonatomic) NSString *uid;                // 发起人ID
@property (strong, nonatomic) NSString *astModifiedtime;    // 修改时间
@property (strong, nonatomic) NSString *astCreatetime;      // 创建时间
@property (strong, nonatomic) NSString *astDocname;         // 审批项目的名称
@property (strong, nonatomic) NSString *uiId;               // 当前审批人id
@property (strong, nonatomic) NSString *arvId;              // 步骤id
@property (strong, nonatomic) NSString *asrId;              // 节点id
@property (strong, nonatomic) NSString *asrSort;            // 排序序号
@property (strong, nonatomic) NSString *asrApprovaltype;    // 状态

@property (strong, nonatomic) NSString *asrName;            // 审批

@end
