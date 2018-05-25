//
//  QueryNameModel.h
//  hjoa
//
//  Created by 华剑 on 2017/10/9.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface QueryNameModel : NSObject

@property (strong, nonatomic) NSString *uiId;
@property (strong, nonatomic) NSString *psName;
@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *uiImg;

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *time;

@property (strong, nonatomic) NSString *groupName;
@property (strong, nonatomic) NSArray *groupData;
@property (assign, nonatomic) BOOL isOpen;

@end
