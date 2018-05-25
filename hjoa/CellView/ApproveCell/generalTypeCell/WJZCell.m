//
//  WJZCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/28.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "WJZCell.h"
#import "Header.h"

@interface WJZCell ()
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
@implementation WJZCell

- (void)creatWJZApproveUIWithModel:(WJZModel *)model
{
    _titleArr = @[@"申请时间",@"申请人",@"申请人电话",@"申请部门",@"项目名称",
                  @"项目编码",@"合同编码",@"甲方名称",@"申请外经证金额",@"项目地址",
                  @"外出经营地址",@"原合同金额小写",@"原合同金额大写",@"总合同金额小写",@"总合同金额大写",
                  @"项目负责人",@"负责人联系方式",@"计税依据",@"合同印花税税率 (%)",@"合同印花税金额(元)",
                  @"合同印花税付款方式",@"合同印花税其他付款方式",@"押金金额(元)",@"押金缴纳方式",@"押金缴纳方式其他",
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

- (void)creatTextViewWithModel:(WJZModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];

    switch (label.tag) {
        case 200:           //  申请时间
            label.text = [[model.baApplydate componentsSeparatedByString:@" "] firstObject];
            break;
        case 201:           //  申请人
            label.text = model.uiName;
            break;
        case 202:           //  申请人电话
            label.text = model.uiMobile;
            break;
        case 203:           //  申请部门
            label.text = model.uiPsname;
            break;
        case 204:           //  项目名称
            label.text = model.piName;
            break;
        case 205:           //  项目编码
            label.text = model.piIdnum;
            break;
        case 206:           //  合同编码
            label.text = model.bpcRealcontractid;
            break;
        case 207:           //  甲方名称
            label.text = model.piBuildcompany;
            break;
        case 208:           //  申请外经证金额
            label.text = [NSString stringWithFormat:@"%@",model.baFee];
            break;
        case 209:           //  项目地址
            label.text = model.piAdress;
            break;
        case 210:           //  外出经营地址
            label.text = model.baAddresspca;
            break;
        case 211:           //  原合同金额小写
            label.text = [NSString stringWithFormat:@"%@",model.bpcProjectprice];
            break;
        case 212:           //  原合同金额大写
            label.text = model.bpcProjectbigprice;
            break;
        case 213:           //  总合同金额小写
            label.text = [NSString stringWithFormat:@"%@",model.bpcSupplyfee];
            break;
        case 214:           //  总合同金额大写
            label.text = model.bpcProjectbigprice;
            break;
        case 215:           //  项目负责人
            label.text = model.uiManagername;
            break;
        case 216:           //  负责人联系方式
            label.text = model.uiManagermobile;
            break;
        case 217:           //  计税依据
            label.text = [NSString stringWithFormat:@"%@",model.baTaxationbasis];
            break;
        case 218:           //  合同印花税税率 (%)
            label.text = [NSString stringWithFormat:@"%@",model.baTaxrate];
            break;
        case 219:           //  合同印花税金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.baTaxfee];
            break;
        case 220:           //  合同印花税付款方式
            if (model.baTaxpayway.integerValue == 0) {
                label.text = @"转账";
            }else if (model.baTaxpayway.integerValue == 1) {
                label.text = @"现金";
            }else {
                label.text = @"其他";
            }
            break;
        case 221:           //  合同印花税其他付款方式
            label.text = model.baTaxotherpayway;
            break;
        case 222:           //  押金金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.baDepositpayfee];
            break;
        case 223:           //  押金缴纳方式
            if (model.baDeopsitpayway.integerValue == 0) {
                label.text = @"转账";
            }else if (model.baDeopsitpayway.integerValue == 1) {
                label.text = @"现金";
            }else {
                label.text = @"其他";
            }
            break;
        case 224:           //  押金缴纳方式其他
            label.text = model.baDeopsitotherpayway;
            break;
        case 225:           //  备注
            label.text = model.baNote;
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
        [self.passHeightDelegate passHeightFromWJZCell:_noteHeight + 10];
    }
}

@end
