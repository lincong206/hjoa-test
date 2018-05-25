//
//  QJModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface QJModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dlaInitiatordept;
@property (strong, nonatomic) NSString *dalCreatetime;
@property (strong, nonatomic) NSString *dalName;
@property (strong, nonatomic) NSString *dalDept;
@property (strong, nonatomic) NSString *dalJob;
@property (strong, nonatomic) NSString *dalLeavetype;
@property (strong, nonatomic) NSString *dalLeavestarttime;
@property (strong, nonatomic) NSString *dalLeaveendtime;
@property (strong, nonatomic) NSString *dalLeaveday;
@property (strong, nonatomic) NSString *dalOffsettime;
@property (strong, nonatomic) NSString *dalReason;
@property (strong, nonatomic) NSString *dalRemark;

@end
