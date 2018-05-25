//
//  YBBXModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface YBBXModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dpName;
@property (strong, nonatomic) NSString *geFunduse;
@property (strong, nonatomic) NSString *geCreatetime;
@property (strong, nonatomic) NSString *geGui;
@property (strong, nonatomic) NSString *gePaytype;
@property (strong, nonatomic) NSString *geIsdeduction;
@property (strong, nonatomic) NSString *geTotalmoney;
@property (strong, nonatomic) NSString *geTotalmoneyupper;
@property (strong, nonatomic) NSString *gePayeeunit;
@property (strong, nonatomic) NSString *geOpenbank;
@property (strong, nonatomic) NSString *geBankaccount;
@property (strong, nonatomic) NSString *geRemark;

@end
