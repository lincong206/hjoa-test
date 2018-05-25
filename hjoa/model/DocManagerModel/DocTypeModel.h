//
//  DocTypeModel.h
//  hjoa
//
//  Created by 华剑 on 2017/12/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface DocTypeModel : JSONModel

@property (strong, nonatomic) NSDictionary *cmAttachmentInformation;    // 文件信息

@property (strong, nonatomic) NSString *rfDescribe; // 档案描述
@property (strong, nonatomic) NSString *rfOthers;   // 档案描述
@property (strong, nonatomic) NSString *rfStatus;   // 状态
@property (strong, nonatomic) NSString *rfCreattime;// 时间

@end
