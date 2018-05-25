//
//  QCChangeCell.m
//  hjoa
//
//  Created by 华剑 on 2018/4/17.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCChangeCell.h"

#import "addressModel.h"
#import "DataBaseManager.h"

@interface QCChangeCell ()

@property (strong, nonatomic) NSMutableArray *data;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *reporter;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation QCChangeCell

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)refreshChangeCellWithModel:(QCListModel *)model
{
    self.title.text = model.piName;
    self.content.text = [NSString stringWithFormat:@"整改要求:%@",model.bqiRequire];
    self.time.text = [model.bqiReplydate componentsSeparatedByString:@" "].firstObject;
    self.data = [[DataBaseManager shareDataBase] searchAllData];
    for (addressModel *address in self.data) {
        if (address.uiId.integerValue == model.uiId.integerValue) {
            self.reporter.text = [NSString stringWithFormat:@"整改人:%@",address.uiName];
        }
    }
    switch (model.bqiRectificationstatus.integerValue) {
        case 0:
            self.status.text = @"待整改";
            self.status.textColor = [UIColor yellowColor];
            break;
        case 1:
            self.status.text = @"待复检";
            self.status.textColor = [UIColor blueColor];
            break;
        case 2:
            self.status.text = @"完成";
            self.status.textColor = [UIColor greenColor];
            break;
        default:
            break;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
