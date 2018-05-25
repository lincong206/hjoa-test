//
//  DocumentDetailsViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/5/16.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  公文界面

#import "DocumentDetailsViewController.h"
#import "OfficialDocumentViewController.h"

@interface DocumentDetailsViewController ()

@end

@implementation DocumentDetailsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickRightBut)];
}

- (void)clickRightBut
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    OfficialDocumentViewController *odVC = [sb instantiateViewControllerWithIdentifier:@"odVC"];
    [self.navigationController pushViewController:odVC animated:YES];
}



@end
