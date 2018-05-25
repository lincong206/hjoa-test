//
//  CalenderRecordsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CalenderRecordsCell.h"
#import "Header.h"

@interface CalenderRecordsCell ()

@property (strong, nonatomic) UILabel *verticalLabel;       // 竖线
@property (strong, nonatomic) UILabel *circleLabel;   // 固定图标
@property (strong, nonatomic) UILabel *recordsTimeLabel;// 打卡时间
@property (strong, nonatomic) UILabel *locationLabel;   // 定位label
@property (strong, nonatomic) UILabel *recordStutasLabel;// 考勤状态
@property (assign, nonatomic) BOOL isMiss;              // 是否缺卡  yes->缺

@end

@implementation CalenderRecordsCell

- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, kscreenWidth - 100, 20)];
        _locationLabel.backgroundColor = [UIColor clearColor];
        _locationLabel.textColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1.0];
        _locationLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UILabel *)circleLabel
{
    if (!_circleLabel) {
        _circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
        _circleLabel.font = [UIFont systemFontOfSize:12];
        _circleLabel.textColor = [UIColor whiteColor];
        _circleLabel.backgroundColor = [UIColor lightGrayColor];
        _circleLabel.alpha = 0.5;
        _circleLabel.textAlignment = NSTextAlignmentCenter;
        _circleLabel.layer.cornerRadius = 10;
        _circleLabel.clipsToBounds = YES;
        [self.contentView addSubview:_circleLabel];
    }
    return _circleLabel;
}

- (UILabel *)verticalLabel
{
    if (!_verticalLabel) {
        _verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 2, 100)];
        _verticalLabel.alpha = 0.5;
        [self.contentView addSubview:_verticalLabel];
    }
    return _verticalLabel;
}

- (UILabel *)recordsTimeLabel
{
    if (!_recordsTimeLabel) {
        _recordsTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, kscreenWidth - 100, 20)];
        _recordsTimeLabel.backgroundColor = [UIColor clearColor];
        _recordsTimeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_recordsTimeLabel];
    }
    return _recordsTimeLabel;
}

- (UILabel *)recordStutasLabel
{
    if (!_recordStutasLabel) {
        _recordStutasLabel = [[UILabel alloc] init];
        _recordStutasLabel.frame = CGRectMake(50, 70, 50, 20);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_recordStutasLabel.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(16, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _recordStutasLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        _recordStutasLabel.layer.mask  = maskLayer;
        _recordStutasLabel.textAlignment = NSTextAlignmentCenter;
        _recordStutasLabel.font = [UIFont systemFontOfSize:12];
        _recordStutasLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_recordStutasLabel];
    }
    return _recordStutasLabel;
}

- (UIButton *)AMMissBut
{
    if (!_AMMissBut) {
        _AMMissBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _AMMissBut.frame = CGRectMake(50, 100, 80, 20);
        _AMMissBut.layer.masksToBounds = YES;
        _AMMissBut.layer.cornerRadius = 5.0f;   //设置矩形四个圆角半径
        _AMMissBut.layer.borderWidth = 1.0f;    //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 14/255.0, 100/255.0, 255/255.0, 1 });
        _AMMissBut.layer.borderColor = colorref;
        [_AMMissBut setTitleColor:[UIColor colorWithRed:14/255.0 green:100/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
        _AMMissBut.backgroundColor = [UIColor whiteColor];
        _AMMissBut.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_AMMissBut];
    }
    return _AMMissBut;
}

- (void)showRecordDataWithModel:(MonthCalenderModel *)model
{
    if (model.DKRecord[@"crSbcardtime"] == nil || [model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) {
        self.isMiss = YES;
    }else {
        self.isMiss = NO;
    }
    // 圈字
    self.circleLabel.text = @"上";
    // 竖线
    self.verticalLabel.backgroundColor = [UIColor lightGrayColor];

    // 上午打卡状态 和 上午补卡按钮
    if (self.isMiss) {
        // 上午打卡地点
        self.locationLabel.hidden = YES;
        // 上午打卡时间
        self.recordsTimeLabel.text = [NSString stringWithFormat:@"打卡时间 无(上班时间8:30)"];
        
        self.recordStutasLabel.text = @"缺卡";
        self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:129/255.0 blue:49/255.0 alpha:1.0];
        self.recordStutasLabel.hidden = self.isWeek;
        
        self.AMMissBut.hidden = NO;
        if (model.sbBkrecord == nil) {
            self.AMMissBut.userInteractionEnabled = YES;
            [self.AMMissBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 0) {   // 待审批
            self.AMMissBut.userInteractionEnabled = NO;
            [self.AMMissBut setTitle:@"补卡*待审批" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 1) { // 通过
            self.AMMissBut.userInteractionEnabled = NO;
            [self.AMMissBut setTitle:@"补卡*通过" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 2) { // 不通过
            self.AMMissBut.userInteractionEnabled = YES;
            [self.AMMissBut setTitle:@"补卡*驳回" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 3) { // 重新起草
            self.AMMissBut.userInteractionEnabled = YES;
            [self.AMMissBut setTitle:@"补卡*起草" forState:UIControlStateNormal];
        }else { // 没有进入流程
            self.AMMissBut.userInteractionEnabled = YES;
            [self.AMMissBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }
        if (self.uiId.integerValue == [[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] integerValue]) {
            self.AMMissBut.userInteractionEnabled = YES;
        }else {
            self.AMMissBut.userInteractionEnabled = NO;
        }
    }else {
        self.AMMissBut.hidden = YES;
        // 上午打卡地点
        self.locationLabel.hidden = NO;
        self.locationLabel.text = model.DKRecord[@"crSbaddress"];
        if ([self.locationLabel.text isEqualToString:@"(null)(null)"]) {
            self.locationLabel.text = @"";
        }
        // 上午打卡时间
        NSArray *time = [[model.DKRecord[@"crSbcardtime"] componentsSeparatedByString:@" "].lastObject componentsSeparatedByString:@":"];
        self.recordsTimeLabel.hidden = NO;
        self.recordsTimeLabel.text = [NSString stringWithFormat:@"打卡时间%@:%@(上班时间8:30)",time.firstObject,time[1]];
        self.recordStutasLabel.hidden = NO;
        if ([model.DKRecord[@"crSbstatustype"] integerValue] == 0) {
            if ([model.DKRecord[@"crSbcardtype"] integerValue] == 1) {  // 内勤
                self.recordStutasLabel.text = @"正常";
                self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0];
            }else if ([model.DKRecord[@"crSbcardtype"] integerValue] == 2) {    // 外勤
                self.recordStutasLabel.text = @"外勤";
                self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:55/255.0 green:183/255.0 blue:165/255.0 alpha:1.0];
            }
        }else if ([model.DKRecord[@"crSbstatustype"] integerValue] == 1) {
            self.recordStutasLabel.text = @"迟到";
            self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:129/255.0 blue:49/255.0 alpha:1.0];
        }
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
