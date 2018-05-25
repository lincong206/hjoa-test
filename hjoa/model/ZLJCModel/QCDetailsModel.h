//
//  QCDetailsModel.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface QCDetailsModel : JSONModel
@property (strong, nonatomic) NSString *birTheme;                  // 主题
@property (strong, nonatomic) NSString *birId;                  // 主键
@property (strong, nonatomic) NSString *birTime;                // 时间
@property (strong, nonatomic) NSString *birEntryperson;         // 检查人。记录人
@property (strong, nonatomic) NSString *birContent;             // 检查项
@property (strong, nonatomic) NSString *birInspectionresult;    // 检查结果
@property (strong, nonatomic) NSString *birResultstate;         // 检查结果状态
@property (strong, nonatomic) NSString *birExamined;            // 性质
@property (strong, nonatomic) NSString *uiName;                 // 通知人
@property (strong, nonatomic) NSString *piName;                 // 项目名
@property (strong, nonatomic) NSString *birRectification;                 // 是否生成整改单

@end
