//
//  QCDetailsCell.m
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCDetailsCell.h"
#import "addressModel.h"
#import "DataBaseManager.h"

@implementation QCDetailsCell

- (void)loadQCDetailsDataFromModel:(QCDetailsModel *)model andRow:(NSInteger)row
{
    switch (row) {
        case 0:
            self.content.text = model.piName;
            break;
        case 1:
            if (model.birExamined.integerValue == 0) {
                self.content.text = @"月度检查";
            }else if (model.birExamined.integerValue == 1) {
                self.content.text = @"季度检查";
            }else if (model.birExamined.integerValue == 2) {
                self.content.text = @"专项检查";
            }else if (model.birExamined.integerValue == 3) {
                self.content.text = @"节后复工检查";
            }else if (model.birExamined.integerValue == 4) {
                self.content.text = @"项目部检查";
            }else if (model.birExamined.integerValue == 5) {
                self.content.text = @"分公司检查";
            }else {
                self.content.text = @"";
            }
            break;
        case 2:
            self.content.text = [model.birTime componentsSeparatedByString:@" "].firstObject;
            break;
        case 3:
            self.content.text = model.birEntryperson;
            break;
        default:
            self.content.text = @"";
            break;
    }
}

- (void)loadQCPersonDataFromModel:(QCDetailsModel *)model
{
    self.content.text = model.birEntryperson;
}

- (void)loadQRDetailsDataFromModel:(DRDetailsModel *)model andRow:(NSInteger)row
{
    switch (row) {
        case 0:
            self.content.text = model.piName;
            break;
        case 1:
            if (model.birExamined.integerValue == 0) {
                self.content.text = @"月度检查";
            }else if (model.birExamined.integerValue == 1) {
                self.content.text = @"季度检查";
            }else if (model.birExamined.integerValue == 2) {
                self.content.text = @"专项检查";
            }else if (model.birExamined.integerValue == 3) {
                self.content.text = @"节后复工检查";
            }else if (model.birExamined.integerValue == 4) {
                self.content.text = @"项目部检查";
            }else if (model.birExamined.integerValue == 5) {
                self.content.text = @"分公司检查";
            }else {
                self.content.text = @"";
            }
            break;
        case 2:
            self.content.text = [model.birTime componentsSeparatedByString:@" "].firstObject;
            break;
        case 3:
            self.content.text = model.birEntryperson;
            break;
        default:
            self.content.text = @"";
            break;
    }
}

- (void)loadQRPersonDataFromModel:(DRDetailsModel *)model andRow:(NSInteger)row
{
    if (row == 0) {
        NSMutableArray *data = [[DataBaseManager shareDataBase] searchAllData];
        for (addressModel *amodel in data) {
            if (amodel.uiId.integerValue == model.uiId.integerValue) {
                self.content.text = amodel.uiName;
            }
        }
    }else {
        self.content.text = [model.bqiTime componentsSeparatedByString:@" "].firstObject;
    }
}

@end
