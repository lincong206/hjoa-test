//
//  SpecialPJTCell.m
//  hjoa
//
//  Created by 华剑 on 2017/7/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "SpecialPJTCell.h"

@interface SpecialPJTCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *pjtName;
@property (weak, nonatomic) IBOutlet UILabel *buildName;
@property (weak, nonatomic) IBOutlet UITextView *pjtAddress;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *ownerShip;    //  归属人
@property (weak, nonatomic) IBOutlet UILabel *responsiblePerson;    //  负责人


@end

@implementation SpecialPJTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreUIWithData:(SpecialPJTModel *)model
{
    if ([self.type isEqualToString:@"WDJC"]) {
        self.title.text = @"档案类型:";
        self.company.text = @"档案描述:";
        self.address.text = @"文件分类:";
        
        self.pjtName.text = model.rfMold;
        if ([model.rfDescribe isEqualToString:@""]) {
            self.buildName.text = model.rfOthers;
        }else {
            self.buildName.text = model.rfDescribe;
        }
        self.pjtAddress.text = model.rfProjecttype;
        self.time.text = [model.rfCreattime componentsSeparatedByString:@" "].firstObject;
        self.ownerShip.text = model.rfIdnum;
        self.responsiblePerson.text = model.rfStatus;
    }else {
        if (model.uiManagername == nil) {
            model.uiManagername = @"";
        }
        if (model.uiBelongname == nil) {
            model.uiBelongname = @"";
        }
        if (model.piName == nil) {
            model.piName = @"";
        }
        if (model.piBuildcompany == nil) {
            model.piBuildcompany = @"";
        }
        if (model.piAddresspca == nil) {
            model.piAddresspca = @"";
        }
        if (model.piCreatetime == nil) {
            model.piCreatetime = @"";
        }
        if (model.bpcName == nil) {
            model.bpcName = @"";
        }
        if (model.piAdress == nil) {
            model.piAdress = @"";
        }
        if (model.pbcCreatdate == nil) {
            model.pbcCreatdate = @"";
        }
        self.pjtAddress.editable = false;
        self.buildName.text = model.piBuildcompany;
        self.ownerShip.text = [NSString stringWithFormat:@"归属人:%@",model.uiBelongname];
        self.responsiblePerson.text = [NSString stringWithFormat:@"负责人:%@",model.uiManagername];
        if ([self.type isEqualToString:@"xmbx"]) {
            self.pjtName.text = model.piName;
            self.pjtAddress.text = model.piAddresspca;
            self.time.text = [[model.piCreatetime componentsSeparatedByString:@" "] firstObject];
        }else if ([self.type isEqualToString:@"jcbg"]) {
            self.pjtName.text = model.bpcName;
            self.pjtAddress.text = model.piAdress;
            self.time.text = [model.pbcCreatdate componentsSeparatedByString:@" "].firstObject;
        }
    }
}

@end
