//
//  MothRecordDataListCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/4.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "MothRecordDataListCell.h"
#import "DataBaseManager.h"
#import "addressModel.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface MothRecordDataListCell ()
{
    NSString *_uiId;
    NSString *_headerUrl;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) UILabel *count;
@property (strong, nonatomic) UILabel *time;

@end

@implementation MothRecordDataListCell

- (UILabel *)count
{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.font = [UIFont systemFontOfSize:14];
        _count.backgroundColor = [UIColor clearColor];
        _count.tintColor = [UIColor lightGrayColor];
        _count.textAlignment = NSTextAlignmentRight;
    }
    return _count;
}

- (UILabel *)time
{
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width - 170, self.contentView.bounds.size.height - 35, 120, 25)];
        _time.font = [UIFont systemFontOfSize:12];
        _time.backgroundColor = [UIColor clearColor];
        _time.textAlignment = NSTextAlignmentRight;
        _time.tintColor = [UIColor lightGrayColor];
    }
    return _time;
}

- (void)refreshUIWithData:(NSDictionary *)data
{
    // 名字和头像
    [self loadHeaderImageAndNameWithUiId:[NSString stringWithFormat:@"%@",data[@"uiId"]]];
    
    if ([self.type isEqualToString:@"迟到"]) {
        self.count.frame = CGRectMake(self.contentView.bounds.size.width - 170, 10, 120, 25);
        self.count.text = [NSString stringWithFormat:@"%@次",data[@"cdcs"]];
        [self.contentView addSubview:self.count];
        
        self.time.text = [self changeTimeStamp:[NSString stringWithFormat:@"%@",data[@"cdTime"]]];
        [self.contentView addSubview:self.time];
    }
    if ([self.type isEqualToString:@"早退"]) {
        self.count.frame = CGRectMake(self.contentView.bounds.size.width - 170, 25, 120, 30);
        self.count.text = [NSString stringWithFormat:@"%@次",data[@"ztcs"]];
        [self.contentView addSubview:self.count];
    }
    if ([self.type isEqualToString:@"旷工"]) {
        self.count.frame = CGRectMake(self.contentView.bounds.size.width - 170, 25, 120, 30);
        self.count.text = [NSString stringWithFormat:@"%@次",data[@"kgcs"]];
        self.count.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.count];
    }
    if ([self.type isEqualToString:@"外勤"]) {
        self.count.frame = CGRectMake(self.contentView.bounds.size.width - 170, 25, 120, 30);
        self.count.text = [NSString stringWithFormat:@"%@次",data[@"wqcs"]];
        self.count.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.count];
    }
    if ([self.type isEqualToString:@"缺卡"]) {
        self.count.frame = CGRectMake(self.contentView.bounds.size.width - 170, 25, 120, 30);
        self.count.text = [NSString stringWithFormat:@"%@次",data[@"qkcs"]];
        self.count.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.count];
    }
}

// 名字和头像
- (void)loadHeaderImageAndNameWithUiId:(NSString *)uiId
{
    NSMutableArray *dataArrM = [[DataBaseManager shareDataBase] searchAllData];
    for (addressModel *model in dataArrM) {
        if ([uiId isEqualToString:model.uiId]) {
            self.name.text = model.uiName;
            if (!model.uiHeadimage) {
                self.headerImage.image = [UIImage imageNamed:@"man"];
                self.headerImage.contentMode = UIViewContentModeScaleToFill;
            }else if ([model.uiHeadimage isEqualToString:@""]) {
                self.headerImage.image = [UIImage imageNamed:@"man"];
                self.headerImage.contentMode = UIViewContentModeScaleToFill;
            }else {
                
                NSString *headImageUrl = [NSString stringWithFormat:@"%@%@",headImageURL,model.uiHeadimage];
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
        }
    }
}

// 计算时间。转为分钟
- (NSString *)changeTimeStamp:(NSString *)stamp
{
    return [NSString stringWithFormat:@"%ld分钟",stamp.integerValue/60000];
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
