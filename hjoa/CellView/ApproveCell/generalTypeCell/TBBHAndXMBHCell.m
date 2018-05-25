//
//  TBBHAndXMBHCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "TBBHAndXMBHCell.h"
#import "Header.h"

@interface TBBHAndXMBHCell ()
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

@implementation TBBHAndXMBHCell

- (void)creatTBBHAndXMBApproveUIWithModel:(TBBHAndXMBHModel *)model
{
    _titleArr = @[@"申请类型",@"编号",@"申请人",@"项目名称",@"项目编号",
                  @"项目地址",@"项目负责人",@"负责人电话",@"对方名称(建设单位)",@"保函金额(元)",
                  @"受益人",@"保函到期日",@"保函类别",@"格式要求",@"办理机构",
                  @"保证金比例(%)",@"保证金金额(元)(保函金额*保证金比例)",@"手续费比例(%)",@"期数",@"手续费金额(元)",
                  @"需提交资料",@"指定办理银行",@"开户银行全称",@"转款人开户银行全称",@"转款人开户名",
                  @"转款人银行账号",@"转款金额(元)",@"转款时间",];
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

- (void)creatTextViewWithModel:(TBBHAndXMBHModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  申请类型
            label.text = self.nameCell;
            break;
        case 201:           //  编号
            label.text = model.gaIdnum;
            break;
        case 202:           //  申请人
            label.text = model.gaUiname;
            break;
        case 203:           //  项目名称
            label.text = model.gaPiname;
            break;
        case 204:           //  项目编号
            label.text = model.gaPiidnum;
            break;
        case 205:           //  项目地址
            label.text = model.gaPiadress;
            break;
        case 206:           //  项目负责人
            label.text = model.gaPmname;
            break;
        case 207:           //  负责人电话
            label.text = model.gaPmphone;
            break;
        case 208:           //  对方名称(建设单位)
            label.text = model.gaPibuild;
            break;
        case 209:           //  保函金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.gaMoney];
            break;
        case 210:           //  受益人
            label.text = model.gaBeneficiary;
            break;
        case 211:           //  保函到期日
            label.text = [NSString stringWithFormat:@"%@",[model.gaValidtime componentsSeparatedByString:@" "].firstObject];
            break;
        case 212:           //  保函类别
            if (model.gaType.integerValue == 0) {
                label.text = @"履约保函";
            }else if (model.gaType.integerValue == 1) {
                label.text = @"预付款保函";
            }else if (model.gaType.integerValue == 2) {
                label.text = @"工人工资保函";
            }else if (model.gaType.integerValue == 3) {
                label.text = @"其他";
            }
            break;
        case 213:           //  格式要求
            if (model.gaRequire.integerValue == 0) {
                label.text = @"标准格式";
            }else if (model.gaRequire.integerValue == 1) {
                label.text = @"指定格式";
            }
            break;
        case 214:           //  办理机构
            if (model.gaTransaction.integerValue == 0) {
                label.text = @"银行";
            }else if (model.gaTransaction.integerValue == 1) {
                label.text = @"担保";
            }else if (model.gaTransaction.integerValue == 2) {
                label.text = @"其他";
            }
            break;
        case 215:           //  保证金比例(%)
            label.text = model.gaDepositpercent;
            break;
        case 216:           //  保证金金额(元)(保函金额*保证金比例)
            label.text = [NSString stringWithFormat:@"%@",model.gaDepositcash];
            break;
        case 217:           //  手续费比例(%)
            label.text = model.gaFactoragepercent;
            break;
        case 218:           //  期数
            label.text = [NSString stringWithFormat:@"%@",model.gaPeriods];
            break;
        case 219:           //  手续费金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.gaFactoragecash];
            break;
        case 220:           //  需提交资料
            label.text = model.gaCommitdata;
            break;
        case 221:           //  指定办理银行
            label.text = model.gaAssignbank;
            break;
        case 222:           //  开户银行全称
            label.text = model.gaOpeningbankname;
            break;
        case 223:           //  转款人开户银行全称
            label.text = model.gaTransferbankname;
            break;
        case 224:           //  转款人开户名
            label.text = model.gaTransferbank;
            break;
        case 225:           //  转款人银行账号
            label.text = model.gaTransferbanknum;
            break;
        case 226:           //  转款金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.gaTransfermoney];
            break;
        case 227:           //  转款时间
            label.text = [NSString stringWithFormat:@"%@",[model.gaTransfertime componentsSeparatedByString:@" "].firstObject];
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
        [self.passHeightDelegate passHeightFromTBBHAndXMBHCell:_noteHeight + 10];
    }
}



@end
