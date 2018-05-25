//
//  officeListModel.h
//  hjoa
//
//  Created by 华剑 on 2017/4/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface officeListModel : JSONModel

@property (strong, nonatomic) NSString *dtId;       //公文类型主键Id
@property (strong, nonatomic) NSString *dtIdtype;   //公文类型
@property (strong, nonatomic) NSString *dtName;     //公文名称
@property (strong, nonatomic) NSString *dtPid;      //公文类型级
@property (strong, nonatomic) NSString *dtSort;     //排序

@end
