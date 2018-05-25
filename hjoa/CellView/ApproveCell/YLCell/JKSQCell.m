//
//  JKSQCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/1.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JKSQCell.h"
#import "Header.h"

@interface JKSQCell ()

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

@implementation JKSQCell

- (void)creatJKSQApproveUIWithModel:(JKSQModel *)model
{
    _titleArr = @[@"资金申请人",@"制单日期",@"项目编号",@"项目名称",@"合同编号",
                  @"合同名称",@"借款日期",@"承诺还款日期",@"资金用途",@"申请金额(元)",
                  @"申请金额(大写)",@"借款人",@"收款人",@"借款人联系方式",@"利率",
                  @"开户银行全程",@"开户银行账号",@"备注"];
    _fnt = [UIFont systemFontOfSize:15];
    _noteHeight = 0;
    _titleHeight = 0;
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

- (void)creatTextViewWithModel:(JKSQModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  申请人
            label.text = model.uiName;
            break;
        case 201:           //  所属部门
            label.text = [model.pbaCreatetime componentsSeparatedByString:@" "].firstObject;
            break;
        case 202:           //  制单日期
            label.text = model.piIdnum;
            break;
        case 203:           //  项目编号
            label.text = model.piName;
            break;
        case 204:           //  项目名称
            label.text = model.piName;
            break;
        case 205:           //  合同编号
            label.text = model.bpcRealcontractid;
            break;
        case 206:           //  合同名称
            label.text = model.bpcName;
            break;
        case 207:           //  借款日期
            label.text = [model.pbaBorrowerdate componentsSeparatedByString:@" "].firstObject;
            break;
        case 208:           //  承诺还款日期
            label.text = [model.pbaRefunddate componentsSeparatedByString:@" "].firstObject;
            break;
        case 209:           //  资金用途
            label.text = model.pbaUse;
            break;
        case 210:           //  申请金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.pbaMoney];
            break;
        case 211:           //  申请金额(大写)
            label.text = model.pbaMoneyupper;
            break;
        case 212:           //  借款人
            label.text = model.pbaBorrowername;
            break;
        case 213:           //  收款人
            label.text = model.pbaPayeename;
            break;
        case 214:           //  借款人联系方式
            label.text = model.pbaBorrowerphone;
            break;
        case 215:           //  利率
            label.text = [NSString stringWithFormat:@"%@",model.pbaRate];
            break;
        case 216:           //  开户银行全程
            label.text = model.pbaOpenbank;
            break;
        case 217:           //  利率
            label.text = model.pbaOpenaccount;
            break;
        case 218:           //  利率
            label.text = model.pbaRemark;
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
        [self.passHeightDelegate passHeightFromJKSQCell:_noteHeight + 10];
    }
}




@end
