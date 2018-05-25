//
//  Tools.h
//  hjoa
//
//  Created by 华剑 on 2018/5/22.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

// 初始化工具类
+ (Tools *)shareTools;

// 创建alert
/*
 message:内容
 title:标题
 style:样式
 confirmHandler:点击确定 执行
 cancleHandler:点击取消 执行
 */
+ (UIAlertController *)creatAlertControllerWithMessage:(NSString *)message andTitle:(NSString *)title andStyle:(UIAlertControllerStyle)style confirmHandler:(void(^)(UIAlertAction *confirmAction))confirmHandler cancleHandler:(void(^)(UIAlertAction *cancleAction))cancleHandler;



@end
