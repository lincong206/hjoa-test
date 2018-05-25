//
//  tabbarController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "tabbarController.h"

@interface tabbarController ()

@end

@implementation tabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置tabBarItem:
    NSArray *name = @[@"通讯录", @"消息", @"办公", @"我"];
    NSArray *imageName = @[@"tabbar_address", @"tabbar_news", @"tabbar_office", @"tabbar_me"];
    
    self.tabBar.tintColor = [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0];
    
    for (UINavigationController *nvc in self.viewControllers) {
        
        // 设置背景颜色
//        [nvc.navigationBar setBarTintColor:[UIColor colorWithRed:14/255.0 green:100/255.0 blue:250/255.0 alpha:1.0]];
        
        [nvc.navigationBar setBarTintColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0]];
        [nvc.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
        
        UIViewController *vc = nvc.viewControllers[0];
        // 获取序号:
        NSInteger index = [self.viewControllers indexOfObject:nvc];
        
        vc.tabBarItem.title = name[index];
        vc.tabBarItem.image = [UIImage imageNamed:imageName[index]];
        UIImage *selectImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_press", imageName[index]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = selectImage;
        
        // KVC方式赋值:
        //        [vc setValue:@(index) forKey:@"index"];
    }
    
}
@end
