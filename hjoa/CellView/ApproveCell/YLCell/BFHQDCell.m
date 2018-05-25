//
//  BFHQDCell.m
//  hjoa
//
//  Created by 华剑 on 2017/7/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "BFHQDCell.h"
#import "Header.h"

@interface BFHQDCell ()

{
    UIFont *_fnt;
    NSInteger _shang;
    CGFloat _titleHeight;
    CGFloat _noteHeight;
    CGSize _titleSize;
    CGSize _size;
    NSInteger _count;
}

@property (strong, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *noteLabel;

@end

@implementation BFHQDCell

- (void)creatBFHQDApproveUIWithModel:(BFHQDModel *)model
{
    _titleArr = @[@"项目编号",@"项目名称",@"项目责任人",@"合同编号",@"合同名称",
                  @"合同总金额",@"原合同金额",@"补充金额",@"甲方名称",@"累计收款金额",
                  @"累计扣款金额",@"累计应拨款金额",@"累计已批可拨款金额",@"累计已拨款金额",@"累计借款余额",
                  @"累计垫付余额",@"可用余额",@"外经证办理状态",@"本次拨款金额",@"拨款申请日期",
                  @"备注"];
    _fnt = [UIFont systemFontOfSize:15];
    _titleHeight = 0;
    _noteHeight = 0;
    for (int i = 0; i < _titleArr.count; i ++) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = _fnt;
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_titleLabel];
        
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.tag = 200 + i;
        _noteLabel.font = _fnt;
        _noteLabel.numberOfLines = 0;
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.backgroundColor = [UIColor clearColor];
        _noteLabel.textColor = [UIColor blackColor];
        [self creatTextViewWithModel:model andLabel:_noteLabel andCount:i andTitleLabel:_titleLabel andTitleSize:_titleSize];
    }
}

- (void)creatTextViewWithModel:(BFHQDModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  项目编号
            label.text = model.piIdnum;
            break;
        case 201:           //  项目名称
            label.text = model.piName;
            break;
        case 202:           //  项目责任人
            label.text = model.uiManagername;
            break;
        case 203:           //  合同编号
            label.text = model.bpcRealcontractid;
            break;
        case 204:           //  合同名称
            label.text = model.bpcName;
            break;
        case 205:           //  合同总金额
            label.text = [NSString stringWithFormat:@"%@",model.bpcProjectprice];
            break;
        case 206:           //  原合同金额
            label.text = [NSString stringWithFormat:@"%@",model.bpcSupplyfee];
            break;
        case 207:           //  补充金额
            label.text = @"";
            break;
        case 208:           //  甲方名称
            label.text = model.piBuildcompany;
            break;
        case 209:           //  累计收款金额
            label.text = [NSString stringWithFormat:@"%@",model.arTotalpayee];
            break;
        case 210:           //  累计扣款金额
            label.text = [NSString stringWithFormat:@"%@",model.arWithhold];
            break;
        case 211:           //  累计应拨款金额
            label.text = [NSString stringWithFormat:@"%@",model.arTotalwillexpend];
            break;
        case 212:           //  累计已批可拨款金额
            label.text = [NSString stringWithFormat:@"%@",model.arTotalpasscanpay];
            break;
        case 213:           //  累计已拨款金额
            label.text = [NSString stringWithFormat:@"%@",model.arTotalfinishexpend];
            break;
        case 214:           //  累计借款余额
            label.text = [NSString stringWithFormat:@"%@",model.arTotallend];
            break;
        case 215:           //  累计垫付余额
            label.text = [NSString stringWithFormat:@"%@",model.arTotaladvance];
            break;
        case 216:           //  可用余额
            label.text = [NSString stringWithFormat:@"%@",model.arCanbalance];
            break;
        case 217:           //  外经证办理状态
            label.text = model.arOuttrackstatus;
            break;
        case 218:           //  本次拨款金额
            label.text = [NSString stringWithFormat:@"%@",model.arTotalmoney];
            break;
        case 219:           //  拨款申请日期
            label.text = [model.arCreatetime componentsSeparatedByString:@" "].firstObject;
            break;
        case 220:           //  备注
            label.text = model.arRemark;
            break;
        default:
            break;
    }
    if (label.text == nil || [label.text isEqualToString:@"(null)"] || [label.text isEqual:[NSNull alloc]] || [label.text isEqualToString:@""] || [label.text isEqualToString:@" "]) {
        label.text = @"--";
    }
    _size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    // 当内容文字长度大于label文字显示长度  为多行时。
    if (_size.width > (kscreenWidth - 100)) {
        _shang = _size.width/(kscreenWidth - 100);
        if (_titleSize.width > 70) {  // 当标题高度大于内容高度 且都为多行
            NSInteger i = _titleSize.width/65;
            if ((i+1)*titleLabel.bounds.size.height > _size.height*(_shang+1)) {    // 标题的高度 大于 内容的高度
                label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height*(_shang+1));
                titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, (i+1)*_titleSize.height);
                _noteHeight += (i+1)*_titleSize.height+10;
            }else {     // 内容高度 大于 标题高度
                label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height*(_shang+1));
                titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, (i+1)*_titleSize.height);
                _noteHeight += _size.height*(_shang+1)+10;
            }
        }else {     // 当标题高度为单行 内容高度为多行，内容高度 大于 标题高度
            label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height*(_shang+1));
            titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, _titleSize.height);
            _noteHeight += _size.height*(_shang+1)+10;
        }
    }else { //  当内容高度为一行时。
        if (_titleSize.width > 70) {     // 当标题高度为多行时
            NSInteger i = _titleSize.width/65;
            if ((i+1)*_titleSize.height > _size.height) {    //  当标题高度大于内容高度。标题为多行时。
                label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height);
                titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, (i+1)*_titleSize.height);
                _noteHeight += (i+1)*_titleSize.height+10;
            }
        }else {     //  当都为一行时。
            label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height);
            titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, _size.height);
            _noteHeight += _size.height + 10;
        }
    }
    [self.contentView addSubview:label];
    
    if (count == _titleArr.count - 1) {
        [self.passHeightDelegate passHeightFromBFHQDCell:_noteHeight + 10];
    }
}

@end
