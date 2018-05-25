//
//  YWCCModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface YWCCModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *dbeaDept;
@property (strong, nonatomic) NSString *uiPost;
@property (strong, nonatomic) NSString *dbeaUiname;
@property (strong, nonatomic) NSString *dbeaEvectiondate;
@property (strong, nonatomic) NSString *dbeaEvectionenddate;
@property (strong, nonatomic) NSString *dbeaEvectiondatenum;
@property (strong, nonatomic) NSString *dbeaAddress;
@property (strong, nonatomic) NSString *dbeaProjectname;
@property (strong, nonatomic) NSString *dbeaPrincipal;
@property (strong, nonatomic) NSString *dbeaPhone;
@property (strong, nonatomic) NSString *dbeaCharge;
@property (strong, nonatomic) NSString *dbeaEvectionreason;
@property (strong, nonatomic) NSString *dbeaRemark;

@end
