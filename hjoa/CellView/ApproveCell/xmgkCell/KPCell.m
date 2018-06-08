//
//  KPCell.m
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "KPCell.h"
#import "Header.h"

@interface KPCell ()
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
@implementation KPCell

- (void)creatKPApproveUIWithModel:(KPModel *)model
{
    _titleArr = @[@"开票申请编号",@"申请人",@"申请日期",@"项目名称",@"项目编号",
                  @"项目负责人",@"负责人电话",@"合同编号",@"合同金额",@"发票/收据单位名称",@"累计开发票金额",
                  @"类型",@"发票/收据金额(元)",@"领票人",@"领票人电话",@"申请税金金额(元)",
                  @"劳务发票金额(元)",@"开票内容",@"纳税人识别号",@"电话",@"银行户名",
                  @"银行账号",@"银行",@"地址",@"制单人",@"开票日期",
                  @"发票抬头",@"纳税人识别号",@"含税金额合计(元)",@"不含税金额合计(元)",@"税额合计(元)",
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
- (void)creatTextViewWithModel:(KPModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:
            label.text = model.trIdnum;
            break;
        case 201:
            label.text = model.uiName;
            break;
        case 202:
//            label.text = model.trCreattime;
            break;
        case 203:
            label.text = model.trProjectname;
            break;
        case 204:
            label.text = model.trProjectidnum;
            break;
        case 205:
            label.text = model.trPrpojectleader;
            break;
        case 206:
            label.text = model.trProjectleaderphone;
            break;
        case 207:
            label.text = model.trContractnum;
            break;
        case 208:
            label.text = model.trContractmoney;
            break;
        case 209:
            label.text = model.trUnitname;
            break;
        case 210:
            label.text = [NSString stringWithFormat:@"%@",model.trCumulative];
            break;
        case 211:
            if (model.trType.integerValue == 0) {
                label.text = @"普通设计发票";
            }else if (model.trType.integerValue == 1) {
                label.text = @"专用设计发票";
            }else if (model.trType.integerValue == 2) {
                label.text = @"普通工程发票";
            }else if (model.trType.integerValue == 3) {
                label.text = @"专用工程发票";
            }else if (model.trType.integerValue == 4) {
                label.text = @"收据";
            }else {
                label.text = @"";
            }
            break;
        case 212:
            label.text = [NSString stringWithFormat:@"%@",model.trTrmoney];
            break;
        case 213:
            label.text = model.trLed;
            break;
        case 214:
            label.text = model.trLedphone;
            break;
        case 215:
            label.text = [NSString stringWithFormat:@"%@",model.trApplemoney];
            break;
        case 216:
            label.text = [NSString stringWithFormat:@"%@",model.trLabourmoney];
            break;
        case 217:
            label.text = model.trLinvoiceconet;
            break;
        case 218:
            label.text = model.trRegistrationnum;
            break;
        case 219:
            label.text = model.trRegphone;
            break;
        case 220:
            label.text = model.trRegbankname;
            break;
        case 221:
            label.text = model.trRegbanknum;
            break;
        case 222:
            label.text = model.trRegbank;
            break;
        case 223:
            label.text = model.trRegadress;
            break;
        case 224:
            label.text = model.oiDrawer;
            break;
        case 225:
            label.text = model.oiCreatetime;
            break;
        case 226:
            label.text = model.oiInvoicetitle;
            break;
        case 227:
            label.text = model.oiTaxpayerid;
            break;
        case 228:
            label.text = [NSString stringWithFormat:@"%@",model.oiTaxinclusive];
            break;
        case 229:
            label.text = [NSString stringWithFormat:@"%@",model.oiNottaxinclusive];
            break;
        case 230:
            label.text = [NSString stringWithFormat:@"%@",model.oiTax];
            break;
        case 231:
            label.text = model.oiRemark;
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
        [self.passHeightDelegate passHeightFromKPCell:_noteHeight + 10];
    }
}


@end
