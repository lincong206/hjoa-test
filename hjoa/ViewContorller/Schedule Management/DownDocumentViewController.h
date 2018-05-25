//
//  DownDocumentViewController.h
//  hjoa
//
//  Created by 华剑 on 2017/7/4.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownDocumentViewController : UIViewController

@property (strong, nonatomic) NSString *parameter;  // 标题
@property (strong, nonatomic) NSString *type;   // 下载的文件类型
@property (assign, nonatomic) BOOL isShowPgv;        // 是否隐藏进度条

@end
