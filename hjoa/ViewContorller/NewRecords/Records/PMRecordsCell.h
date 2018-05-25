//
//  PMRecordsCell.h
//  hjoa
//
//  Created by 华剑 on 2017/9/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsRecordModel.h"

@protocol passClickTimeFromPM <NSObject>

- (void)passClickTimeFormPM:(NSString *)time andButTag:(NSInteger)tag;

@end

@protocol passStatusCodeFromPM <NSObject>

- (void)passStatusCodeFormPM:(NSInteger )code;

@end

@interface PMRecordsCell : UITableViewCell

- (void)refrePMRecordsCellWithDataSource:(NewsRecordModel *)model;

@property (weak, nonatomic) id<passStatusCodeFromPM> passCodeDalagate;

@property (weak, nonatomic) id<passClickTimeFromPM> passTimeDelegate;

- (void)refreOneDayFromPMRecordsCellWithDataSource:(NewsRecordModel *)model;

@property (assign, nonatomic) NSInteger isNow;

@property (assign, nonatomic) BOOL isOffice;    // YES 为内勤
//@property (strong, nonatomic) NSTimer *locTimer;    //定时器
@property (strong, nonatomic) UIButton *recordsBut; // 打卡按钮
@property (strong, nonatomic) UIButton *missPMBut;    // 补卡、更新打卡按钮
@property (strong, nonatomic) NSString *locString;  // 定位地址
@property (strong, nonatomic) UIButton *locBut;         // 重新定位按钮
@property (strong, nonatomic) UILabel *time;            // 时间
@property (assign, nonatomic) NSTimeInterval interval;

@end
