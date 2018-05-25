//
//  ReplyButCell.h
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol passButTag <NSObject>

- (void)passButTag:(NSInteger)tag;

@end
@interface ReplyButCell : UITableViewCell

- (void)addButName:(NSArray *)butName;

@property (weak, nonatomic) id<passButTag> passTagDelegate;

@end
