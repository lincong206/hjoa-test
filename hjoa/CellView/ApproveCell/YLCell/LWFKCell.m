//
//  LWFKCell.m
//  hjoa
//
//  Created by 华剑 on 2017/7/31.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "LWFKCell.h"
#import "Header.h"

@interface LWFKCell ()

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

@implementation LWFKCell

- (void)creatLWFKApproveUIWithModel:(LWFKModel *)model
{
    _titleArr = @[@"项目编号",@"申请日期",@"项目名称",@"工程总造价",@"结算价",
                  @"施工内容",@"劳务方式",@"开户银行",@"开户账号",@"累计应付款金额(1)",
                  @"累计批付款金额(2)",@"累计已付款金额(3)",@"累计应付未批款金额(4) = (1) - (2)",@"累计应付未付款金额(5) = (1) - (3)",@"累计已批未付款金额(6) = (2) - (3)",
                  @"本次批付款金额(7)",@"本次税金金额",@"本次合计金额",@"备注"];
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

- (void)creatTextViewWithModel:(LWFKModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];

    switch (label.tag) {
        case 200:           //  项目编号
            label.text = model.piIdnum;
            break;
        case 201:           //  申请日期
            label.text = model.ploCreatetime;
            break;
        case 202:           //  项目名称
            label.text = model.piName;
            break;
        case 203:           //  工程总造价
            label.text = [NSString stringWithFormat:@"%@",model.ploProjectprice];
            break;
        case 204:           //  结算价
            label.text = [NSString stringWithFormat:@"%@",model.ploSetterprice];
            break;
        case 205:           //  施工内容
            label.text = model.ploConstruct;
            break;
        case 206:           //  劳务方式
            label.text = model.ploLabourpaytype;
            break;
        case 207:           //  开户银行
            label.text = model.ploOpenbank;
            break;
        case 208:           //  开户账号
            label.text = model.ploBankaccount;
            break;
        case 209:           //  累计应付款金额(1)
            label.text = [NSString stringWithFormat:@"%@",model.ploTotalwillexpend];
            break;
        case 210:           //  累计批付款金额(2)
            label.text = [NSString stringWithFormat:@"%@",model.ploTotalpasspay];
            break;
        case 211:           //  累计已付款金额(3)
            label.text = [NSString stringWithFormat:@"%@",model.ploTotalfinishexpend];
            break;
        case 212:           //  累计应付未批款金额(4) = (1) - (2)
            label.text = [NSString stringWithFormat:@"%@",model.ploTotalunsanctioned];
            break;
        case 213:           //  累计应付未付款金额(5) = (1) - (3)
            label.text = [NSString stringWithFormat:@"%@",model.ploTotalunpaid];
            break;
        case 214:           //  累计已批未付款金额(6) = (2) - (3)
            label.text = [NSString stringWithFormat:@"%@",model.ploTotalsanctioned];
            break;
        case 215:           //  本次批付款金额(7)
            label.text = [NSString stringWithFormat:@"%@",model.ploCurrentpasspay];
            break;
        case 216:           //  本次税金金额
            label.text = [NSString stringWithFormat:@"%@",model.ploTax];
            break;
        case 217:           //  本次合计金额
            label.text = [NSString stringWithFormat:@"%@",model.ploCurrecttotal];
            break;
        case 218:           //  备注
            label.text = model.ploRemark;
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
        [self.passHeightDelegate passHeightFromLWFKCell:_noteHeight + 10];
    }
}

@end
