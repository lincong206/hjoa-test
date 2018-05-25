//
//  DAMModel.h
//  hjoa
//
//  Created by 华剑 on 2017/12/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface DAMModel : JSONModel
@property (strong, nonatomic) NSString *rfmIdnum;
@property (strong, nonatomic) NSString *rfmCreattime;
@property (strong, nonatomic) NSString *rfmUiname;
@property (strong, nonatomic) NSString *rfmDescribe;
@property (strong, nonatomic) NSString *rfmOthers;
@property (strong, nonatomic) NSString *rfmReason;
@property (strong, nonatomic) NSString *rfmStatus;
@end
