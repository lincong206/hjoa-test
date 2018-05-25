//
//  PersonViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

/**
 从通讯录点击人物弹出的界面
 */

#import "PersonViewController.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@interface PersonViewController ()

@property (strong, nonatomic) UIImageView *clickPicture;
@property (strong, nonatomic) UIImageView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation PersonViewController

- (UIImageView *)backView
{
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight*0.4)];
        _backView.image = [UIImage imageNamed:@"DSC_2846"];
    }
    return _backView;
}

- (UIImageView *)clickPicture
{
    if (!_clickPicture) {
        _clickPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kscreenHeight)/2 - (kscreenWidth/2), kscreenWidth, kscreenWidth)];
        _clickPicture.center = self.view.center;
        _clickPicture.contentMode = UIViewContentModeScaleToFill;
        _clickPicture.backgroundColor = [UIColor whiteColor];
        _clickPicture.hidden = YES;
        _clickPicture.userInteractionEnabled = YES;
        UITapGestureRecognizer *hiddenPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenP:)];
        [_clickPicture addGestureRecognizer:hiddenPicture];
        [self.view addSubview:_clickPicture];
    }
    return _clickPicture;
}
#pragma mark --隐藏图片--
- (void)hiddenP:(UITapGestureRecognizer *)hidden
{
    self.clickPicture.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backView];
    [self.view sendSubviewToBack:self.backView];
    
    [self loadDataFromAddressModel:self.adModel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel:)];
    self.phoneLabel.userInteractionEnabled = YES;
    [self.phoneLabel addGestureRecognizer:tap];
}

- (void)loadDataFromAddressModel:(addressModel *)model
{
    self.headerImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *pictureTag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicture:)];
    self.headerImage.layer.cornerRadius = self.headerImage.frame.size.width/2;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.layer.borderWidth = 2;
    self.headerImage.layer.borderColor = ([UIColor whiteColor].CGColor);
    [self.headerImage addGestureRecognizer:pictureTag];
    
    self.nameLabel.text = model.uiName;
    self.personLabel.text = model.uiAccount;
    self.departLabel.text = model.uiPsname;
    self.phoneLabel.text = model.uiMobile;
//    self.telephoneLabel.text = model.uiMobile;
//    self.emailLabel.text = model.uiEmail;
    
    if (!model.uiHeadimage) {
        self.headerImage.image = [UIImage imageNamed:@"man"];
        self.headerImage.contentMode = UIViewContentModeScaleToFill;
    }else if ([model.uiHeadimage isEqualToString:@""]) {
        self.headerImage.image = [UIImage imageNamed:@"man"];
        self.headerImage.contentMode = UIViewContentModeScaleToFill;
    }else {
        NSString *headImageUrl = [NSString stringWithFormat:@"%@%@",headImageURL,model.uiHeadimage];
        self.headerImage.clipsToBounds = YES;
        
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:headImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                self.headerImage.image = [UIImage imageNamed:@"man"];
                self.headerImage.contentMode = UIViewContentModeScaleToFill;
            }
        }];
    }
}
#pragma mark --点击头像--
- (void)clickPicture:(UITapGestureRecognizer *)picture
{
    self.clickPicture.hidden = NO;
    self.clickPicture.image = self.headerImage.image;
}

// 点击拨打号码
- (void)clickLabel:(UITapGestureRecognizer *)tap
{
    if (self.phoneLabel.text) {
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (version.integerValue > 9) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneLabel.text]] options:@{} completionHandler:nil];
        }else {
            // IOS(2_0, 10_0)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneLabel.text]]];
        }
    }
}


@end
