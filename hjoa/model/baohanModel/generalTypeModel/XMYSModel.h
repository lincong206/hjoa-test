//
//  XMYSModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface XMYSModel : JSONModel

@property (strong, nonatomic) NSDictionary *bsProjectinfo;
@property (strong, nonatomic) NSDictionary *bsProjectPre;

@property (strong, nonatomic) NSString *ptTaskstatus;

@end
