//
//  RectifySheetViewController.h
//  hjoa
//
//  Created by 华剑 on 2018/3/26.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passUpdataStatus <NSObject>

- (void)passUpdataStatusWithRSVC:(NSString *)status;

@end

@interface RectifySheetViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *dataSource;   // 基础数据
@property (strong, nonatomic) NSMutableArray *dataPhotos;   // 基础照片数据
@property (strong, nonatomic) NSMutableArray *nowPhotos;    // 现场照片数据
@property (strong, nonatomic) NSString *birId;  // 表单的id
//  传递整改or带整改 状态
@property (weak, nonatomic) id<passUpdataStatus> passStatusDelegate;

@end
