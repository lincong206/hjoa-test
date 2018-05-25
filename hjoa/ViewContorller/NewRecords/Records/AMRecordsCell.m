//
//  AMRecordsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/9/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "AMRecordsCell.h"
#import "Header.h"
#import "RCDateTimeUtils.h"

@interface AMRecordsCell ()

@property (strong, nonatomic) NSString *dateNow;    // 当前时间
@property (assign, nonatomic) NSInteger statusCode;
@property (strong, nonatomic) UILabel *circleLabel;   // 固定图标
@property (strong, nonatomic) UILabel *recordsTimeLabel;// 打卡时间
@property (strong, nonatomic) UILabel *verticalLabel;       // 竖线
@property (strong, nonatomic) UIImageView *backView;   // 考勤打卡背景图
@property (assign, nonatomic) BOOL isMiss;              // 是否缺卡  yes->缺
@property (strong, nonatomic) UILabel *locationLabel;   // 定位label
@property (strong, nonatomic) UILabel *recordStutasLabel;// 考勤状态
@property (strong, nonatomic) UIImageView *locBackView;     // 定位背景图
@property (strong, nonatomic) UILabel *locLabel;
@property (strong, nonatomic) UIImageView *LocImage;        // 最前面那个图片
@end

@implementation AMRecordsCell

- (UIImageView *)LocImage
{
    if (!_LocImage) {
        _LocImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        _LocImage.backgroundColor = [UIColor clearColor];
    }
    return _LocImage;
}

- (UIButton *)locBut
{
    if (!_locBut) {
        _locBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _locBut.frame = CGRectMake(130, 5, 80, 20);
        _locBut.backgroundColor = [UIColor clearColor];
        _locBut.titleLabel.font = [UIFont systemFontOfSize:12];
        [_locBut setTitleColor:[UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return _locBut;
}

- (UILabel *)locLabel
{
    if (!_locLabel) {
        _locLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 100, 20)];
        _locLabel.backgroundColor = [UIColor clearColor];
        _locLabel.font = [UIFont systemFontOfSize:12];
    }
    return _locLabel;
}

- (UIImageView *)locBackView
{
    if (!_locBackView) {
        _locBackView = [[UIImageView alloc] initWithFrame:CGRectMake((kscreenWidth-200)/2, 230, 200, 30)];
        _locBackView.backgroundColor = [UIColor clearColor];
        _locBackView.userInteractionEnabled = YES;
    }
    return _locBackView;
}

- (UILabel *)recordStutasLabel
{
    if (!_recordStutasLabel) {
        _recordStutasLabel = [[UILabel alloc] init];
        if (self.isMiss) {
            _recordStutasLabel.frame = CGRectMake(50, 80, 50, 20);
        }else {
            _recordStutasLabel.frame = CGRectMake(50, 80, 50, 20);
        }
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

- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, kscreenWidth - 80, 20)];
        _locationLabel.backgroundColor = [UIColor clearColor];
        _locationLabel.textColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1.0];
        _locationLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UIButton *)missAMBut
{
    if (!_missAMBut) {
        _missAMBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _missAMBut.frame = CGRectMake(50, 110, 80, 20);
        _missAMBut.layer.masksToBounds = YES;
        _missAMBut.layer.cornerRadius = 5.0f;   //设置矩形四个圆角半径
        _missAMBut.layer.borderWidth = 1.0f;    //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 50/255.0, 145/255.0, 234/255.0, 1 });
        _missAMBut.layer.borderColor = colorref;
        [_missAMBut setTitleColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateNormal];
        _missAMBut.backgroundColor = [UIColor whiteColor];
        _missAMBut.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_missAMBut];
    }
    return _missAMBut;
}

- (UIImageView *)backView
{
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:CGRectMake((kscreenWidth-150)/2, 70, 150, 150)];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

- (UILabel *)time
{
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 150, 20)];
        _time.backgroundColor = [UIColor clearColor];
        _time.textAlignment = NSTextAlignmentCenter;
        _time.textColor = [UIColor colorWithRed:196/255.0 green:221/255.0 blue:252/255.0 alpha:1.0];
        _time.userInteractionEnabled = YES;
    }
    return _time;
}

- (UIButton *)recordsBut
{
    if (!_recordsBut) {
        _recordsBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordsBut.frame = CGRectMake(0, 0, 150, 150);
        _recordsBut.backgroundColor = [UIColor clearColor];
        [_recordsBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _recordsBut.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _recordsBut;
}

- (UILabel *)circleLabel
{
    if (!_circleLabel) {
        _circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        _circleLabel.font = [UIFont systemFontOfSize:12];
        _circleLabel.textColor = [UIColor whiteColor];
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
        _verticalLabel = [[UILabel alloc] init];
        _verticalLabel.alpha = 0.5;
        _verticalLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_verticalLabel];
    }
    return _verticalLabel;
}

- (UILabel *)recordsTimeLabel
{
    if (!_recordsTimeLabel) {
        _recordsTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, kscreenWidth - 100, 20)];
        _recordsTimeLabel.backgroundColor = [UIColor clearColor];
        _recordsTimeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_recordsTimeLabel];
    }
    return _recordsTimeLabel;
}

// 当天数据
- (void)refreAMRecordsCellWithDataSource:(NewsRecordModel *)model
{
    self.backView.hidden = NO;
    self.locBackView.hidden = NO;
    self.missAMBut.hidden = YES;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd aa"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *AM = [dateTime componentsSeparatedByString:@" "].lastObject;
    // 如果上班卡还没有打
    if (model.DKRecord[@"crSbcardtime"] == nil || [model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) {
        if ([AM isEqualToString:@"AM"] || [AM isEqualToString:@"上午"]) {   // 若当前时间为上午 且没有打卡状态 则需要显示打卡按钮和时间
            self.statusCode = 1;
            self.isRecords = model.isLate;
            // 显示上班打卡按钮和时间
            [self showGoWorkButAndTimeWithModel:model];
        }else { // 若当前时间为下午 且没有打卡状态 则为缺卡状态 不显示打卡按钮和时间
            self.statusCode = 2;
            [self showRecordNewsWithModel:model andIsAM:AM];
        }
    }else { // 若上班卡已经打了     不显示上班打卡按钮
        self.statusCode = 2;
        // 显示打卡信息和打卡地址
        [self showRecordNewsWithModel:model andIsAM:AM];
    }
    
    [self.passCodeDalagate passStatusCodeFormAM:self.statusCode];
}

// 显示上班打卡按钮和时间
- (void)showGoWorkButAndTimeWithModel:(NewsRecordModel *)model
{
    self.backView.hidden = NO;
    self.locBackView.hidden = NO;
    // 圆圈字
    self.circleLabel.backgroundColor = [UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0];
    self.circleLabel.text = @"上";
    // 竖线
    self.verticalLabel.frame = CGRectMake(30, 40, 2, 240);
    // 文字
    self.recordsTimeLabel.text = @"上班时间08:30";
    // 状态栏
    self.recordStutasLabel.hidden = YES;
    // 地址
    self.locationLabel.hidden = YES;
    // 判断 正常考勤?迟到考勤
    if (self.isRecords) {
        if (!self.isOffice) {   // YES 为内勤
            self.contentView.backgroundColor = [UIColor colorWithRed:214/255.0 green:234/255.0 blue:233/255.0 alpha:1.0];
            self.backView.image = [UIImage imageNamed:@"RecordForOut"];
            self.recordsBut.tag = 102;
            [self.recordsBut setTitle:@"外勤打卡" forState:UIControlStateNormal];
            
            self.locBackView.hidden = NO;
            self.locLabel.text = @"不在考勤范围内";
            [self.locBackView addSubview:self.locLabel];
            self.LocImage.image = [UIImage imageNamed:@"record_outside"];
            [self.locBackView addSubview:self.LocImage];
            [self.locBut setTitle:@"查看考勤范围" forState:UIControlStateNormal];
            [self.locBackView addSubview:self.locBut];
            [self.contentView addSubview:self.locBackView];
        }else {
            self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:247/255.0 blue:255/255.0 alpha:1.0];
            self.backView.image = [UIImage imageNamed:@"RecordForNormal"];
            self.recordsBut.tag = 100;
            [self.recordsBut setTitle:@"上班打卡" forState:UIControlStateNormal];
            
            self.locBackView.hidden = NO;
            self.locLabel.text = [NSString stringWithFormat:@"已进入考勤范围内"];
            [self.locBackView addSubview:self.locLabel];
            self.LocImage.image = [UIImage imageNamed:@"record_inside"];
            [self.locBackView addSubview:self.LocImage];
            [self.locBut setTitle:@"去重新定位" forState:UIControlStateNormal];
            [self.locBackView addSubview:self.locBut];
            [self.contentView addSubview:self.locBackView];
        }
    }else {
        if (!self.isOffice) {   // YES 为内勤 
            self.contentView.backgroundColor = [UIColor colorWithRed:214/255.0 green:234/255.0 blue:233/255.0 alpha:1.0];
            self.backView.image = [UIImage imageNamed:@"RecordForOut"];
            self.recordsBut.tag = 102;
            [self.recordsBut setTitle:@"外勤打卡" forState:UIControlStateNormal];
            self.locBackView.hidden = NO;
            self.locLabel.text = @"不在考勤范围内";
            [self.locBackView addSubview:self.locLabel];
            self.LocImage.image = [UIImage imageNamed:@"record_outside"];
            [self.locBackView addSubview:self.LocImage];
            [self.locBut setTitle:@"查看考勤范围" forState:UIControlStateNormal];
            [self.locBackView addSubview:self.locBut];
            [self.contentView addSubview:self.locBackView];
        }else {
            self.contentView.backgroundColor = [UIColor colorWithRed:253/255.0 green:250/255.0 blue:241/255.0 alpha:1.0];
            self.backView.image = [UIImage imageNamed:@"RecordForLate"];
            self.recordsBut.tag = 101;
            [self.recordsBut setTitle:@"迟到打卡" forState:UIControlStateNormal];
            
            self.locBackView.hidden = NO;
            self.locLabel.text = [NSString stringWithFormat:@"已进入考勤范围内"];
            [self.locBackView addSubview:self.locLabel];
            self.LocImage.image = [UIImage imageNamed:@"record_inside"];
            [self.locBackView addSubview:self.LocImage];
            [self.locBut setTitle:@"去重新定位" forState:UIControlStateNormal];
            [self.locBackView addSubview:self.locBut];
            [self.contentView addSubview:self.locBackView];
            }
    }
    [self.backView addSubview:self.recordsBut];
    [self.contentView addSubview:self.backView];
    
    self.time.text = [model.timeD objectForKey:@"time"];
    [self.backView addSubview:self.time];
    
    [self.recordsBut addTarget:self action:@selector(clickAMRecords:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAMRecords:(UIButton *)but
{
    [self.passTimeDelegate passClickTimeFromAM:self.time.text andButTag:but.tag];
    //防止用户重复点击
    but.enabled = NO;
    [self performSelector:@selector(changeButtonStatus:) withObject:but afterDelay:3.0f];
}

- (void)changeButtonStatus:(UIButton *)but
{
    but.enabled = YES;
}

// 显示打卡信息和打卡地址
// (时间为当天下午，有打卡数据就显示，无打卡信息就显示缺卡)
- (void)showRecordNewsWithModel:(NewsRecordModel *)model andIsAM:(NSString *)am
{
    self.backView.hidden = YES;
    self.locBackView.hidden = YES;
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.isMiss = NO;
    if (model.DKRecord[@"crSbcardtime"] == nil || [model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) {    // 时间已经来到下午。只需要判断上午是否已经打卡
            // 此状态为缺卡状态
            self.isMiss = YES;
    }
    // 圆圈字
    if (([am isEqualToString:@"AM"] || [am isEqualToString:@"上午"]) && model.DKRecord[@"crSbcardtime"] == nil) {
        self.circleLabel.backgroundColor = [UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0];
    }else {
        self.circleLabel.backgroundColor = [UIColor lightGrayColor];
        self.circleLabel.alpha = 0.5;
    }
    self.circleLabel.text = @"上";
    // 竖线
    self.verticalLabel.frame = CGRectMake(30, 40, 2, 110);
    
    if (self.isMiss) {
        self.recordsTimeLabel.text = @"上班时间08:30";
        
        self.recordStutasLabel.hidden = NO;
        self.recordStutasLabel.text = @"缺卡";
        self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:129/255.0 blue:49/255.0 alpha:1.0];
        
        self.missAMBut.hidden = NO;
        if (model.sbBkrecord == nil) {
            self.missAMBut.userInteractionEnabled = YES;
            [self.missAMBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 0) {   // 待审批
            self.missAMBut.userInteractionEnabled = NO;
            [self.missAMBut setTitle:@"补卡*待审批" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 1) { // 通过
            self.missAMBut.userInteractionEnabled = NO;
            [self.missAMBut setTitle:@"补卡*通过" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 2) { // 不通过
            self.missAMBut.userInteractionEnabled = YES;
            [self.missAMBut setTitle:@"补卡*驳回" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 3) { // 重新起草
            self.missAMBut.userInteractionEnabled = YES;
            [self.missAMBut setTitle:@"补卡*起草" forState:UIControlStateNormal];
        }else { // 没有进入流程
            self.missAMBut.userInteractionEnabled = YES;
            [self.missAMBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }
    }else { // 上午考勤有数据。显示数据
        // 定位地址
        self.locationLabel.hidden = NO;
        if (model.DKRecord[@"crSbaddress"] == nil || [model.DKRecord[@"crSbaddress"] isKindOfClass:[NSNull class]]) {
            self.locationLabel.text = @"";
        }else {
            self.locationLabel.text = model.DKRecord[@"crSbaddress"];
        }
        if ([self.locationLabel.text isEqualToString:@"(null)(null)"]) {
            self.locationLabel.text = @"";
        }
        NSArray *time = [[[model.DKRecord[@"crSbcardtime"] componentsSeparatedByString:@" "].lastObject componentsSeparatedByString:@"."].firstObject componentsSeparatedByString:@":"];
        self.recordsTimeLabel.text = [NSString stringWithFormat:@"打卡时间 %@:%@(上班时间08:30)",time.firstObject,time[1]];
        self.recordStutasLabel.hidden = NO;
        // 考勤状态
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

// 查询某天的考勤数据情况
- (void)refreOneDayFromAMRecordsCellWithDataSource:(NewsRecordModel *)model
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backView.hidden = YES;
    self.locBackView.hidden = YES;
    [self.passCodeDalagate passStatusCodeFormAM:2];
    // 圆圈字
    self.circleLabel.backgroundColor = [UIColor lightGrayColor];
    self.circleLabel.alpha = 0.5;
    self.circleLabel.text = @"上";
    // 竖线
    self.verticalLabel.frame = CGRectMake(30, 40, 2, 110);
    
    // 考勤状态
    if (model.DKRecord[@"crSbcardtime"] == nil || [model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) {
        // 当没有数据时，隐藏地址label
        self.locationLabel.hidden = YES;
        
        self.recordsTimeLabel.text = @"上班时间08:30";
        self.recordStutasLabel.hidden = NO;
        self.recordStutasLabel.text = @"缺卡";
        self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:129/255.0 blue:49/255.0 alpha:1.0];
        self.missAMBut.hidden = NO;
        if (model.sbBkrecord == nil) {
            self.missAMBut.userInteractionEnabled = YES;
            [self.missAMBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 0) {   // 待审批
            self.missAMBut.userInteractionEnabled = NO;
            [self.missAMBut setTitle:@"补卡*待审批" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 1) { // 通过
            self.missAMBut.userInteractionEnabled = NO;
            [self.missAMBut setTitle:@"补卡*通过" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 2) { // 不通过
            self.missAMBut.userInteractionEnabled = YES;
            [self.missAMBut setTitle:@"补卡*驳回" forState:UIControlStateNormal];
        }else if (model.sbBkrecord.integerValue == 3) { // 重新起草
            self.missAMBut.userInteractionEnabled = YES;
            [self.missAMBut setTitle:@"补卡*起草" forState:UIControlStateNormal];
        }else { // 没有进入流程
            self.missAMBut.userInteractionEnabled = YES;
           [self.missAMBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }
    }else { // 有考勤数据，隐藏补卡按钮
        self.missAMBut.hidden = YES;
        // 定位地址
        self.locationLabel.hidden = NO;
        self.locationLabel.text = model.DKRecord[@"crSbaddress"];
        // 文字
        NSArray *time = [[[model.DKRecord[@"crSbcardtime"] componentsSeparatedByString:@" "].lastObject componentsSeparatedByString:@"."].firstObject componentsSeparatedByString:@":"];
        self.recordsTimeLabel.text = [NSString stringWithFormat:@"打卡时间 %@:%@(上班时间08:30)",time.firstObject,time[1]];
        self.locationLabel.hidden = NO;
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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
