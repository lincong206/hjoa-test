//
//  DeleteBXMXCell.m
//  hjoa
//
//  Created by 华剑 on 2017/7/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "DeleteBXMXCell.h"


@implementation DeleteBXMXCell

- (NSMutableArray *)deleteBXMXData
{
    if (!_deleteBXMXData) {
        _deleteBXMXData = [NSMutableArray array];
    }
    return _deleteBXMXData;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    [self.deleteBXMXData addObject:self.moneyText.text];
//    [self.deleteBXMXData addObject:self.usedText.text];
//    [self.passDataDelegate passDataFromDeleteCellData:self.deleteBXMXData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
