//
//  RCDateTimeUtils.m
//  hjoa
//
//  Created by 华剑 on 2017/9/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RCDateTimeUtils.h"

@implementation RCDateTimeUtils

//创建单例
+(RCDateTimeUtils*)sharedInstance{
    
    static RCDateTimeUtils *manager=nil;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        if(manager == nil){
            manager = [[RCDateTimeUtils alloc]init];
        }
    } );
    return manager;
}

//计算时间差
+(void)updateServerTime:(NSTimeInterval)timestamp {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeInteval = interval - timestamp;
//    NSLog(@"时间差_%f",timeInteval);
    [RCDateTimeUtils sharedInstance].timeIntevalDifference = timeInteval;
}

//本地时间与服务器时间同步
+ (NSDate*)currentTime:(NSTimeInterval)time {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateT=[NSDate date];
//    NSLog(@"现在时间戳_%f",time);
    NSTimeInterval now = time + [self sharedInstance].timeIntevalDifference;
//    NSLog(@"计算现在时间戳_%f",now);
    dateT = [NSDate dateWithTimeIntervalSince1970:now];
//    NSLog(@"同步时间_%@",dateT);
    return dateT;
}

@end
