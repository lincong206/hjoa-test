//
//  BusinssNewsModel.h
//  hjoa
//
//  Created by 华剑 on 2017/7/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface BusinssNewsModel : JSONModel

@property (strong, nonatomic) NSString *naId;
@property (strong, nonatomic) NSString *naIdtype;
@property (strong, nonatomic) NSString *naIdnum;
@property (strong, nonatomic) NSString *naCreatetime;
@property (strong, nonatomic) NSString *naTitle;
@property (strong, nonatomic) NSString *naContent;
@property (strong, nonatomic) NSString *naImg;
@property (strong, nonatomic) NSString *uiId;
@property (strong, nonatomic) NSString *naUiname;
@property (strong, nonatomic) NSString *naPsname;

@end
