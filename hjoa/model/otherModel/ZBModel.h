//
//  ZBModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/14.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ZBModel : JSONModel

@property (strong, nonatomic) NSString *wkType;
@property (strong, nonatomic) NSString *wkDate;
@property (strong, nonatomic) NSString *wkCodetype;
@property (strong, nonatomic) NSString *wkPost;
@property (strong, nonatomic) NSString *wkDepartment;
@property (strong, nonatomic) NSString *wkEntryname;
@property (strong, nonatomic) NSString *wkTitle;
@property (strong, nonatomic) NSString *wkFinishworkweek;
@property (strong, nonatomic) NSString *wkSummaryworkweek;
@property (strong, nonatomic) NSString *wkWorkplannext;
@property (strong, nonatomic) NSString *wkNeedcoordination;
@property (strong, nonatomic) NSString *wkCompant;
@property (strong, nonatomic) NSString *wkCode;
@end
