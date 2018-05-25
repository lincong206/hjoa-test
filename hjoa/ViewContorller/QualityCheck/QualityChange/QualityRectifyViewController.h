//
//  QualityRectifyViewController.h
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol passReplyButStatus <NSObject>

- (void)passReplyButStatus:(NSString *)status;

@end

@interface QualityRectifyViewController : UIViewController

@property (strong, nonatomic) NSString *bqiId;
@property (strong, nonatomic) NSString *birId;
//  传递整改or附件状态 到列表
@property (weak, nonatomic) id<passReplyButStatus> passReplyButStatusDelegate;

@end
