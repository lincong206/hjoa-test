//
//  QCListModel.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface QCListModel : JSONModel

@property (strong, nonatomic) NSString *birId;
@property (strong, nonatomic) NSString *piName;
// 质量检查列表
@property (strong, nonatomic) NSString *birTime;
@property (strong, nonatomic) NSString *birEntryperson;
@property (strong, nonatomic) NSString *birContent;
@property (strong, nonatomic) NSString *birResultstate;
@property (strong, nonatomic) NSString *birRectification;

// 质量整改列表
@property (strong, nonatomic) NSString *bqiRequire;
@property (strong, nonatomic) NSString *uiId;
@property (strong, nonatomic) NSString *bqiRectificationstatus;
@property (strong, nonatomic) NSString *bqiReplydate;
@property (strong, nonatomic) NSString *bqiId;

@end
