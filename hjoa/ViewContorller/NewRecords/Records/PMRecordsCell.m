//
//  PMRecordsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/9/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "PMRecordsCell.h"
#import "Header.h"
#import "RCDateTimeUtils.h"

@interface PMRecordsCell ()
@property (strong, nonatomic) NSString *dateNow;    // 当前时间
@property (strong, nonatomic) UILabel *circleLabel;   // 固定图标
@property (strong, nonatomic) UILabel *recordsTimeLabel;// 打卡时间
@property (strong, nonatomic) UILabel *verticalLabel;       // 竖线
@property (strong, nonatomic) UIImageView *backView;   // 考勤
@property (assign, nonatomic) BOOL isRecord;        // 是否已经打卡 下班
@property (strong, nonatomic) UILabel *locationLabel;   // 定位label
@property (strong, nonatomic) UILabel *recordStutasLabel;// 考勤状态
@property (strong, nonatomic) UIImageView *locBackView;     // 定位
@property (strong, nonatomic) UILabel *locLabel;
@property (strong, nonatomic) UIImageView *LocImage;        // 最前面那个图片
@end

@implementation PMRecordsCell

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
        _locLabel.textAlignment = NSTextAlignmentCenter;
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

- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, kscreenWidth - 80, 20)];
        _locationLabel.backgroundColor = [UIColor clearColor];
        _locationLabel.textColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1.0];
        _locationLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UIButton *)missPMBut
{
    if (!_missPMBut) {
        _missPMBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _missPMBut.frame = CGRectMake(50, 100, 80, 20);
        _missPMBut.layer.masksToBounds = YES;
        _missPMBut.layer.cornerRadius = 5.0f;   //设置矩形四个圆角半径
        _missPMBut.layer.borderWidth = 1.0f;    //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 50/255.0, 145/255.0, 234/255.0, 1 });
        _missPMBut.layer.borderColor = colorref;
        [_missPMBut setTitleColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateNormal];
        _missPMBut.backgroundColor = [UIColor whiteColor];
        _missPMBut.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _missPMBut;
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
        _circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
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
        _verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 2, 10)];
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

// 显示当前数据
- (void)refrePMRecordsCellWithDataSource:(NewsRecordModel *)model
{
    self.backView.hidden = YES;
    self.locBackView.hidden = YES;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd aa"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *PM = [dateTime componentsSeparatedByString:@" "].lastObject;
    // 若下班卡还没有打
    if (model.DKRecord[@"crXbcardtime"] == nil || [model.DKRecord[@"crXbcardtime"] isKindOfClass:[NSNull class]]) {
        if ([PM isEqualToString:@"PM"] || [PM isEqualToString:@"下午"]) {   // 若当前时间为下午时间，且还没有打下班卡
            // 显示打卡按钮和时间
            [self showGoWorkButAndTimeWithModel:model];
        }else { // 当前时间为上午  上午没有打卡->显示基本内容   上午已经打卡->显示打卡按钮和时间
            // 显示基本数据
            [self showBasicNewsWithModel:model andTime:PM];
        }
    }else { // 当下班有数据时，显示数据
        // 显示数据
        [self showBasicNewsWithModel:model andTime:PM];
    }
}

// 显示上班打卡按钮和时间
- (void)showGoWorkButAndTimeWithModel:(NewsRecordModel *)model
{
    self.backView.hidden = NO;
    self.locBackView.hidden = NO;
    self.missPMBut.hidden = YES;
    self.recordStutasLabel.hidden = YES;
    self.locationLabel.hidden = YES;
    // 圆圈字
    self.circleLabel.backgroundColor = [UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0];
    self.circleLabel.text = @"下";
    // 竖线
    self.verticalLabel.backgroundColor = [UIColor lightGrayColor];
    // 文字
    self.recordsTimeLabel.text = @"下班时间17:30";
    // 打卡
    if (!self.isOffice) {   // YES 为内勤 
        self.backView.hidden = NO;
        self.contentView.backgroundColor = [UIColor colorWithRed:214/255.0 green:234/255.0 blue:233/255.0 alpha:1.0];
        self.backView.image = [UIImage imageNamed:@"RecordForOut"];
        self.recordsBut.tag = 103;
        [self.recordsBut setTitle:@"下班打卡" forState:UIControlStateNormal];
        
        self.locBackView.hidden = NO;
        self.locLabel.text = @"不在考勤范围内";
        [self.locBackView addSubview:self.locLabel];
        self.LocImage.image = [UIImage imageNamed:@"record_outside"];
        [self.locBackView addSubview:self.LocImage];
        [self.locBut setTitle:@"查看考勤范围" forState:UIControlStateNormal];
        [self.locBackView addSubview:self.locBut];
        [self.contentView addSubview:self.locBackView];
    }else {
        self.backView.hidden = NO;
        self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:247/255.0 blue:255/255.0 alpha:1.0];
        self.backView.image = [UIImage imageNamed:@"RecordForNormal"];
        self.recordsBut.tag = 100;
        [self.recordsBut setTitle:@"下班打卡" forState:UIControlStateNormal];
        
        self.locBackView.hidden = NO;
        self.locLabel.text = [NSString stringWithFormat:@"已进入考勤范围内"];
        [self.locBackView addSubview:self.locLabel];
        self.LocImage.image = [UIImage imageNamed:@"record_inside"];
        [self.locBackView addSubview:self.LocImage];
        [self.locBut setTitle:@"去重新定位" forState:UIControlStateNormal];
        [self.locBackView addSubview:self.locBut];
        [self.contentView addSubview:self.locBackView];
    }
    [self.backView addSubview:self.recordsBut];
    [self.contentView addSubview:self.backView];
    [self.recordsBut addTarget:self action:@selector(clickPMRecords:) forControlEvents:UIControlEventTouchUpInside];
    self.time.text = [model.timeD objectForKey:@"time"];
    [self.backView addSubview:self.time];
    [self.passCodeDalagate passStatusCodeFormPM:1];
}

// 显示基本信息
- (void)showBasicNewsWithModel:(NewsRecordModel *)model andTime:(NSString *)pm
{
    self.locBackView.hidden = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    // 竖线
    self.verticalLabel.backgroundColor = [UIColor lightGrayColor];
    // 补卡申请
    self.missPMBut.hidden = YES;
    
    if (model.DKRecord[@"crXbcardtime"] == nil || [model.DKRecord[@"crXbcardtime"] isKindOfClass:[NSNull class]]) {    // 若下班状态为空 当前时间为上午
        if ([pm isEqualToString:@"AM"] || [pm isEqualToString:@"上午"]) {
            if (model.DKRecord[@"crSbcardtime"] == nil || [model.DKRecord[@"crSbcardtime"] isKindOfClass:[NSNull class]]) {    // 当上午数据为空。没有打卡。打卡按钮显示在上午
                // 文字
                self.recordsTimeLabel.text = @"下班时间17:30";
                // 圆圈字
                self.circleLabel.backgroundColor = [UIColor lightGrayColor];
                self.circleLabel.alpha = 0.5;
                self.circleLabel.text = @"下";
                // 地址
                self.locationLabel.text = @"";
                // 考勤状态
                self.recordStutasLabel.hidden = YES;
            }else { // 当上午有数据时。打卡按钮显示在下午
                // 圆圈字
                self.circleLabel.backgroundColor = [UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0];
                self.circleLabel.text = @"下";
                // 文字
                self.recordsTimeLabel.text = @"下班时间17:30";
                // 地址
                self.locationLabel.text = @"";
                // 考勤状态
                self.recordStutasLabel.hidden = YES;
                // 时间
                self.time.text = [model.timeD objectForKey:@"time"];
                [self.backView addSubview:self.time];
                if (!self.isOffice) {   // YES 为内勤
                    self.backView.hidden = NO;
                    self.contentView.backgroundColor = [UIColor colorWithRed:214/255.0 green:234/255.0 blue:233/255.0 alpha:1.0];
                    self.backView.image = [UIImage imageNamed:@"RecordForOut"];
                    self.recordsBut.tag = 103;
                    [self.recordsBut setTitle:@"下班打卡" forState:UIControlStateNormal];
                    [self.backView addSubview:self.recordsBut];
                    [self.contentView addSubview:self.backView];
                    
                    self.locBackView.hidden = NO;
                    self.locLabel.text = @"不在考勤范围内";
                    [self.locBackView addSubview:self.locLabel];
                    self.LocImage.image = [UIImage imageNamed:@"record_outside"];
                    [self.locBackView addSubview:self.LocImage];
                    [self.locBut setTitle:@"查看考勤范围" forState:UIControlStateNormal];
                    [self.locBackView addSubview:self.locBut];
                    [self.contentView addSubview:self.locBackView];
                }else {
                    self.backView.hidden = NO;
                    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:247/255.0 blue:255/255.0 alpha:1.0];
                    self.backView.image = [UIImage imageNamed:@"RecordForNormal"];
                    self.recordsBut.tag = 100;
                    [self.recordsBut setTitle:@"下班打卡" forState:UIControlStateNormal];
                    [self.backView addSubview:self.recordsBut];
                    [self.contentView addSubview:self.backView];
                    
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
        }
        
        [self.recordsBut addTarget:self action:@selector(clickPMRecords:) forControlEvents:UIControlEventTouchUpInside];
        [self.passCodeDalagate passStatusCodeFormPM:1];
    }else { // 若有打卡数据时
        // 圆圈字
        self.circleLabel.backgroundColor = [UIColor lightGrayColor];
        self.circleLabel.alpha = 0.5;
        self.circleLabel.text = @"下";
        NSArray *time = [[[model.DKRecord[@"crXbcardtime"] componentsSeparatedByString:@" "].lastObject componentsSeparatedByString:@"."].firstObject componentsSeparatedByString:@":"];
        // 文字
        self.recordsTimeLabel.text = [NSString stringWithFormat:@"打卡时间 %@:%@(下班时间17:30)",time.firstObject,time[1]];
        // 显示打卡地点
        self.locationLabel.text = model.DKRecord[@"crXbaddress"];
        self.locationLabel.hidden = NO;
        if ([self.locationLabel.text isEqualToString:@"(null)(null)"]) {
            self.locationLabel.text = @"";
        }
        self.recordStutasLabel.hidden = NO;
        // 考勤状态
        if ([model.DKRecord[@"crXbstatustype"] integerValue] == 0) {
            if ([model.DKRecord[@"crXbcardtype"] integerValue] == 1) {  // 内勤
                self.recordStutasLabel.text = @"正常";
                self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0];
            }else if ([model.DKRecord[@"crXbcardtype"] integerValue] == 2) {    // 外勤
                self.recordStutasLabel.text = @"外勤";
                self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:55/255.0 green:183/255.0 blue:165/255.0 alpha:1.0];
            }
        }else if ([model.DKRecord[@"crXbstatustype"] integerValue] == 1) {
            self.recordStutasLabel.text = @"早退";
            self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:129/255.0 blue:49/255.0 alpha:1.0];
        }
        self.missPMBut.hidden = NO;
        self.missPMBut.tag = 300;
        self.missPMBut.userInteractionEnabled = YES;
        [self.missPMBut setTitle:@"更新打卡" forState:UIControlStateNormal];
        [self.contentView addSubview:self.missPMBut];
        
        [self.contentView addSubview:self.recordStutasLabel];
        [self.passCodeDalagate passStatusCodeFormPM:2];
    }
}

// 打卡时传递时间和按钮类型
- (void)clickPMRecords:(UIButton *)but
{
    [self.passTimeDelegate passClickTimeFormPM:self.time.text andButTag:but.tag];
    //防止用户重复点击
    but.enabled = NO;
    [self performSelector:@selector(changeButtonStatus:) withObject:but afterDelay:3.0f];
}

- (void)changeButtonStatus:(UIButton *)but
{
    but.enabled = YES;
}

// 查询某天的考勤数据情况
- (void)refreOneDayFromPMRecordsCellWithDataSource:(NewsRecordModel *)model
{
    self.backView.hidden = YES;
    
    self.locBackView.hidden = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.passCodeDalagate passStatusCodeFormPM:2];
    // 圆圈字
    self.circleLabel.backgroundColor = [UIColor lightGrayColor];
    self.circleLabel.alpha = 0.5;
    self.circleLabel.text = @"下";
    // 竖线
    self.verticalLabel.backgroundColor = [UIColor lightGrayColor];
    // 考勤状态
    if (model.DKRecord[@"crXbcardtime"] == nil || [model.DKRecord[@"crXbcardtime"] isKindOfClass:[NSNull class]]) {
        self.recordsTimeLabel.text = @"下班时间17:30";
        self.locationLabel.hidden = YES;
        self.recordStutasLabel.hidden = NO;
        self.recordStutasLabel.text = @"缺卡";
        self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:129/255.0 blue:49/255.0 alpha:1.0];
        self.missPMBut.hidden = NO;
        self.missPMBut.tag = 301;
        if (model.xbBkrecord == nil) {
            self.missPMBut.userInteractionEnabled = YES;
            [self.missPMBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }else if (model.xbBkrecord.integerValue == 0) {   // 待审批
            self.missPMBut.userInteractionEnabled = NO;
            [self.missPMBut setTitle:@"补卡*待审批" forState:UIControlStateNormal];
        }else if (model.xbBkrecord.integerValue == 1) { // 通过
            self.missPMBut.userInteractionEnabled = NO;
            [self.missPMBut setTitle:@"补卡*通过" forState:UIControlStateNormal];
        }else if (model.xbBkrecord.integerValue == 2) { // 不通过
            self.missPMBut.userInteractionEnabled = YES;
            [self.missPMBut setTitle:@"补卡*驳回" forState:UIControlStateNormal];
        }else if (model.xbBkrecord.integerValue == 3) { // 重新起草
            self.missPMBut.userInteractionEnabled = YES;
            [self.missPMBut setTitle:@"补卡*起草" forState:UIControlStateNormal];
        }else { // 没有进入流程
            self.missPMBut.userInteractionEnabled = YES;
            [self.missPMBut setTitle:@"申请补卡" forState:UIControlStateNormal];
        }
        [self.contentView addSubview:self.missPMBut];
    }else {
        self.missPMBut.hidden = YES;
        // 文字
        NSArray *time = [[[model.DKRecord[@"crXbcardtime"] componentsSeparatedByString:@" "].lastObject componentsSeparatedByString:@"."].firstObject componentsSeparatedByString:@":"];
        self.recordsTimeLabel.text = [NSString stringWithFormat:@"打卡时间 %@:%@(下班时间17:30)",time.firstObject,time[1]];
        // 定位地址
        self.locationLabel.hidden = NO;
        self.locationLabel.text = model.DKRecord[@"crXbaddress"];
        self.recordStutasLabel.hidden = NO;
        if ([model.DKRecord[@"crXbstatustype"] integerValue] == 0) {
            if ([model.DKRecord[@"crXbcardtype"] integerValue] == 1) {  // 内勤
                self.recordStutasLabel.text = @"正常";
                self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:78/255.0 green:128/255.0 blue:244/255.0 alpha:1.0];
            }else if ([model.DKRecord[@"crXbcardtype"] integerValue] == 2) {    // 外勤
                self.recordStutasLabel.text = @"外勤";
                self.recordStutasLabel.backgroundColor = [UIColor colorWithRed:55/255.0 green:183/255.0 blue:165/255.0 alpha:1.0];
            }
        }else if ([model.DKRecord[@"crXbstatustype"] integerValue] == 1) {
            self.recordStutasLabel.text = @"早退";
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
