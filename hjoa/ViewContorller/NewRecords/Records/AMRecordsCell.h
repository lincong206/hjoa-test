//
//  AMRecordsCell.h
//  hjoa
//
//  Created by 华剑 on 2017/9/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsRecordModel.h"

@protocol passClickTimeFromAM <NSObject>

- (void)passClickTimeFromAM:(NSString *)time andButTag:(NSInteger)tag;

@end

@protocol passStatusCodeFromAM <NSObject>

- (void)passStatusCodeFormAM:(NSInteger )code;

@end

@interface AMRecordsCell : UITableViewCell

- (void)refreAMRecordsCellWithDataSource:(NewsRecordModel *)model;

@property (weak, nonatomic) id<passStatusCodeFromAM> passCodeDalagate;
@property (weak, nonatomic) id<passClickTimeFromAM> passTimeDelegate;

- (void)refreOneDayFromAMRecordsCellWithDataSource:(NewsRecordModel *)model;

@property (assign, nonatomic) NSInteger isNow;

@property (assign, nonatomic) BOOL isOffice;    // YES 为内勤

@property (strong, nonatomic) UIButton *recordsBut; // 打卡按钮
@property (strong, nonatomic) UIButton *missAMBut;        // 申请补卡按钮
@property (strong, nonatomic) NSString *locString;  // 定位地址
@property (strong, nonatomic) UIButton *locBut;         // 重新定位按钮

@property (strong, nonatomic) UILabel *time;            // 时间
@property (assign, nonatomic) NSTimeInterval interval;
@property (assign, nonatomic) BOOL isRecords;       // 是否迟到打卡

@end
