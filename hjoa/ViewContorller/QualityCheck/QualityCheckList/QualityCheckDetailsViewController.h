//
//  QualityCheckDetailsViewController.h
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passQCListStatus <NSObject>

- (void)passQCListStatusWithQCDetails:(NSString *)status;

@end

@interface QualityCheckDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *birId;
//  传递整改or待整改 状态
@property (strong, nonatomic) id<passQCListStatus> passQCListStatusDelegate;

@end
