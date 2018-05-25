//
//  QCResultStringCell.h
//  hjoa
//
//  Created by 华剑 on 2018/3/6.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passQCResultStringCellText <NSObject>

- (void)passTextFromQCResultStringCell:(NSString *)text;

@end

@interface QCResultStringCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *input;
@property (weak, nonatomic) id<passQCResultStringCellText> passTextDelegate;

@end
