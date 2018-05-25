//
//  ZBDLCell.m
//  hjoa
//
//  Created by 华剑 on 2017/10/20.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "ZBDLCell.h"
#import "Header.h"

@interface ZBDLCell ()

{
    UIFont *_fnt;
    NSInteger _shang;
    CGFloat _titleHeight;
    CGFloat _noteHeight;
    CGSize _titleSize;
    CGSize _size;
    NSInteger _count;
}
@property (strong, nonatomic) UILabel *noteLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSArray *titleArr;

@end

@implementation ZBDLCell

- (void)creatZBDLApproveUIWithModel:(ZBDLModel *)model
{
    _titleArr = @[@"申请编号",@"申请日期",@"申请人",@"项目编号",@"项目名称",
                  @"费用类型",@"招标单位(建设单位)",@"所属区域",@"来款单位全称",@"付款方式",
                  @"收款单位全称",@"是否提供委托书",@"开户银行全称",@"最晚付款期限",@"开户银行账号",
                  @"是否开收据",@"开户银行地址",@"是否垫付",@"金额(元)",@"金额(大写)",
                  @"项目负责人",@"联系方式",@"说明"];
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

- (void)creatTextViewWithModel:(ZBDLModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  申请编号
            label.text = model.bpaIdnum;
            break;
        case 201:           //  申请日期
            label.text = [model.bpaCreatedate componentsSeparatedByString:@" "].firstObject;
            break;
        case 202:           //  申请人
            label.text = model.uiName;
            break;
        case 203:           //  项目编号
            label.text = model.piIdnum;
            break;
        case 204:           //  项目名称
            label.text = model.piName;
            break;
        case 205:           //  费用类型
            label.text = model.bpaExpectedreturnbidtime;//
            break;
        case 206:           //  招标单位(建设单位)
            label.text = model.piBuildcompany;
            break;
        case 207:           //  所属区域
            label.text = model.piRegion;
            break;
        case 208:           //  来款单位全称
            label.text = model.bpaPayerfullname;
            break;
        case 209:           //  付款方式
            label.text = model.bpaPaymentmethod;
            break;
        case 210:           //  收款单位全称
            label.text = model.bpaPayeefullname;
            break;
        case 211:           //  是否提供委托书
            label.text = model.bpaOfferpowerofattorney;
            break;
        case 212:           //  开户银行全称
            label.text = model.bpaOpenbankname;
            break;
        case 213:           //  最晚付款期限
            label.text = [model.bpaPromptatthelongest componentsSeparatedByString:@" "].firstObject;
            break;
        case 214:           //  开户银行账户
            label.text = model.bpaOpenbankaccount;
            break;
        case 215:           //  是否开收据
            label.text = model.bpaPayeeissuereceipt;
            break;
        case 216:           //  开户银行地址
            label.text = model.bpaOpenbankaddress;
            break;
        case 217:           //  是否垫付
            label.text = model.bpaIspayment;
            break;
        case 218:           //  金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.bpaBidmoney];
            break;
        case 219:           //  金额(大写)
            label.text = model.bpaBidmoneyupper;
            break;
        case 220:           //  项目负责人
            label.text = model.uiManagername;
            break;
        case 221:           //  联系方式
            label.text = model.uiManagermobile;
            break;
        case 222:           //  说明
            label.text = model.bpaRemark;
            break;
        default:
            break;
    }
    if (label.text == nil || [label.text isEqualToString:@"(null)"] || [label.text isEqual:[NSNull alloc]] || [label.text isEqualToString:@""] || [label.text isEqualToString:@" "] || [label.text isEqualToString:@"<null>"]) {
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
        [self.passHeightDelegate passHeightFromZBDL:_noteHeight + 10];
    }
}

@end
