//
//  ApproveEnclosureModel.h
//  hjoa
//
//  Created by 华剑 on 2017/5/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface ApproveEnclosureModel : JSONModel

@property (strong, nonatomic) NSString *baiUrl;       // 文件路径
@property (strong, nonatomic) NSString *baiSize;       // 文件大小
@property (strong, nonatomic) NSString *uiId;       // 申请人ID
@property (strong, nonatomic) NSString *baiTime;       // 创建时间
@property (strong, nonatomic) NSString *baiName;       // 文件名字
@property (strong, nonatomic) NSString *baiSubsequent;  // 文件后缀
@property (strong, nonatomic) NSString *piType;         // 类型 (制度管理需要用到)

@end
