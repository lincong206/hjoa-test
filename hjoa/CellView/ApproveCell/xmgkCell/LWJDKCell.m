//
//  LWJDKCell.m
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "LWJDKCell.h"
#import "Header.h"

#import "DataBaseManager.h"
#import "addressModel.h"

@interface LWJDKCell ()
{
    UIFont *_fnt;
    NSInteger _shang;
    CGFloat _titleHeight;
    CGFloat _noteHeight;
    CGSize _titleSize;
    CGSize _size;
    NSInteger _count;
    
    NSString *_name;
}

@property (strong, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *noteLabel;

@end

@implementation LWJDKCell

- (void)creatLWJDKApproveUIWithModel:(LWJDKModel *)model
{
    
    for (addressModel *aModel in [[DataBaseManager shareDataBase] searchAllData]) {
        if (aModel.uiId.integerValue == model.uiId.integerValue) {
            _name = aModel.uiName;
        }
    }
    
    _titleArr = @[@"申请单编号",@"申请日期",@"工程名称",@"项目地址",@"合同内容",
                  @"合同编号",@"乙方",@"原合同金额(元)",@"开户银行",@"银行账号",
                  @"开始时间",@"结束时间",@"本次申请金额(元)",@"累计申请金额(元)",@"申请人",
                  @"形象进度",@"工作内容"];
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
- (void)creatTextViewWithModel:(LWJDKModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  申请类型
            label.text = model.rlpIdnum;
            break;
        case 201:           //  合作人
            label.text = [model.rlpApplicationtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 202:           //  工程名称
            label.text = model.piName;
            break;
        case 203:           //  项目地址
            label.text = model.piAdress;
            break;
        case 204:           //  合同内容
            label.text = model.rlcTreatycontent;
            break;
        case 205:           //  合同编号
            label.text = model.rlcContractnum;
            break;
        case 206:           //  乙方
            label.text = model.rlcSecond;
            break;
        case 207:           //  原合同金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.rlcManpower];
            break;
        case 208:           //  开户银行
            label.text = model.rlpDepositbank;
            break;
        case 209:           //  银行账号
            label.text = model.rlpBankaccount;
            break;
        case 210:           //  开始时间
            label.text = [model.rlpStarttime componentsSeparatedByString:@" "].firstObject;
            break;
        case 211:           //  结束时间
            label.text = [model.rlpEndtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 212:           //  本次申请金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.rlpApplicationamount];
            break;
        case 213:           //  累计申请金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.rlpAccruingamounts];
            break;
        case 214:           //  申请人
            label.text = _name;
            break;
        case 215:           //  形象进度
            label.text = model.rlpVisualschedule;
            break;
        case 216:           //  工作内容
            label.text = model.rlpJobcontent;
            break;
        default:
            break;
    }
    if (label.text == nil || [label.text isEqualToString:@"(null)"] || [label.text isEqual:[NSNull alloc]] || [label.text isEqualToString:@""] || [label.text isEqualToString:@" "]) {
        label.text = @"--";
    }
    _size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    // 当内容文字长度大于label文字显示长度  为多行时。
    if (_size.width > (kscreenWidth - 100) && _titleSize.width > 70) {  // 当标题高度大于内容高度 且都为多行
        _shang = _size.width/(kscreenWidth - 100);
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
    }else if (_size.width > (kscreenWidth - 100)) { // 当标题高度为单行 内容高度为多行，内容高度 大于 标题高度    // 当标题高度为多行时
        _shang = _size.width/(kscreenWidth - 100);
        label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height*(_shang+1));
        titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, _titleSize.height);
        _noteHeight += _size.height*(_shang+1)+10;
    }else if (_titleSize.width > 70) {  // 当标题高度为多行 内容高度为单行，内容高度 小于 标题高度
        NSInteger i = _titleSize.width/65;
        label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height);
        titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, (i+1)*_titleSize.height);
        _noteHeight += (i+1)*_titleSize.height+10;
    }else { //  当内容高度为一行时。    //  当都为一行时。
        label.frame = CGRectMake(10 + 70 + 10 , 10 + _noteHeight, (kscreenWidth - 100), _size.height);
        titleLabel.frame = CGRectMake(10, 10 + _noteHeight, 70, _size.height);
        _noteHeight += _size.height + 10;
    }
    [self.contentView addSubview:label];
    
    if (count == _titleArr.count - 1) {
        [self.passHeightDelegate passHeightFromLWJDKCell:_noteHeight + 10];
    }
}

@end
