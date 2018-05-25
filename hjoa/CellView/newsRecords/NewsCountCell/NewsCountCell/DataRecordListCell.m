//
//  DataRecordListCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/2.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "DataRecordListCell.h"
#import "Header.h"
#import "Progress.h"

@interface DataRecordListCell ()
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *proportion;// 比例
@property (strong, nonatomic) Progress *progress;
@end

@implementation DataRecordListCell

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 30)];
        _title.backgroundColor = [UIColor clearColor];
        _title.font = [UIFont systemFontOfSize:12];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}
- (UILabel *)proportion
{
    if (!_proportion) {
        _proportion = [[UILabel alloc] initWithFrame:CGRectMake(kscreenWidth-70, 5, 50, 30)];
        _proportion.backgroundColor = [UIColor clearColor];
        _proportion.font = [UIFont systemFontOfSize:12];
        _proportion.textAlignment = NSTextAlignmentCenter;
    }
    return _proportion;
}
- (Progress *)progress
{
    if (!_progress) {
        _progress = [[Progress alloc] initWithFrame:CGRectMake(100, 17, kscreenWidth-200, 8)];
    }
    return _progress;
}

- (void)refreshProgressDataWithModel:(DataCountModel *)model
{
    self.title.text = model.title;
    [self.contentView addSubview:self.title];
    self.proportion.text = [NSString stringWithFormat:@"%@%@",model.completionRate,@"%"];
    [self.contentView addSubview:self.proportion];
    
    [self.progress setProgress:model.completionRate.floatValue/100];
    [self.contentView addSubview:self.progress];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}



@end
