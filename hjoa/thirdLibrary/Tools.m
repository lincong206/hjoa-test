//
//  Tools.m
//  hjoa
//
//  Created by 华剑 on 2018/5/22.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (Tools *)shareTools
{
    static Tools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[Tools alloc] init];
    });
    return tools;
}

+ (UIAlertController *)creatAlertControllerWithMessage:(NSString *)message andTitle:(NSString *)title andStyle:(UIAlertControllerStyle)style confirmHandler:(void (^)(UIAlertAction *))confirmHandler cancleHandler:(void (^)(UIAlertAction *))cancleHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmHandler];
    [alertController addAction:confirmAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancleHandler];
    [alertController addAction:cancleAction];
    return alertController;
}

@end
