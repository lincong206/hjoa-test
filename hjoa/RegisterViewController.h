//
//  RegisterViewController.h
//  hjoa
//
//  Created by 华剑 on 2017/10/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passAccountAndPWFromRegist <NSObject>

- (void)passAccount:(NSString *)account andPW:(NSString *)pw;

@end

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) id<passAccountAndPWFromRegist> passDelegate;

@end
