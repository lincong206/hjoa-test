//
//  QCNoticePersonViewController.h
//  hjoa
//
//  Created by 华剑 on 2018/3/7.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passNoticePerson <NSObject>

- (void)passNoticePersonFromVC:(NSMutableArray *)person;

@end

@interface QCNoticePersonViewController : UIViewController

@property (weak, nonatomic) id<passNoticePerson> passPersonDelegate;

@property (assign, nonatomic) BOOL isSingleSelected;    // 单选还是多选

@end
