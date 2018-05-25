//
//  DocManagerApplyViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/12/19.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  文档管理 -> 申请

#import "DocManagerApplyViewController.h"
#import "Header.h"

#import "DocApplyCell.h"
#import "ApplyModel.h"
#import "BaseButtonView.h"
#import "DocManagerViewController.h"
#import "DocManagerCountViewController.h"
#import "DocApplyViewController.h"  // 申请界面

@interface DocManagerApplyViewController () <passButFromBaseView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) BaseButtonView *baseView;
@property (weak, nonatomic) IBOutlet UICollectionView *applyCollection;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation DocManagerApplyViewController

- (BaseButtonView *)baseView
{
    if (!_baseView) {
        _baseView = [[BaseButtonView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 70, kscreenWidth, 50)];
        _baseView.nameArr = @[@"文档",@"申请",@"统计"];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.passButDelegate = self;
    }
    return _baseView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSArray *nameArr = @[@"借出申请"];
        NSArray *imageArr = @[@"JCSQ"];
        for (int i = 0; i < nameArr.count; i ++) {
            ApplyModel *model = [[ApplyModel alloc] init];
            model.name = nameArr[i];
            model.icon = imageArr[i];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"文档管理";
    self.baseView.count = 201;
    [self.view addSubview:self.baseView];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut setImage:[UIImage imageNamed:@"record_backBut"] forState:UIControlStateNormal];
    // 让返回按钮内容继续向左边偏移10
    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBut addTarget:self action:@selector(clickBackBut:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBut];
}
- (void)clickBackBut:(UIButton *)but
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
}
// 底部按钮跳转
- (void)passBaseViewBut:(UIButton *)but
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (but.tag == 200) {
        DocManagerViewController *dmVC = [sb instantiateViewControllerWithIdentifier:@"docManagerVC"];
        [self.navigationController pushViewController:dmVC animated:YES];
    }else if (but.tag == 202) {
        DocManagerCountViewController *dmcVC = [sb instantiateViewControllerWithIdentifier:@"docManagerCountVC"];
        [self.navigationController pushViewController:dmcVC animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(((kscreenWidth-2)/3)-2, ((kscreenWidth-2)/3)-2);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DocApplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"docApplyCell" forIndexPath:indexPath];
    ApplyModel *model = self.dataSource[indexPath.row];
    cell.image.image = [UIImage imageNamed:model.icon];
    cell.name.text = model.name;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DocApplyViewController *daVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"docApplyVC"];
        [self.navigationController pushViewController:daVC animated:YES];
    }
}

@end
