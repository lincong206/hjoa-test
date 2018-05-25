//
//  QRDetailsCell.m
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QRDetailsCell.h"

@interface QRDetailsCell ()

@property (weak, nonatomic) IBOutlet UITextView *content;

@end

@implementation QRDetailsCell

- (void)refreshQRDetailsCellWithModel:(DRDetailsModel *)model
{
    self.content.text = model.bqiRequire;
}

@end
