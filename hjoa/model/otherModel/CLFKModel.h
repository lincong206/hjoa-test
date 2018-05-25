//
//  CLFKModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface CLFKModel : JSONModel

@property (strong, nonatomic) NSString *mcdName;
@property (strong, nonatomic) NSString *mcdBrand;
@property (strong, nonatomic) NSString *mcdModel;
@property (strong, nonatomic) NSString *mcdSpecification;
@property (strong, nonatomic) NSString *mcdUnit;
@property (strong, nonatomic) NSString *mcdNum;
@property (strong, nonatomic) NSString *mcdPrice;
@property (strong, nonatomic) NSString *mcdMoney;
@property (strong, nonatomic) NSString *mcdRemark;

@end
