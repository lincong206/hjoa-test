//
//  SpecialPJTViewController.h
//  hjoa
//
//  Created by 华剑 on 2017/7/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialPJTModel.h"

@protocol passProjectDataFromSpecialPJTVC <NSObject>

- (void)passProjectDataWithModel:(SpecialPJTModel *)model;

@end

@interface SpecialPJTViewController : UIViewController

@property (weak, nonatomic) id<passProjectDataFromSpecialPJTVC> delegate;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *pickData;

@end
