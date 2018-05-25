//
//  FormListModel.h
//  hjoa
//
//  Created by 华剑 on 2017/4/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface FormListModel : JSONModel

@property (strong, nonatomic) NSString *fnId;       //主键Id
@property (strong, nonatomic) NSString *fnIdtype;   //公文类型
@property (strong, nonatomic) NSString *fnName;     //公文名称
@property (strong, nonatomic) NSString *fnMust;     //是否为必填字段 0:false;1:true
@property (strong, nonatomic) NSString *fnTitle;    //字段名
@property (strong, nonatomic) NSString *fnFormat;   //输入框类型
@property (strong, nonatomic) NSString *fnOption;   //选项(例如：男,女)
@property (strong, nonatomic) NSString *fnSort;     //字段排序(隐藏字段排在最后)
@property (strong, nonatomic) NSString *fnLive;     //字段是否隐藏?  0:true;1:false

@end
