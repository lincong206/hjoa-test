//
//  QCAddNewsCell.h
//  hjoa
//
//  Created by 华剑 on 2018/3/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passQCAddNewsCellText <NSObject>

- (void)passTextFromQCAddNewsCell:(NSString *)text;

@end

@interface QCAddNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) id<passQCAddNewsCellText> passTextDelegate;

@end
