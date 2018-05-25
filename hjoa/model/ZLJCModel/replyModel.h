//
//  replyModel.h
//  hjoa
//
//  Created by 华剑 on 2018/4/20.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface replyModel : JSONModel

@property (strong, nonatomic) NSString *fjContent;
@property (strong, nonatomic) NSString *fjUiId;
@property (strong, nonatomic) NSString *fjTime;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSMutableArray *fjImageArr;

@property (strong, nonatomic) NSString *zgContent;
@property (strong, nonatomic) NSString *zgUiId;
@property (strong, nonatomic) NSString *zgTime;
@property (strong, nonatomic) NSMutableArray *zgImageArr;
@end
