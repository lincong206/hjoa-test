//
//  PhotosCollectionCell.m
//  hjoa
//
//  Created by 华剑 on 2018/3/1.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "PhotosCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@interface PhotosCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation PhotosCollectionCell

- (void)loadNowPhotosWithModel:(ApproveEnclosureModel *)model
{
    [self loadPhotosWithUrl:model.baiUrl];
}

- (void)loadPhotosWithUrl:(NSString *)url
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",intranetURL,url]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            self.image.image = [UIImage imageNamed:@"comwork_img"];
        }
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
