//
//  WPCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "WPCell.h"
#import "Header.h"

@interface WPCell ()
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

@implementation WPCell

- (void)creatWPApproveUIWithModel:(WPModel *)model
{
    _titleArr = @[@"发起人姓名",@"发起部门",@"制单日期",@"外派人员姓名",@"身份证号码",
                  @"联系电话",@"住址",@"项目负责人姓名",@"身份证号码",@"联系电话",
                  @"住址",@"合作工程项目名",@"合作工作地点",@"合同金额(元)",@"外派人员基本工资(元)",
                  @"绩效工资(元)",@"开户银行",@"银行账号",@"银行印鉴"];
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

- (void)creatTextViewWithModel:(WPModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  发起人姓名
            label.text = model.uiName;
            break;
        case 201:           //  发起部门
            label.text = model.uiPsname;
            break;
        case 202:           //  制单日期
            label.text = [model.dearCreatetime componentsSeparatedByString:@"."].firstObject;
            break;
        case 203:           // 外派人员姓名
            label.text = model.deaaPropeser;
            break;
        case 204:           //  身份证号码
            label.text = model.deaaIdcard;
            break;
        case 205:           //  联系电话
            label.text = model.deaaPhone;
            break;
        case 206:           //  住址
            label.text = model.deaaAddress;
            break;
        case 207:           //  合作人姓名
            label.text = model.deaaCooperationname;
            break;
        case 208:           //  身份证号码
            label.text = model.deaaCooperationidcard;
            break;
        case 209:           //  联系电话
            label.text = model.deaaCooperationphone;
            break;
        case 210:           //  住址
            label.text = model.deaaCooperationaddress;
            break;
        case 211:           //  合作工程项目名
            label.text = model.deaaProname;
            break;
        case 212:           //  合作工作地点
            label.text = model.deaaProaddress;
            break;
        case 213:           //  合同金额
            label.text = [NSString stringWithFormat:@"%@",model.deaaMoney];
            break;
        case 214:           //  外派人员基本工资
            label.text = [NSString stringWithFormat:@"%@",model.deaaBasicsalary];
            break;
        case 215:           //  绩效工资
            label.text = [NSString stringWithFormat:@"%@",model.deaaPerformancesalary];
            break;
        case 216:           //  开户银行
            label.text = model.deaaOpenbank;
            break;
        case 217:           //  银行账号
            label.text = model.deaaBankaccount;
            break;
        case 218:           //  银行印鉴
            label.text = model.deaaBanksign;
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
        [self.passHeightDelegate passHeightFromWPCell:_noteHeight + 10];
    }
}

@end
