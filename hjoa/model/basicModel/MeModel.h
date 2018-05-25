//
//  MeModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface MeModel : JSONModel

@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *text;          

@property (strong, nonatomic) NSString *orgNum;
@property (strong, nonatomic) NSString *orgName;

@end
