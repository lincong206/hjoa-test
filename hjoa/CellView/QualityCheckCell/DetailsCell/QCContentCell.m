//
//  QCContentCell.m
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCContentCell.h"
#import "Header.h"
#import "QCDetailsModel.h"

@interface QCContentCell ()
{
    CGSize _contentSize;
    NSInteger _row;
    CGFloat _height;
    NSInteger _duan;
}
@property (strong, nonatomic) UILabel *content;

@end

@implementation QCContentCell

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 30, 30)];
        _icon.backgroundColor = [UIColor clearColor];
    }
    return _icon;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(48, 8, 70, 30)];
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}

- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = [UIFont systemFontOfSize:15];
        _content.numberOfLines = 0;
    }
    return _content;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.content];
}

- (void)loadQCContentFromDataSource:(NSString *)content
{
    _contentSize = [[content stringByReplacingOccurrencesOfString:@" " withString:@""] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
    self.content.text = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (_contentSize.width > (kscreenWidth-40)) {      // 多行文本  横向文字长
        _row = _contentSize.width/(kscreenWidth-40);
        if (_contentSize.height > 20) {             // 高度2段起
            _duan = _contentSize.height/17;
            self.content.frame = CGRectMake(20, 40, (kscreenWidth-30), (((_row+_duan+_duan+1))*18));
            _height = ((_row+_duan+_duan+1)*18);
        }else {
            self.content.frame = CGRectMake(20, 40, (kscreenWidth-30), (_row+1)*20);
            _height = (_row+1)*20;
        }
    }else {
        if (_contentSize.height > 20) {             // 高度2段起
            self.content.frame = CGRectMake(20, 40, (kscreenWidth-20-10), _contentSize.height);
            _height = _contentSize.height;
        }else {
            self.content.frame = CGRectMake(20, 40, (kscreenWidth-20-10), 30);
            _height = 30;
        }
    }
    [self.passHeightDelegate passHeightFromQCContentCell:_height+44];
}

@end
