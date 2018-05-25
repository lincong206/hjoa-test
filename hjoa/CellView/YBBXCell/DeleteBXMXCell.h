//
//  DeleteBXMXCell.h
//  hjoa
//
//  Created by 华剑 on 2017/7/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passDataFromDeleteCellData <NSObject>

- (void)passDataFromDeleteCellData:(NSMutableArray *)data;

@end

@interface DeleteBXMXCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteBut;
@property (weak, nonatomic) IBOutlet UITextField *moneyText;
@property (weak, nonatomic) IBOutlet UITextField *usedText;
@property (strong, nonatomic) NSMutableArray *deleteBXMXData;

@property (weak, nonatomic) id<passDataFromDeleteCellData> passDataDelegate;

@end
