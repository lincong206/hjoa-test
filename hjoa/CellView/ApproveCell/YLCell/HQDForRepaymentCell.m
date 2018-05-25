//
//  HQDForRepaymentCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/7.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "HQDForRepaymentCell.h"
#import "Header.h"

@interface HQDForRepaymentCell ()

{
    CGSize _size;
    UIFont *_fnt;
}

@property (strong, nonatomic) UIScrollView *scroll;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *noteLabel;

@end
@implementation HQDForRepaymentCell

- (UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.bounces = NO;
        _scroll.pagingEnabled = NO;
    }
    return _scroll;
}

- (void)referRepayWithModel:(BFHQDModel *)model
{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    _fnt = [UIFont systemFontOfSize:14];
    self.scroll.contentSize = CGSizeMake(self.titleArr.count * 130 + self.titleArr.count * 10, 160);
    [self.contentView addSubview:self.scroll];

    // 横向数据 第一排
    for (int i = 0 ; i < self.titleArr.count; i ++) {
        _size = [self.titleArr[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.alpha = 0.5;
        if (_size.width > 200) {
            NSInteger shang = _size.width/200;
            _titleLabel.frame = CGRectMake(5 + (140 * i), 10, 120 + 10, _size.height * (shang + 1));
        }else {
            _titleLabel.frame = CGRectMake(5 + (140 * i), 10, 120 + 10, 20);
        }
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = _fnt;
        _titleLabel.text = self.titleArr[i];
        [self.scroll addSubview:_titleLabel];
    }

    for (int i = 0; i < 4; i ++) {
        for (int j = 0; j < self.titleArr.count; j ++) {
            _noteLabel = [[UILabel alloc] init];
            _noteLabel.backgroundColor = [UIColor whiteColor];
            _noteLabel.textAlignment = NSTextAlignmentCenter;
            _noteLabel.tag = 100 + (i * 10) + j;
            _noteLabel.numberOfLines = 0;
            _noteLabel.font = _fnt;
            [self addContentModel:model WithLabelTag:_noteLabel];
        }
    }
    
}

- (void)addContentModel:(BFHQDModel *)model WithLabelTag:(UILabel *)label
{
    switch (label.tag) {
        case 100:
            label.text = @"本次拨付劳务费";
            break;
        case 101:
            label.text = [NSString stringWithFormat:@"%@",model.arApprolabourratio];
            break;
        case 102:
            label.text = [NSString stringWithFormat:@"%@",model.arApprolaboursubentry];
            break;
        case 103:
            label.text = [NSString stringWithFormat:@"%@",model.arApprolabouradvance];
            break;
        case 104:
            label.text = [NSString stringWithFormat:@"%@",model.arApprolabourendappro];
            break;
        case 105:
            label.text = [NSString stringWithFormat:@"%@",model.arApprolabournotappro];
            break;
        case 106:
            label.text = [NSString stringWithFormat:@"%@",model.arApprolabourremark];
            break;
        case 110:
            label.text = @"本次拨付材料费";
            break;
        case 111:
            label.text = [NSString stringWithFormat:@"%@",model.arAppromaterialratio];
            break;
        case 112:
            label.text = [NSString stringWithFormat:@"%@",model.arAppromaterialsubentry];
            break;
        case 113:
            label.text = [NSString stringWithFormat:@"%@",model.arAppromaterialadvance];
            break;
        case 114:
            label.text = [NSString stringWithFormat:@"%@",model.arAppromaterialendappro];
            break;
        case 115:
            label.text = [NSString stringWithFormat:@"%@",model.arAppromaterialnotappro];
            break;
        case 116:
            label.text = [NSString stringWithFormat:@"%@",model.arAppromaterialremark];
            break;
        case 120:
            label.text = @"本次拨付其他费用";
            break;
        case 121:
            label.text = [NSString stringWithFormat:@"%@",model.arApprootherratio];
            break;
        case 122:
            label.text = [NSString stringWithFormat:@"%@",model.arApproothersubentry];
            break;
        case 123:
            label.text = [NSString stringWithFormat:@"%@",model.arApprootheradvance];
            break;
        case 124:
            label.text = [NSString stringWithFormat:@"%@",model.arApprootherendappro];
            break;
        case 125:
            label.text = [NSString stringWithFormat:@"%@",model.arAppronotappro];
            break;
        case 126:
            label.text = [NSString stringWithFormat:@"%@",model.arApprootherremark];
            break;
        case 130:
            label.text = @"退垫付金额";
            break;
        case 131:
            label.hidden = YES;
            break;
        case 132:
            label.text = [NSString stringWithFormat:@"%@",model.arRefundadvancesubentry];
            break;
        case 133:
            label.hidden = YES;
            break;
        case 134:
            label.text = [NSString stringWithFormat:@"%@",model.arRefundadvanceendappro];
            break;
        case 135:
            label.hidden = YES;
            break;
        case 136:
            label.text = [NSString stringWithFormat:@"%@",model.arRefundadvanceremark];
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
}

- (CGRect )getContentWithAndHeight:(NSString *)content andTimes:(NSInteger )i
{
    _size = [content sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt, NSFontAttributeName, nil]];
    
    NSInteger rows = (i - 100)%10;
    NSInteger section = (i - 100)/10;
    return CGRectMake(5 + (140 * rows), 35 + (30 * section), 130, 20);
}

@end
