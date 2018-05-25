//
//  DataCountModel.h
//  hjoa
//
//  Created by 华剑 on 2017/11/1.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface DataCountModel : JSONModel

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *gross;
@property (strong, nonatomic) NSString *currentStatus;
@property (strong, nonatomic) NSString *completionRate;

@end
