//
//  IDQXModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface IDQXModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dijeInitiatordept;
@property (strong, nonatomic) NSString *dijeCreatetime;
@property (strong, nonatomic) NSString *dijeApplyname;
@property (strong, nonatomic) NSString *dijeApplydept;
@property (strong, nonatomic) NSString *dijeApplyjob;
@property (strong, nonatomic) NSString *dijeAddauthority;
@property (strong, nonatomic) NSString *dijeNature;
@property (strong, nonatomic) NSString *dijeBegintime;
@property (strong, nonatomic) NSString *dijeEndtime;
@property (strong, nonatomic) NSString *dijeReason;

@end
