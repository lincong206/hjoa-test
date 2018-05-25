//
//  SpecialPJTModel.h
//  hjoa
//
//  Created by 华剑 on 2017/7/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface SpecialPJTModel : JSONModel

@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *piAddresspca;
@property (strong, nonatomic) NSString *piCreatetime;

@property (strong, nonatomic) NSString *piBuildcompany;
@property (strong, nonatomic) NSString *uiBelongname;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *piId;   //  项目ID

@property (strong, nonatomic) NSString *bpcName;
@property (strong, nonatomic) NSString *piAdress;
@property (strong, nonatomic) NSString *pbcCreatdate;

@property (strong, nonatomic) NSString *rfId;    // 文档编号
@property (strong, nonatomic) NSString *rfIdnum;    // 文档编号
@property (strong, nonatomic) NSString *rfDescribe; // 文档描述
@property (strong, nonatomic) NSString *rfOthers;   // 文档描述
@property (strong, nonatomic) NSString *rfMold;     // 文档类型
@property (strong, nonatomic) NSString *rfStatus;   // 文档状态
@property (strong, nonatomic) NSString *rfCreattime;// 文档创建时间
@property (strong, nonatomic) NSString *rfProjecttype;//文档类型

@end
