//
//  NKDJModel.h
//  hjoa
//
//  Created by 华剑 on 2018/6/7.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface NKDJModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *emCreatetime;
@property (strong, nonatomic) NSString *emBorrowproject;
@property (strong, nonatomic) NSString *emAdvanceproject;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *emMoney;
@property (strong, nonatomic) NSString *emRemark;

@end
