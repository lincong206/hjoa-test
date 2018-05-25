//
//  DRDetailsModel.h
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface DRDetailsModel : JSONModel

// 基本信息
@property (strong, nonatomic) NSString *birTheme;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *birExamined;
@property (strong, nonatomic) NSString *birTime;
@property (strong, nonatomic) NSString *birEntryperson;
@property (strong, nonatomic) NSString *birContent;
@property (strong, nonatomic) NSString *birInspectionresult;

@property (strong, nonatomic) NSString *birResultstate;
@property (strong, nonatomic) NSString *bqiRectificationstatus;

// 整改过程
@property (strong, nonatomic) NSArray *bsRectificationrecheck;
// 回复中图片信息
@property (strong, nonatomic) NSArray *cmAttachmentinformation;
// 整改要求
@property (strong, nonatomic) NSString *bqiTime;
@property (strong, nonatomic) NSString *uiId;
@property (strong, nonatomic) NSString *bqiRequire;

@property (strong, nonatomic) NSString *brrId;  //提交回复需要用到

@end
