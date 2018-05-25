//
//  QCContentCell.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passQCContentCellHeight <NSObject>

- (void)passHeightFromQCContentCell:(CGFloat)height;

@end

@interface QCContentCell : UITableViewCell

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *title;

- (void)loadQCContentFromDataSource:(NSString *)content;

@property (weak, nonatomic) id<passQCContentCellHeight> passHeightDelegate;

@end
