//
//  QJSQModel.h
//  hjoa
//
//  Created by 华剑 on 2017/7/14.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface QJSQModel : JSONModel

@property (strong, nonatomic) NSString *asName;
@property (strong, nonatomic) NSString *asId;   //  /*审批步骤id*/
@property (strong, nonatomic) NSString *alId;        /*角色id*/
@property (strong, nonatomic) NSString *asRoletype;     //  1：有上级领导 0：没有
@property (strong, nonatomic) NSString *asType;         /* 0审批 ，1送阅*/
@property (strong, nonatomic) NSArray *paUserinfo;      //  个人信息
@property (strong, nonatomic) NSString *relation;       // 显示图片
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *headImage;
@property (strong, nonatomic) NSString *uiId;

@end
