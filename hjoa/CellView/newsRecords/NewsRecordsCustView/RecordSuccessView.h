//
//  RecordSuccessView.h
//  hjoa
//
//  Created by 华剑 on 2017/9/22.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  打卡成功View

#import <UIKit/UIKit.h>

@interface RecordSuccessView : UIView

@property (strong, nonatomic) NSString *am;
@property (strong, nonatomic) NSString *time;

@property (strong, nonatomic) UIButton *confirmBut;     // 确定按钮

- (void)refreshSuccessTime:(NSString *)time;

@end
