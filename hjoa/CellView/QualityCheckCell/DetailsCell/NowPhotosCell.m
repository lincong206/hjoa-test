//
//  NowPhotosCell.m
//  hjoa
//
//  Created by 华剑 on 2018/3/1.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  质量检查 -> 详情 -> 现场照片

#import "NowPhotosCell.h"
#import "Header.h"

#import "PhotosCollectionCell.h"

@interface NowPhotosCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collection;
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation NowPhotosCell

- (UICollectionView *)collection
{
    if (!_collection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        _collection = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = self;
        _collection.dataSource = self;
    }
    return _collection;
}

- (void)loadNowPhotosFromData:(NSMutableArray *)data
{
    self.data = data;
    [self.collection registerNib:[UINib nibWithNibName:@"PhotosCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"pcCell"];
    [self.contentView addSubview:self.collection];
    [self.collection reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pcCell" forIndexPath:indexPath];
    [cell loadNowPhotosWithModel:self.data[indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kscreenWidth-40)/3, (kscreenWidth-40)/3);
}
// 现场照片被点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
