//
//  JSXModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface JSXModel : JSONModel

@property (strong, nonatomic) NSString *bprType;
@property (strong, nonatomic) NSString *bprDate;
@property (strong, nonatomic) NSString *bprUnit;
@property (strong, nonatomic) NSString *bprReferences;
@property (strong, nonatomic) NSString *bprPhone;
@property (strong, nonatomic) NSString *bprNumber;
@property (strong, nonatomic) NSString *bprMatters;
@property (strong, nonatomic) NSString *bprValidity;
@property (strong, nonatomic) NSString *bprLssuedate;
@property (strong, nonatomic) NSString *bprNote;

@end
