//
//  LWJSKCell.m
//  hjoa
//
//  Created by 华剑 on 2018/6/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "LWJSKCell.h"
#import "Header.h"

#import "DataBaseManager.h"
#import "addressModel.h"

@interface LWJSKCell ()
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
@implementation LWJSKCell

- (void)creatLWJSKApproveUIWithModel:(LWJSKModel *)model
{
    
    for (addressModel *aModel in [[DataBaseManager shareDataBase] searchAllData]) {
        if (aModel.uiId.integerValue == model.uiId.integerValue) {
            _name = aModel.uiName;
        }
    }
    
    _titleArr = @[@"申请单编号",@"申请人",@"申请日期",@"工程名称",@"项目地址",
                  @"合同内容",@"合同编号",@"乙方",@"开户银行",@"银行账号",@"原合同内工程小计(元)",
                  @"增加工程签证部分小计(元)",@"可计算工程款合计(元)",@"前期已支付工程款(元)",@"扣除公司代工代付材料款(元)",@"扣维修人工费(元)",
                  @"扣维修材料费(元)",@"按比例分摊保险费(元)",@"扣质保金比例(%)",@"扣质保金",@"实际可计算工程款合计(元)"];
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
- (void)creatTextViewWithModel:(LWJSKModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:
            label.text = model.rspIdnum;
            break;
        case 201:
            label.text = _name;
            break;
        case 202:
            label.text = [model.rspApplicationtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 203:
            label.text = model.piName;
            break;
        case 204:
            label.text = model.piAdress;
            break;
        case 205:
            label.text = model.rlcTreatycontent;
            break;
        case 206:
            label.text = model.rlcContractnum;
            break;
        case 207:
            label.text = model.rlcSecond;
            break;
        case 208:
            label.text = model.rspDepositbank;
            break;
        case 209:
            label.text = model.rspBankaccount;
            break;
        case 210:
            label.text = [NSString stringWithFormat:@"%@",model.rlcManpower];
            break;
        case 211:
            label.text = [NSString stringWithFormat:@"%@",model.rspVisamoney];
            break;
        case 212:
            label.text = [NSString stringWithFormat:@"%@",model.rspProjectmoney];
            break;
        case 213:
            label.text = [NSString stringWithFormat:@"%@",model.rlpAccruingamounts];
            break;
        case 214:
            label.text = [NSString stringWithFormat:@"%@",model.rspMaterialsmoney];
            break;
        case 215:
            label.text = [NSString stringWithFormat:@"%@",model.rspArtificialmoney];
            break;
        case 216:
            label.text = [NSString stringWithFormat:@"%@",model.rspMaintainmoney];
            break;
        case 217:
            label.text = [NSString stringWithFormat:@"%@",model.rspInsurancemoney];
            break;
        case 218:
            label.text = [NSString stringWithFormat:@"%@",model.rspDepositratio];
            break;
        case 219:
            label.text = [NSString stringWithFormat:@"%@",model.rspDepositmoney];
            break;
        case 220:
            label.text = [NSString stringWithFormat:@"%@",model.rspAccountmoney];
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
        [self.passHeightDelegate passHeightFromLWJSKCell:_noteHeight + 10];
    }
}

@end
