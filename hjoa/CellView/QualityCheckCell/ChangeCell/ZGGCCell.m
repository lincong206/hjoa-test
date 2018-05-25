//
//  ZGGCCell.m
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "ZGGCCell.h"
#import "Header.h"
#import "addressModel.h"
#import "DataBaseManager.h"
#import "PhotosCollectionCell.h"

@interface ZGGCCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSInteger _shang;
    CGSize _size;
    CGFloat _noteHeight;
}
@property (weak, nonatomic) IBOutlet UILabel *person;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *status;

@property (strong, nonatomic) UILabel *content;

@property (strong, nonatomic) UICollectionView *photoCollection;
@property (strong, nonatomic) NSMutableArray *photoData;

@end

@implementation ZGGCCell

- (UICollectionView *)photoCollection
{
    if (!_photoCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
            _photoCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(46, _noteHeight, (kscreenWidth-125), (((kscreenWidth-125-40)/3)*_shang)+(_shang*5)+5) collectionViewLayout:flowLayout];
        _photoCollection.backgroundColor = [UIColor whiteColor];
        _photoCollection.delegate = self;
        _photoCollection.dataSource = self;
    }
    return _photoCollection;
}

- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:14];
    }
    return _content;
}

- (void)refreshZGCellWithModel:(replyModel *)model
{
//    NSLog(@"ZG--%@",model);
    if (![model.zgUiId isEqual:[NSNull alloc]]) {
        for (addressModel *amodel in [[DataBaseManager shareDataBase] searchAllData]) {
            if (amodel.uiId.integerValue == model.zgUiId.integerValue) {
                self.person.text = [NSString stringWithFormat:@"整改人:%@",amodel.uiName];
            }
        }
        self.time.text = [model.zgTime componentsSeparatedByString:@"."].firstObject;
        self.status.hidden = YES;
    }
    if (![model.zgContent isEqual:[NSNull alloc]]) {
        [self creatReplyInformatonWithContent:model.zgContent];
    }
    if (model.zgImageArr.count > 0) {
        if (model.zgImageArr.count%3 == 0) {
            _shang = model.zgImageArr.count/3;
        }else {
            _shang = (NSInteger)(model.zgImageArr.count/3) + 1;
        }
        [self creatImageCollectionWithData:model.zgImageArr];
    }else {
        if (_noteHeight >= 100) {
            [self.passHeightDelegate passHeightFromZGGCCell:_noteHeight - 90];
        }else {
            [self.passHeightDelegate passHeightFromZGGCCell:0.0];
        }
    }
}

- (void)refreshFJCellWithModel:(replyModel *)model
{
//    NSLog(@"FJ--%@",model);
    if (![model.fjUiId isEqual:[NSNull alloc]]) {
        for (addressModel *amodel in [[DataBaseManager shareDataBase] searchAllData]) {
            if (amodel.uiId.integerValue == model.fjUiId.integerValue) {
                self.person.text = [NSString stringWithFormat:@"复检人:%@",amodel.uiName];
            }
        }
        self.time.text = [model.fjTime componentsSeparatedByString:@"."].firstObject;
        self.status.hidden = NO;
        if (![model.status isEqual:[NSNull alloc]]) {
            if (model.status.integerValue == 0) {           // 通过
                self.status.image = [UIImage imageNamed:@"qc_pass"];
            }else {
                self.status.image = [UIImage imageNamed:@"qc_noPass"];
            }
        }
    }
    if (![model.fjContent isEqual:[NSNull alloc]]) {
        [self creatReplyInformatonWithContent:model.fjContent];
    }
    if (model.fjImageArr.count > 0) {
        if (model.fjImageArr.count%3 == 0) {
            _shang = model.fjImageArr.count/3;
        }else {
            _shang = (NSInteger)(model.fjImageArr.count/3) + 1;
        }
        [self creatImageCollectionWithData:model.fjImageArr];
    }else {
        if (_noteHeight >= 100) {
            [self.passHeightDelegate passHeightFromZGGCCell:_noteHeight - 90];
        }else {
            [self.passHeightDelegate passHeightFromZGGCCell:0.0];
        }
    }
}

// 显示回复信息
- (void)creatReplyInformatonWithContent:(NSString *)content
{
    _noteHeight = 40;
    _size = [content sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil]];
    // 当内容文字长度大于label文字显示长度  为多行时。
    if (_size.width > (kscreenWidth - 125)) {
        _shang = _size.width/(kscreenWidth - 125);
        self.content.frame = CGRectMake(46 , _noteHeight, (kscreenWidth - 125), _size.height*(_shang+1));
        _noteHeight += _size.height*(_shang+1)+10;
    }else { //  当内容高度为一行时。    //  当都为一行时。
        self.content.frame = CGRectMake(46 , _noteHeight, (kscreenWidth - 125), _size.height);
        _noteHeight += _size.height + 10;
    }
    self.content.text = content;
    
    [self.contentView addSubview:self.content];
}

// 显示图片
- (void)creatImageCollectionWithData:(NSMutableArray *)sourceData
{
    self.photoData = sourceData;
    [self.photoCollection registerNib:[UINib nibWithNibName:@"PhotosCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"pcCell"];
    [self.contentView addSubview:self.photoCollection];
    if ((((kscreenWidth-125-40)/3)*_shang) + 5 + (_shang*5) + _noteHeight >= 100) {
        [self.passHeightDelegate passHeightFromZGGCCell:(((kscreenWidth-125-40)/3)*_shang) + 5 + (_shang*5) + _noteHeight - 90];
    }else {
        [self.passHeightDelegate passHeightFromZGGCCell:0.0];
    }
    [self.photoCollection reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pcCell" forIndexPath:indexPath];
    [cell loadPhotosWithUrl:self.photoData[indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kscreenWidth-125-40)/3, (kscreenWidth-125-40)/3);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
