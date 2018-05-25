//
//  LeadCell.h
//  hjoa
//
//  Created by 华剑 on 2017/7/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJSQModel.h"

@interface LeadCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *relationImage;    // 关系图片

- (void)refreCellUIWithData:(QJSQModel *)model;

@end
