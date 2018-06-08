//
//  KPListModel.h
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface KPListModel : JSONModel

@property (strong, nonatomic) NSString *idType;
@property (strong, nonatomic) NSString *idNumber;
@property (strong, nonatomic) NSString *idCode;
@property (strong, nonatomic) NSString *idIncludeprice;
@property (strong, nonatomic) NSString *idRate;
@property (strong, nonatomic) NSString *idExincludeprice;
@property (strong, nonatomic) NSString *idTax;

@end
