//
//  QualityCheckListCell.m
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QualityCheckListCell.h"

@interface QualityCheckListCell ()

@property (weak, nonatomic) IBOutlet UILabel *pjtName;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *status;


@end

@implementation QualityCheckListCell

- (void)refreshListCellWithModel:(QCListModel *)model
{
    self.pjtName.text = model.piName;
    self.content.text = model.birContent;
    self.name.text = [NSString stringWithFormat:@"检查人:%@",model.birEntryperson];
    self.time.text = [model.birTime componentsSeparatedByString:@" "].firstObject;
    if (model.birRectification.integerValue == 0) {
        self.status.image = [UIImage imageNamed:@"qc_status_1"];    // 整改
    }else {
        self.status.image = [UIImage imageNamed:@"qc_status_0"];    // 完成
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
