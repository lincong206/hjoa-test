//
//  BaseButtonView.h
//  hjoa
//
//  Created by 华剑 on 2017/9/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passButFromBaseView <NSObject>

- (void)passBaseViewBut:(UIButton *)but;

@end

@interface BaseButtonView : UIView

@property (strong, nonatomic) UIButton *but;
@property (assign, nonatomic) NSInteger count;  // 第几个按钮按下

@property (strong, nonatomic) NSArray *nameArr;

@property (weak, nonatomic) id<passButFromBaseView> passButDelegate;

//- (void)

@end
