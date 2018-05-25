//
//  ApproveButView.h
//  hjoa
//
//  Created by 华剑 on 2017/5/25.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "officeModel.h"
#import "ApprovalOpinionsViewController.h"

@protocol passButStatuDelegate <NSObject>

- (void)passButStatus:(NSString *)status;
//- (void)pushAOViewController:(ApprovalOpinionsViewController *)aoVC andButStatus:(NSString *)status;

@end

@interface ApproveButView : UIView

@property (strong, nonatomic) officeModel *Omodel;

@property (weak, nonatomic) id passButStatuDelegate;

@end
