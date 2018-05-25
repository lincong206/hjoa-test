//
//  ContentFristCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/21.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "ContentFristCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface ContentFristCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ContentFristCell

- (void)refreContentFristCellDataWithModel:(BusinssNewsModel *)model
{
    self.title.text = model.naTitle;
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",intranetURL,model.naImg]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            self.image.image = [UIImage imageNamed:@"DSC_2846"];
        }
    }];
}

@end
