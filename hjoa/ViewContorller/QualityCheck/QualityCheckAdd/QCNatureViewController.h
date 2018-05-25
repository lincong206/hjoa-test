//
//  QCNatureViewController.h
//  hjoa
//
//  Created by 华剑 on 2018/3/7.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passNature <NSObject>

- (void)passNatureFromVC:(NSString *)name andCount:(NSString *)count;

@end

@interface QCNatureViewController : UIViewController

@property (weak, nonatomic) id<passNature> passNatureDelegate;

@end
