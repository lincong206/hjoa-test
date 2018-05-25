//
//  ClickApproveViewController.h
//  hjoa
//
//  Created by 华剑 on 2017/3/30.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "officeModel.h"

@protocol passApproveStatus <NSObject>

- (void)passApproveStatus:(NSInteger )status;

@end

@interface ClickApproveViewController : UIViewController

@property (strong, nonatomic) officeModel *model;

@property (assign, nonatomic) BOOL isSelect;    // 判断是否为审批还是申请。审批为TRUE带审批按钮，申请为false不带审批按钮

@property (weak, nonatomic) id <passApproveStatus> passStatusDelegate;

@end
