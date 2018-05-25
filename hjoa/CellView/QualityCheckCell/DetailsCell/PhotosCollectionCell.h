//
//  PhotosCollectionCell.h
//  hjoa
//
//  Created by 华剑 on 2018/3/1.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApproveEnclosureModel.h"

@interface PhotosCollectionCell : UICollectionViewCell

- (void)loadNowPhotosWithModel:(ApproveEnclosureModel *)model;

- (void)loadPhotosWithUrl:(NSString *)url;

@end
