//
//  PhotosViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/12/8.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotosCollectionViewCell.h"
#import "PhotosModel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PhotosViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
{
    BOOL _isRefresh;  // 防止选择照片时，会移动到底部
}

@property (weak, nonatomic) IBOutlet UICollectionView *PhotosCollection;
@property (strong, nonatomic) NSMutableArray *postPhotosArr;
@property (strong, nonatomic) NSMutableArray *selectIndexs;

@end

@implementation PhotosViewController

- (NSMutableArray *)selectIndexs
{
    if (!_selectIndexs) {
        _selectIndexs = [NSMutableArray array];
    }
    return _selectIndexs;
}

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (NSMutableArray *)postPhotosArr
{
    if (!_postPhotosArr) {
        _postPhotosArr = [NSMutableArray array];
    }
    return _postPhotosArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isRefresh = false;

}


- (void)viewDidLayoutSubviews
{
    if (_isRefresh) {
        
    }else {
        // 显示在最底部
        [self.PhotosCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.data.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(((ScreenWidth-5)/4)-5, ((ScreenWidth-5)/4)-5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photosCell" forIndexPath:indexPath];
    PhotosModel *model = self.data[indexPath.row];
    cell.image.image = [UIImage imageWithData:model.photosData];
    cell.image.userInteractionEnabled = YES;
    if (model.select) {
        cell.select.hidden = NO;
        [cell.select setImage:[UIImage imageNamed:@"record_inside"] forState:UIControlStateNormal];
    }else {
        cell.select.hidden = YES;
    }
    return cell;
}

// 选择点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosModel *model = self.data[indexPath.row];
    // 判断状态
    if (model.select) {     // 选中状态 -> 取消选中
        model.select = !model.select;
        [self.selectIndexs removeObject:model];
    }else {                 // 未选中  -> 选中
        // 只显示9个图
        if (self.selectIndexs.count < 9) {
            model.select = !model.select;
            [self.selectIndexs addObject:model];
        }
    }

    _isRefresh = true;
    // 刷新选择图标
    [self.PhotosCollection reloadData];
}

// 取消
- (IBAction)clickCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
// 完成
- (IBAction)clickConfirm:(id)sender
{
    for (PhotosModel *model in self.selectIndexs) {
        [self.postPhotosArr addObject:[UIImage imageWithData:model.photosData]];
    }

    if (self.postPhotosArr.count == self.selectIndexs.count) {
        [self.passDelegate passSelectPhotosFromPhotosVC:self.postPhotosArr];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
