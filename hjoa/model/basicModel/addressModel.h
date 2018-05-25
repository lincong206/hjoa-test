//
//  addressModel.h
//  hjoa
//
//  Created by 华剑 on 2017/3/16.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface addressModel : JSONModel

@property (strong, nonatomic) NSString *psId;           // 部门id
@property (strong, nonatomic) NSString *pfId;           // 分公司id

@property (strong, nonatomic) NSString *uiBranchname;         // 分公司名字
@property (strong, nonatomic) NSString *uiAccount;      // 账号
@property (strong, nonatomic) NSString *uiHeadimage;    // 头像
@property (strong, nonatomic) NSString *uiId;           // 用户id
@property (strong, nonatomic) NSString *uiLive;         // 是否删除

@property (strong, nonatomic) NSString *uiMobile;       // 手机号码
@property (strong, nonatomic) NSString *uiName;         // 用户名
//@property (strong, nonatomic) NSString *uiOnline;       // 是否在线

@property (strong, nonatomic) NSString *uiSex;          // 性别

@property (strong, nonatomic) NSString *uiSignature;    // 签名
@property (strong, nonatomic) NSString *uiPsname;         // 部门名

@property (strong, nonatomic) NSMutableArray *arr;

@property (strong, nonatomic) NSString *status; // 状态
@end
