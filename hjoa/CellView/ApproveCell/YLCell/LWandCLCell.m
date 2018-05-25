//
//  LWandCLCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/3.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "LWandCLCell.h"
#import "Header.h"

@interface LWandCLCell ()

{
    CGSize _size;
    UIFont *_fnt;
    CGFloat _noteHeight;
    CGFloat _nameHeight;
}

@property (strong, nonatomic) UIScrollView *scroll;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *noteLabel;

@end

@implementation LWandCLCell

- (UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, 80)];
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.bounces = NO;
        _scroll.pagingEnabled = NO;
    }
    return _scroll;
}

- (void)referLWClWithModel:(LWandCLModel *)model
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _fnt = [UIFont systemFontOfSize:15];
    self.scroll.contentSize = CGSizeMake(self.titleArr.count * 200 + self.titleArr.count * 10, 80);
    [self.contentView addSubview:self.scroll];
    
    _nameHeight = 0.0;
    _noteHeight = 0.0;
    for (int i = 0 ; i < self.titleArr.count; i ++) {
        _size = [self.titleArr[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.alpha = 0.5;
        if (_size.width > 200) {
            NSInteger shang = _size.width/200;
            NSInteger yu = (NSInteger)_size.width % 200;
            if (yu == 0) {
                _titleLabel.frame = CGRectMake(5 + (210 * i), 10, 190 + 10, _size.height * shang);
            }else {
                _titleLabel.frame = CGRectMake(5 + (210 * i), 10, 190 + 10, _size.height * (shang + 1));
            }
        }else {
            _titleLabel.frame = CGRectMake(5 + (210 * i), 10, 190 + 10, 25);
        }
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = _fnt;
        _titleLabel.text = self.titleArr[i];
        [self.scroll addSubview:_titleLabel];
        
        if (_titleLabel.bounds.size.height > _nameHeight) {
            _nameHeight = _titleLabel.bounds.size.height;
        }
    }
    
    for (int i = 0; i < self.titleArr.count; i ++) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.backgroundColor = [UIColor whiteColor];
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.tag = 200+i;
        _noteLabel.numberOfLines = 0;
        _noteLabel.font = _fnt;
        [self addContentModel:model WithLabelTag:_noteLabel];
    }
}

- (void)addContentModel:(LWandCLModel *)model WithLabelTag:(UILabel *)label
{
    switch (label.tag) {
        case 200:
            label.text = model.lmiContractid;
            break;
        case 201:
            label.text = model.lmiContractname;
            break;
        case 202:
            label.text = model.lmiCompany;
            break;
        case 203:
            label.text = [NSString stringWithFormat:@"%@",model.lmiContractprice];
            break;
        case 204:
            label.text = [NSString stringWithFormat:@"%@",model.lmiCurrentappro];
            break;
        case 205:
            label.text = [NSString stringWithFormat:@"%@",model.lmiCurrentspread];
            break;
        case 206:
            label.text = [NSString stringWithFormat:@"%@",model.lmiTotalappro];
            break;
        case 207:
            label.text = [NSString stringWithFormat:@"%@",model.lmiTotalspread];
            break;
        case 208:
            label.text = model.lmiRemark;
            break;
        default:
            break;
    }
    label.frame = [self getContentWithAndHeight:label.text andTimes:label.tag];
    label.alpha = 0.5;
    [self.scroll addSubview:label];
    if (label.text == nil || [label.text isEqualToString:@"(null)"] || [label.text isEqual:[NSNull alloc]] || [label.text isEqualToString:@""] || [label.text isEqualToString:@" "]) {
        label.text = @"--";
    }
    if (label.frame.size.height > _noteHeight) {
        _noteHeight = label.frame.size.height;
    }
    
    [self.passHeightDelegate passLwClCellHeight:_nameHeight + _noteHeight + 50];
}

- (CGRect )getContentWithAndHeight:(NSString *)content andTimes:(NSInteger )i
{
    _size = [content sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt, NSFontAttributeName, nil]];
    if (_size.width > 200) {
        NSInteger shang = _size.width/200;
        NSInteger yu = (NSInteger)_size.width % 200;
        if (yu == 0) {
            return CGRectMake(5 + (210 * (i-200)), 10 + 30 + 5, 190 + 10, _size.height * shang);
        }else {
            return CGRectMake(5 + (210 * (i-200)), 10 + 30 + 5, 190 + 10, _size.height * (shang + 1));
        }
    }else {
        return CGRectMake(5 + (210 * (i-200)), 10 + 30 + 5, 190 + 10, 25);
    }
}

@end
