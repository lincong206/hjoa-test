//
//  YZHSModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface YZHSModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dsrDept;
@property (strong, nonatomic) NSString *dsrDate;
@property (strong, nonatomic) NSString *dsrName;
@property (strong, nonatomic) NSString *dsrRecycletime;
@property (strong, nonatomic) NSString *dsrSealname;
@property (strong, nonatomic) NSString *dsrProjectname;
@property (strong, nonatomic) NSString *dsrRemark;
@property (strong, nonatomic) NSString *dsrResponsible;
@property (strong, nonatomic) NSString *dsrSealbackups;

@end
