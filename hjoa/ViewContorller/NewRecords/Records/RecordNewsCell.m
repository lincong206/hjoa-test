//
//  RecordNewsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/9/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RecordNewsCell.h"
#import "DataBaseManager.h"
#import "UIImageView+WebCache.h"
#import "addressModel.h"
#import "Header.h"

@interface RecordNewsCell ()

@property (strong, nonatomic) addressModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *dateBut;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIView *pickBackView;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIButton *confirmButton;
@end

@implementation RecordNewsCell

- (UIView *)pickBackView
{
    if (!_pickBackView) {
        _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight*0.7)];
        _pickBackView.backgroundColor = [UIColor grayColor];
        _pickBackView.alpha = 0.7;
        _pickBackView.hidden = NO;
    }
    return _pickBackView;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, kscreenHeight*0.7 - 40, kscreenWidth, 40)];
        _backView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    }
    return _backView;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(kscreenWidth -70,  5, 40, 30)];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kscreenHeight*0.7, kscreenWidth, kscreenHeight*0.3)];
        _datePicker.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.hidden = NO;
        [_datePicker addTarget:self action:@selector(rollAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (void)refreRecordNewsCellWithDateTime:(NSString *)dateTime
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uiId = [user objectForKey:@"uiId"];
    
    self.recordNameLabel.text = [NSString stringWithFormat:@"考勤组:%@",[user objectForKey:@"sciPiname"]];
    // 审批人和头像
    NSMutableArray *dataArrM = [[DataBaseManager shareDataBase] searchAllData];
    for (addressModel *addresModel in dataArrM) {
        if (uiId.integerValue == addresModel.uiId.integerValue) {
            self.model = addresModel;
        }
        self.nameLabel.text = [NSString stringWithFormat:@"%@",self.model.uiName];
        if (!self.model.uiHeadimage) {
            self.headImage.image = [UIImage imageNamed:@"man"];
            self.headImage.contentMode = UIViewContentModeScaleToFill;
        }
        else if ([self.model.uiHeadimage isEqualToString:@""]) {
            self.headImage.image = [UIImage imageNamed:@"man"];
            self.headImage.contentMode = UIViewContentModeScaleToFill;
        }else {
            NSString *headImageUrl = [NSString stringWithFormat:@"%@%@",headImageURL,self.model.uiHeadimage];
            [self.headImage sd_setImageWithURL:[NSURL URLWithString:headImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                    self.headImage.image = [UIImage imageNamed:@"man"];
                    self.headImage.contentMode = UIViewContentModeScaleToFill;
                }
            }];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.headImage.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.headImage.bounds.size];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            //设置大小
            maskLayer.frame = self.headImage.bounds;
            //设置图形样子
            maskLayer.path = maskPath.CGPath;
            self.headImage.layer.mask = maskLayer;
        }
    }
    
    // 日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if (dateTime == nil) {
        dateTime = [formatter stringFromDate:[NSDate date]];
    }
    [self.dateBut setTitle:dateTime forState:UIControlStateNormal];
    [self.dateBut addTarget:self action:@selector(clickDateBut:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickDateBut:(UIButton *)sender
{
    // 加视图
    [self.backView addSubview:self.confirmButton];
    [self.pickBackView addSubview:self.backView];
    [self.pickBackView addSubview:self.datePicker];
    
    self.datePicker.hidden = NO;
    self.pickBackView.hidden = NO;

    self.pickBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    [self.pickBackView addGestureRecognizer:tap];
    
    [self.recordNewsCellDelegate passPickBackView:self.pickBackView andPickView:self.datePicker];
}

// 确定按钮
- (void)cancel:(UIButton *)but
{
    self.datePicker.hidden = YES;
    self.pickBackView.hidden = YES;
}

// 手势按钮
- (void)clickTap:(UITapGestureRecognizer *)tap
{
    self.datePicker.hidden = YES;
    self.pickBackView.hidden = YES;
}

// datePick
- (void)rollAction:(UIDatePicker *)pick
{
    //NSDate格式转换为NSString格式
    NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    // 更新时间表
    [self.dateBut setTitle:dateString forState:UIControlStateNormal];
    
    [self.dateDelegate passDateFromRecordNewsCell:dateString];
}

@end
