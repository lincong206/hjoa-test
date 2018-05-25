//
//  FPSJCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "FPSJCell.h"
#import "Header.h"

@interface FPSJCell ()

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


@property (strong, nonatomic) NSDate *timeDate;

@end

@implementation FPSJCell

- (void)creatFPSJApproveUIWithModel:(FPSJModel *)model
{
    _titleArr = @[@"申请类型",@"编号",@"申请人",@"申请时间",@"项目名称",
                  @"项目编号",@"项目负责人",@"负责人电话",@"合同编号",@"合同金额",
                  @"发票/收据单位名称",@"累计开发票金额",@"类型",@"发票/收据金额(元)",@"领票人",
                  @"领票人电话",@"申请税金金额",@"劳务发票金额",@"开票内容",@"纳税人识别号",
                  @"电话",@"银行户名",@"地址",@"备注"];
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

- (void)creatTextViewWithModel:(FPSJModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];

    switch (label.tag) {
        case 200:           //  申请类型
            if ([model.trIdtype isEqualToString:@"FPSJ"]) {
                label.text = @"开发票/收据申请";
            }else {
                label.text = @"";
            }
            break;
        case 201:           //  编号
            label.text = model.trIdnum;
            break;
        case 202:           //  申请人
            label.text = model.uiName;
            break;
        case 203:           //  申请时间
            
            _timeDate = [NSDate dateWithTimeIntervalSince1970:1497844238];
            label.text = [[[NSString stringWithFormat:@"%@",_timeDate] componentsSeparatedByString:@"+"] firstObject];
            break;
        case 204:           //  项目名称
            label.text = model.trProjectname;
            break;
        case 205:           //  项目编号
            label.text = model.trProjectidnum;
            break;
        case 206:           //  项目负责人
            label.text = model.trPrpojectleader;
            break;
        case 207:           //  负责人电话
            label.text = model.trProjectleaderphone;
            break;
        case 208:           //  合同编号
            label.text = model.trContractnum;
            break;
        case 209:           //  合同金额
            label.text = [NSString stringWithFormat:@"%@",model.trContractmoney];
            break;
        case 210:           //  发票/收据单位名称
            label.text = model.trUnitname;
            break;
        case 211:           //  累计开发票金额
            label.text = [NSString stringWithFormat:@"%@",model.trCumulative];
            break;
        case 212:           //  类型
            if ([model.trType isEqualToString:@"0"]) {
                label.text = @"普通设计发票";
            }else if ([model.trType isEqualToString:@"1"]) {
                label.text = @"专用设计发票";
            }else if ([model.trType isEqualToString:@"2"]) {
                label.text = @"普通工程发票";
            }else if ([model.trType isEqualToString:@"3"]) {
                label.text = @"专用工程发票";
            }else if ([model.trType isEqualToString:@"4"]) {
                label.text = @"收据";
            }
            break;
        case 213:           //  发票/收据金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.trTrmoney];
            break;
        case 214:           //  领票人
            label.text = model.trLed;
            break;
        case 215:           //  领票人电话
            label.text = model.trLedphone;
            break;
        case 216:           //  申请税金金额
            label.text = model.trApplemoney;
            break;
        case 217:           //  劳务发票金额
            label.text = [NSString stringWithFormat:@"%@",model.trLabourmoney];
            break;
        case 218:           //  开票内容
            label.text = model.trLinvoiceconet;
            break;
        case 219:           //  纳税人识别号
            label.text = model.trRegistrationnum;
            break;
        case 220:           //  电话
            label.text = model.trRegphone;
            break;
        case 221:           //  银行户名
            label.text = model.trRegbankname;
            break;
        case 222:           //  银行账号
            label.text = model.trRegbanknum;
            break;
        case 223:           //  银行
            label.text = model.trRegbank;
            break;
        case 224:           //  地址
            label.text = model.trRegadress;
            break;
        case 225:           //  备注
            label.text = model.trRegremark;
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
        [self.passHeightDelegate passHeightFromFPSJCell:_noteHeight + 10];
    }
}
@end
