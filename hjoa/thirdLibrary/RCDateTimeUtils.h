//
//  RCDateTimeUtils.h
//  hjoa
//
//  Created by 华剑 on 2017/9/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCDateTimeUtils : NSObject

@property(nonatomic,assign)NSTimeInterval timeIntevalDifference;

+(void)updateServerTime:(NSTimeInterval)timestamp;

+ (NSDate*)currentTime:(NSTimeInterval)time;

+(RCDateTimeUtils*)sharedInstance;

@end
