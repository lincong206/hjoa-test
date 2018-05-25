//
//  RecordPersonCell.m
//  hjoa
//
//  Created by 华剑 on 2017/9/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RecordPersonCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

#import "QFDatePickerView.h"

@interface RecordPersonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIDatePicker *datePick;
@property (strong, nonatomic) UIImageView *backPickView;

@end

@implementation RecordPersonCell

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kscreenWidth - 100, 12, 80, 30)];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.userInteractionEnabled = YES;
    }
    return _timeLabel;
}

- (void)loadPresonData:(QueryNameModel *)model
{
    self.recordLabel.text = [NSString stringWithFormat:@"考勤组:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sciPiname"]];
    
    if (model.uiImg == nil  || [model.uiImg isKindOfClass:[NSNull class]] || [model.uiImg isEqualToString:@""]) {
        self.headerImage.image = [UIImage imageNamed:@"man"];
    }else {
        NSString *headImageUrl = [NSString stringWithFormat:@"%@%@",headImageURL,model.uiImg];
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:headImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                self.headerImage.image = [UIImage imageNamed:@"man"];
                self.headerImage.contentMode = UIViewContentModeScaleToFill;
            }
        }];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerImage.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.headerImage.bounds.size];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = self.headerImage.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        self.headerImage.layer.mask = maskLayer;
    }
    self.nameLabel.text = model.uiName;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[model.time componentsSeparatedByString:@"-"].firstObject,[model.time componentsSeparatedByString:@"-"][1]];
    [self.contentView addSubview:self.timeLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAction)];
    [self.timeLabel addGestureRecognizer:tap];
}

// 选择月
- (void)TapAction
{
    QFDatePickerView *qfDatePickView = [[QFDatePickerView alloc] initDatePackerWithResponse:^(NSString *str) {
        self.timeLabel.text = str;
        [self.passDateDelegate passPickDate:str];
    }];
    [qfDatePickView show];
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
