//
//  ERPLCBGModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ERPLCBGModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *defcaDept;
@property (strong, nonatomic) NSString *defcaCreatetime;
@property (strong, nonatomic) NSString *defcaReason;
@property (strong, nonatomic) NSString *defcaName;
@property (strong, nonatomic) NSString *defcaNewflow;

@end
