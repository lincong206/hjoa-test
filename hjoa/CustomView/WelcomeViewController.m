//
//  WelcomeViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/4/7.
//  Copyright © 2017年 huajian. All rights reserved.
//
/*
 引导页面
 */
#import "WelcomeViewController.h"
#import "ViewController.h"
#import "Header.h"

#define Width [UIScreen mainScreen].bounds.size.width

@interface WelcomeViewController () ///<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupScrollView];

}

- (void)setupScrollView
{
    self.scroll.backgroundColor = [UIColor whiteColor];
    self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    // 偏移量
    [self.scroll setContentOffset:CGPointMake(0, kscreenWidth) animated:YES];
    // 设置scroll的显示范围
    self.scroll.contentSize = CGSizeMake(kscreenWidth * 3, kscreenHeight);
    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kscreenWidth * i, 0, kscreenWidth, kscreenHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%ld.jpg",(long)i+1]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        if (i == 2) {
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:[self creatBut]];
        }
        [self.scroll addSubview:imageView];
    }
}

- (UIButton *)creatBut
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, kscreenHeight*0.85, kscreenWidth, 50);
    [but setBackgroundColor:[UIColor clearColor]];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setTitle:@"登    录" forState:UIControlStateNormal];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.titleLabel.font = [UIFont systemFontOfSize: 20];
    [but addTarget:self action:@selector(clickLoginBut) forControlEvents:UIControlEventTouchUpInside];
    return but;
}

- (void)clickLoginBut
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginVC"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

/*
#pragma make---scrollViewDelegate
// targetContentOffset 可以让界面停留在指定位置
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint orifinalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    NSLog(@"x-%fy-%f",orifinalTargetContentOffset.x,orifinalTargetContentOffset.y);
    targetContentOffset->x = kscreenWidth*(NSInteger)(orifinalTargetContentOffset.x/kscreenWidth);
    targetContentOffset->y = orifinalTargetContentOffset.y;
    NSLog(@"%f",targetContentOffset->x);
}
*/

@end
