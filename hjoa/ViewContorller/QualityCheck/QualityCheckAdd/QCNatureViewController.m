//
//  QCNatureViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/3/7.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  性质

#import "QCNatureViewController.h"

@interface QCNatureViewController ()
// 标签数组
@property (nonatomic, strong) NSArray *markArray;
// 标签字典
@property (nonatomic, strong) NSDictionary *markDict;

@end

@implementation QCNatureViewController
- (NSArray *)markArray {
    if (!_markArray) {
        NSArray *array = [NSArray array];
        array = @[@"月度检查", @"季度检查", @"专项检查", @"节后复工检查", @"项目部检查", @"分公司检查"];
        _markArray = array;
    }
    return _markArray;
}
// 上传通过文字key取数字value发送数字
- (NSDictionary *)markDict {
    if (!_markDict) {
        NSDictionary *dict = [NSDictionary dictionary];
        dict = @{
                 @"月度检查" : @"0" ,
                 @"季度检查" : @"1",
                 @"专项检查" : @"2",
                 @"节后复工检查" : @"3",
                 @"项目部检查" : @"4",
                 @"分公司检查" : @"5"
                 };
        _markDict = dict;
    }
    return _markDict;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"检查性质";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMultiselectView];
}

- (void)setupMultiselectView {
    
    CGFloat UI_View_Width = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginX = 15;
    CGFloat top = 19;
    CGFloat btnH = 35;
//    CGFloat marginH = 40;
    CGFloat height = 130;
    CGFloat width = (UI_View_Width - marginX * 4) / 3;
    
    // 按钮背景
    UIView *btnsBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, UI_View_Width, height)];
    btnsBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnsBgView];
    
    // 循环创建按钮
    NSInteger maxCol = 3;
    for (NSInteger i = 0; i < self.markArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        btn.clipsToBounds = YES;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithRed:(102)/255.0 green:(102)/255.0 blue:(102)/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger col = i % maxCol; //列
        NSInteger row = i / maxCol; //行
        btn.frame = CGRectMake(marginX + col * (width + marginX), top + row * (btnH + marginX), width, btnH);
        [btn setTitle:self.markArray[i] forState:UIControlStateNormal];
        [btnsBgView addSubview:btn];
    }
}
/**
 * 按钮单选处理
 */
- (void)chooseMark:(UIButton *)btn
{
    NSString *str = btn.titleLabel.text;
    NSString *count = [self.markDict objectForKey:str];
    [self.passNatureDelegate passNatureFromVC:str andCount:count];
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 * 按钮多选处理
- (void)chooseMark:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        btn.backgroundColor = [UIColor redColor];
        [self.selectedMarkStrArray addObject:btn.titleLabel.text];
    } else {
        btn.backgroundColor = [UIColor whiteColor];
        [self.selectedMarkStrArray removeObject:btn.titleLabel.text];
    }
}
 */
@end
