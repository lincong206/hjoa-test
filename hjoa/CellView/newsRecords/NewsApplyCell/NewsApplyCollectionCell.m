//
//  NewsApplyCollectionCell.m
//  hjoa
//
//  Created by 华剑 on 2017/10/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "NewsApplyCollectionCell.h"

@interface NewsApplyCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation NewsApplyCollectionCell

- (void)refreshUIWithModel:(ApplyModel *)model
{
    self.icon.image = [UIImage imageNamed:model.icon];
    self.name.text = model.name;
}

@end
