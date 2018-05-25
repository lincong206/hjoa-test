//
//  ReplyQRButViewController.h
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passZGFJStatus <NSObject>

- (void)passZGFJStatusWithRQRButVC:(NSString *)status;

@end

@interface ReplyQRButViewController : UIViewController

@property (strong, nonatomic) NSString *bqiId;
@property (strong, nonatomic) NSString *brrId;
//  传递复检和整改状态
@property (weak, nonatomic) id<passZGFJStatus> passZGFJStatusDelegate;

@end
