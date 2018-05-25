//
//  QCDetailsCell.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCDetailsModel.h"
#import "DRDetailsModel.h"

@interface QCDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

- (void)loadQCDetailsDataFromModel:(QCDetailsModel *)model andRow:(NSInteger)row;
- (void)loadQCPersonDataFromModel:(QCDetailsModel *)model;

- (void)loadQRDetailsDataFromModel:(DRDetailsModel *)model andRow:(NSInteger)row;
- (void)loadQRPersonDataFromModel:(DRDetailsModel *)model andRow:(NSInteger)row;

@end
