//
//  RecordNewsCell.h
//  hjoa
//
//  Created by 华剑 on 2017/9/18.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  个人信息 第一行


#import <UIKit/UIKit.h>

@protocol passPickViewFromRecordNewsCell <NSObject>

- (void)passPickBackView:(UIView *)view andPickView:(UIDatePicker *)pick;

@end

@protocol passDateFromRecordNewsCell <NSObject>

- (void)passDateFromRecordNewsCell:(NSString *)date;

@end

@interface RecordNewsCell : UITableViewCell

- (void)refreRecordNewsCellWithDateTime:(NSString *)dateTime;

// 传 datePick
@property (weak, nonatomic) id<passPickViewFromRecordNewsCell> recordNewsCellDelegate;
// 传 时间参数
@property (weak, nonatomic) id<passDateFromRecordNewsCell> dateDelegate;

@end
