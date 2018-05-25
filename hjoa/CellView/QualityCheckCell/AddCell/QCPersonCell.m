//
//  QCPersonCell.m
//  hjoa
//
//  Created by 华剑 on 2018/3/8.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCPersonCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@interface QCPersonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation QCPersonCell

- (void)refreshUI:(addressModel *)model
{
    self.name.text = [NSString stringWithFormat:@"%@",model.uiName];
    if (!model.uiHeadimage) {
        self.headImage.image = [UIImage imageNamed:@"man"];
        self.headImage.contentMode = UIViewContentModeScaleToFill;
    }
    else if ([model.uiHeadimage isEqualToString:@""]) {
        self.headImage.image = [UIImage imageNamed:@"man"];
        self.headImage.contentMode = UIViewContentModeScaleToFill;
    }else {
        
        NSString *headImageUrl = [NSString stringWithFormat:@"%@%@",headImageURL,model.uiHeadimage];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
