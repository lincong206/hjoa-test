//
//  BSJJModel.h
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface BSJJModel : JSONModel

@property (strong, nonatomic) NSString *uiName;
@property (strong, nonatomic) NSString *pbjCreatetime;
@property (strong, nonatomic) NSString *piManagername;
@property (strong, nonatomic) NSString *piPhone;
@property (strong, nonatomic) NSString *piName;
//@property (strong, nonatomic) NSString *piBuildcompany;// 建设单位
//@property (strong, nonatomic) NSString *piAdress;// 工程地点
@property (strong, nonatomic) NSString *pbjBidtype;
@property (strong, nonatomic) NSString *pbjNum;
@property (strong, nonatomic) NSString *pbjEndtime;
//@property (strong, nonatomic) NSString *pbdTenderbond;//投标保证金
//@property (strong, nonatomic) NSString *pbdDeadline;//缴纳截止时间
//@property (strong, nonatomic) NSString *pbdMentoringname;//标书答疑联系人
//@property (strong, nonatomic) NSString *pbdMentoringcontactway;//联系方式
//@property (strong, nonatomic) NSString *pbdMentoringtenderbond;//对招标文件提出疑问的截止时间
@property (strong, nonatomic) NSString *pbjAuthorizedman;
@property (strong, nonatomic) NSString *pbjArchitect;
@property (strong, nonatomic) NSString *pbjIsarrive;
@property (strong, nonatomic) NSString *pbjIsspecialrequirements;
@property (strong, nonatomic) NSString *pbjIsoriginalcopy;
@property (strong, nonatomic) NSString *pbjRemark;

@property (strong, nonatomic) NSDictionary *bidHandOverInfoVo;

@end
