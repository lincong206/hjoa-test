//
//  ApproveProcedureModel.h
//  hjoa
//
//  Created by 华剑 on 2017/5/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ApproveProcedureModel : JSONModel

// arvTime arvStatus asrName uiName
@property (strong, nonatomic) NSString *arvReceivetime;       // 时间
@property (strong, nonatomic) NSString *arvTime;
@property (strong, nonatomic) NSString *arvStatus;       // 审批状态
@property (strong, nonatomic) NSString *asrName;       // 级领导
@property (strong, nonatomic) NSString *uiName;       // 名字
@property (strong, nonatomic) NSString *arvRemark;      //  审批意见
@end
