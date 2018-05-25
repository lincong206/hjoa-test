//
//  JYCWZLModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface JYCWZLModel : JSONModel

@property (strong, nonatomic) NSString *bfdIdnum;
@property (strong, nonatomic) NSString *bfdPsid;
@property (strong, nonatomic) NSString *bfdUiid;
@property (strong, nonatomic) NSString *bfdUipost;
@property (strong, nonatomic) NSString *bfdCreatetime;
@property (strong, nonatomic) NSString *bfdReturntime;
@property (strong, nonatomic) NSString *bfdBorrowcontent;
@property (strong, nonatomic) NSString *bfdUse;

@end
