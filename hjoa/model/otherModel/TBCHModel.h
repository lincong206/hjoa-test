//
//  TBCHModel.h
//  hjoa
//
//  Created by 华剑 on 2017/8/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JSONModel.h"

@interface TBCHModel : JSONModel

@property (strong, nonatomic) NSString *piIdnum;
@property (strong, nonatomic) NSString *piName;
@property (strong, nonatomic) NSString *piAddresspca;
@property (strong, nonatomic) NSString *piOperatecategory;
@property (strong, nonatomic) NSString *uiSourcename;
@property (strong, nonatomic) NSString *piBuildcompany;
@property (strong, nonatomic) NSString *uiManagername;
@property (strong, nonatomic) NSString *uiManagermobile;
@property (strong, nonatomic) NSString *uiBelongname;
@property (strong, nonatomic) NSString *piPrice;
@property (strong, nonatomic) NSString *piPartytype;
@property (strong, nonatomic) NSString *piBuildingtype;
@property (strong, nonatomic) NSString *piCategory;
@property (strong, nonatomic) NSString *piType;
@property (strong, nonatomic) NSString *piCreatetype;
@property (strong, nonatomic) NSString *piAptitudetype;

@property (strong, nonatomic) NSDictionary *bsProjectEnroll;
@property (strong, nonatomic) NSDictionary *bsProjectPre;
@property (strong, nonatomic) NSDictionary *bsProjectbidplot;

@property (strong, nonatomic) NSString *pbpPricebidworkaddress;
@property (strong, nonatomic) NSString *pbpPricebidcharge;
@property (strong, nonatomic) NSString *pbpPricebidusername;
@property (strong, nonatomic) NSString *pbpPricebidfinishtime;

@property (strong, nonatomic) NSString *pbpTechnicalbidaddress;
@property (strong, nonatomic) NSString *pbpTechnicalbidcharge;
@property (strong, nonatomic) NSString *pbpTechnicalbidusername;
@property (strong, nonatomic) NSString *pbpTechnicalbidfinish;

@property (strong, nonatomic) NSString *pbpCreditbidworkaddress;
@property (strong, nonatomic) NSString *pbpCreditbidcharge;
@property (strong, nonatomic) NSString *pbpCreditbidusername;
@property (strong, nonatomic) NSString *pbpCreditbidfinishtime;

@property (strong, nonatomic) NSString *pbpOtheraddress;
@property (strong, nonatomic) NSString *pbpOthercharge;
@property (strong, nonatomic) NSString *pbpOthercompilername;
@property (strong, nonatomic) NSString *pbpOtherfinishtime;

@property (strong, nonatomic) NSString *pbpMatsampreqandperf;
@property (strong, nonatomic) NSString *pbpBidopcarrycertlist;
@property (strong, nonatomic) NSString *pbpBidsendbidoppleader;
@property (strong, nonatomic) NSString *pbpBidmeetingcontent;
@property (strong, nonatomic) NSString *pbpRemarks;

@end
