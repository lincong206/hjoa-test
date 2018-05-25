//
//  NewRecordsApplyViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/10/31.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  考勤-> 申请页面
/*
 上面的按钮分别跳到对应的申请按钮
 补卡申请按钮跳到月历页面
 下面还有一个固定的 申请记录 -> 跳转查看。
 */

#import "NewRecordsApplyViewController.h"
#import "NewsApplyCollectionCell.h"
#import "ApplyModel.h"
#import "Header.h"
#import "LeaveViewController.h"
#import "ChuChaiViewController.h"
#import "MonthCalendarViewController.h"
#import "OfficeHeaderView.h"
#import "ApproveViewController.h"

#import "BaseButtonView.h"
#import "NewRecordViewController.h"
#import "RecordsCountViewController.h"
#import "NewRecordCountViewController.h"
#import "RecordSettingViewController.h"

@interface NewRecordsApplyViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, passButFromBaseView>

@property (weak, nonatomic) IBOutlet UICollectionView *applyCollection;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) BaseButtonView *baseView;

@property (strong, nonatomic) UIImageView *applyForCardView;        // 申请记录view

@end

@implementation NewRecordsApplyViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSArray *name = @[@"请假",@"出差",@"补卡申请"];
        NSArray *icon = @[@"work_1_0",@"work_1_1",@"work_1_0"];
        for (int i = 0; i < name.count; i ++) {
            ApplyModel *model = [[ApplyModel alloc] init];
            model.name = name[i];
            model.icon = icon[i];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (BaseButtonView *)baseView
{
    if (!_baseView) {
        _baseView = [[BaseButtonView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 70, kscreenWidth, 50)];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.nameArr = @[@"文档",@"申请",@"统计",@"设置"];
        _baseView.passButDelegate = self;
    }
    return _baseView;
}

- (UIImageView *)applyForCardView
{
    if (!_applyForCardView) {
        NSInteger i = self.dataSource.count/3;
        NSInteger j = self.dataSource.count%3;
        CGFloat height = 0.0;
        if (j != 0) {
            height = (i+1)*115;
        }else {
            height = i * 115;
        }
        _applyForCardView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height + 100, kscreenWidth, 50)];
        _applyForCardView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, kscreenWidth-100, 30)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"申请记录";
        [_applyForCardView addSubview:label];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 40, 40)];
        image.userInteractionEnabled = YES;
        image.image = [UIImage imageNamed:@"recordList"];
        image.contentMode = UIViewContentModeScaleToFill;
        [_applyForCardView addSubview:image];
    }
    return _applyForCardView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut setImage:[UIImage imageNamed:@"record_backBut"] forState:UIControlStateNormal];
    // 让返回按钮内容继续向左边偏移10
    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBut addTarget:self action:@selector(clickBackBut:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBut];
    
    self.title = @"申请";
    self.baseView.count = 201;
    [self.view addSubview:self.baseView];
}

- (void)clickBackBut:(UIButton *)but
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)passBaseViewBut:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (but.tag == 200) {
        NewRecordViewController *recordVC = [sb instantiateViewControllerWithIdentifier:@"nrVC"];
        [self.navigationController pushViewController:recordVC animated:YES];
    }else if (but.tag == 202) {
        RecordsCountViewController *count = [sb instantiateViewControllerWithIdentifier:@"rCountVC"];
        [self.navigationController pushViewController:count animated:YES];
    }else if (but.tag == 203) {
        RecordSettingViewController *settingVC = [sb instantiateViewControllerWithIdentifier:@"recordSettingVC"];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self.applyCollection addSubview:self.applyForCardView];
    self.applyForCardView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [self.applyForCardView addGestureRecognizer:tap];
}

// 申请记录按钮
- (void)clickTap
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //  我的申请
    ApproveViewController *apvc = [sb instantiateViewControllerWithIdentifier:@"ApproveVC"];
    apvc.title = @"我的申请";
    apvc.url = myApproveURL;
    apvc.isApprove = false;
    [self.navigationController pushViewController:apvc animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsApplyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nrApplyCell" forIndexPath:indexPath];
    [cell refreshUIWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    OfficeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kscreenWidth - 30, 30)];
    name.font = [UIFont systemFontOfSize:14];
    name.backgroundColor = [UIColor clearColor];
    name.text = @"已下审批单，已和考勤相关，将会自动计入考勤报表";
    name.textColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1.0];
    [header addSubview:name];
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (indexPath.row == 0) {
        // 请假申请
        LeaveViewController *leave = [sb instantiateViewControllerWithIdentifier:@"leaveVC"];
        leave.title = @"请假";
        [self.navigationController pushViewController:leave animated:YES];
        
    }else if (indexPath.row == 1) {
        // 出差
        ChuChaiViewController *chuchaiVC = [sb instantiateViewControllerWithIdentifier:@"chuchaiVC"];
        chuchaiVC.title = @"出差";
        [self.navigationController pushViewController:chuchaiVC animated:YES];
        
    }else if (indexPath.row == 2) {
        // 补卡申请
        MonthCalendarViewController *month = [sb instantiateViewControllerWithIdentifier:@"monthVC"];
        month.uiId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"];
        month.nowDate = [self getNowDate];
        [self.navigationController pushViewController:month animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (kscreenWidth == 414) {
        return CGSizeMake(137, 137);
    }else {
        return CGSizeMake(124, 124);
    }
}

// 获取当前时间
- (NSString *)getNowDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}

@end

