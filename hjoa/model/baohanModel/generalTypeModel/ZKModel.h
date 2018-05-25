//
//  ZKModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/14.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ZKModel : JSONModel

@property (strong, nonatomic) NSString *dicpName;
@property (strong, nonatomic) NSString *dicpSex;
@property (strong, nonatomic) NSString *dicpDept;
@property (strong, nonatomic) NSString *dicpJob;
@property (strong, nonatomic) NSString *dicpEnglishname;
@property (strong, nonatomic) NSString *dicpJurisdiction;

@end
