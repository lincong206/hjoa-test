//
//  CGHTCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CGHTCell.h"
#import "Header.h"

@interface CGHTCell ()

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
@implementation CGHTCell

- (void)creatCGHTApproveUIWithModel:(CGHTModel *)model
{
    _titleArr = @[@"合同编号",@"项目名称",@"项目编号",@"合同名称",@"合同供应商",
                  @"合同签订日期",@"材料单价类型",@"支付币种",@"合同金额(元)",@"预付款比例(%)",
                  @"预付款金额",@"进度付款比例(%)",@"结算付款比例(%)",@"质量保证金比例(%)",@"质保期(天)",
                  @"合同主要内容",@"付款方式",@"到场时间",@"供应商有无资质类型",@"是否为暂时估价",
                  @"材料类型",@"是否有税票",@"材料名称",@"备注"];
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

- (void)creatTextViewWithModel:(CGHTModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  合同编号
            label.text = model.mctContractnum;
            break;
        case 201:           //  项目名称
            label.text = model.piName;
            break;
        case 202:           //  项目编号
            label.text = model.piIdnum;
            break;
        case 203:           //  合同名称
            label.text = model.mctName;
            break;
        case 204:           //  合同供应商
            label.text = model.mctContractsupplier;
            break;
        case 205:           //  合同签订日期
            label.text = model.mctContractsigndate;//
            break;
        case 206:           //  材料单价类型
            if (model.mctMarterialpricetype.integerValue == 0) {
                label.text = @"单价浮动";
            }else {
                label.text = @"单价固定";
            }
            break;
        case 207:           //  支付币种
            if (model.mctMoneytype.integerValue == 0) {
                label.text = @"人民币";
            }else if (model.mctMoneytype.integerValue == 1) {
                label.text = @"港元";
            }else if (model.mctMoneytype.integerValue == 2) {
                label.text = @"美元";
            }else {
                label.text = @"欧元";
            }
            break;
        case 208:           //  合同金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.mctContractmoney];
            break;
        case 209:           //  预付款比例(%)
            label.text = [NSString stringWithFormat:@"%@",model.mctPrepayratio];
            break;
        case 210:           //  预付款金额
            label.text = [NSString stringWithFormat:@"%@",model.mctPrepaymoney];
            break;
        case 211:           //  进度付款比例(%)
            label.text = [NSString stringWithFormat:@"%@",model.mctPlanpayratio];
            break;
        case 212:           //  结算付款比例(%)
            label.text = [NSString stringWithFormat:@"%@",model.mctSettlepayratio];
            break;
        case 213:           //  质量保证金比例(%)
            label.text = [NSString stringWithFormat:@"%@",model.mctQaratio];
            break;
        case 214:           //  质保期(天)
            label.text = [NSString stringWithFormat:@"%@",model.mctQaday];
            break;
        case 215:           //  合同主要内容
            label.text = model.mctContractcontent;
            break;
        case 216:           //  付款方式
            label.text = model.mctPaytype;
            break;
        case 217:           //  到场时间
            label.text = model.mctEnterdate;
            break;
        case 218:           //  供应商有无资质类型
            if (model.mctSupplierintelligence.integerValue == 0) {
                label.text = @"有资质";
            }else {
                label.text = @"无资质";
            }
            break;
        case 219:           //  是否为暂时估价
            if (model.mctIstempcost.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 220:           //  材料类型
            if (model.mctMaterialtype.integerValue == 0) {
                label.text = @"主材";
            }else {
                label.text = @"辅材";
            }
            break;
        case 221:           //  是否有税票
            if (model.mctIstaxreceipt.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 222:           //  材料名称
            label.text = model.mctMaterialname;
            break;
        case 223:           //  备注
            label.text = model.mctRemark;
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
        [self.passHeightDelegate passHeightFromCGHTCell:_noteHeight + 10];
    }
}

@end
