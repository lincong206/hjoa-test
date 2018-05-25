//
//  ApprovalOpinionsViewController.h
//  hjoa
//
//  Created by 华剑 on 2017/7/5.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "officeModel.h"

@protocol refreApproveCellStatus <NSObject>

- (void)refreApproveCellStatus:(NSInteger )status;

@end

@interface ApprovalOpinionsViewController : UIViewController

@property (strong, nonatomic) NSString *butName;

@property (strong, nonatomic) officeModel *Omodel;

@property (strong, nonatomic) UITextView *inputText;

@property (weak, nonatomic) id <refreApproveCellStatus> refreCellDelegate;

@end
