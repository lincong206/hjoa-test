//
//  RSLHModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface RSLHModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dpsaDept;
@property (strong, nonatomic) NSString *dpsaCreatetime;
@property (strong, nonatomic) NSString *dpsaDirthday;
@property (strong, nonatomic) NSString *dpsaNativeplace;
@property (strong, nonatomic) NSString *dpsaJob;
@property (strong, nonatomic) NSString *dpsaCulture;
@property (strong, nonatomic) NSString *dpsaJobtitle;
@property (strong, nonatomic) NSString *dpsaEmploytime;
@property (strong, nonatomic) NSString *dpsaReason;

@end
