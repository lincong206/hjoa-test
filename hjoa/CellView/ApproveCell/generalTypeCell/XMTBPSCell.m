//
//  XMTBPSCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/24.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "XMTBPSCell.h"
#import "Header.h"
#import "addressModel.h"
#import "DataBaseManager.h"
@interface XMTBPSCell ()

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

@property (strong, nonatomic) NSString *BelongUser;

@end

@implementation XMTBPSCell

- (void)creatXMTBPSApproveUIWithModel:(XMTBPSModel *)model
{
    if ([model.bsProjectinfo[@"uiBelonguser"] isEqual:[NSNull alloc]]) {
        self.BelongUser = @"--";
    }else {
        NSMutableArray *dataArrM = [[DataBaseManager shareDataBase] searchAllData];
        for (addressModel *addresModel in dataArrM) {
            if ([model.bsProjectinfo[@"uiBelonguser"] integerValue] == addresModel.uiId.intValue) {
                self.BelongUser = addresModel.uiPsname;
            }
        }
    }
    
    _titleArr = @[@"项目负责人",@"业绩归属",@"所属部门",@"工程名称",@"甲方名称",
                 @"甲方性质",@"工程地址",@"资金来源及比例",@"预计造价/面积",@"总工期",
                 @"截标时间",@"评标办法",@"招标方式",@"合同承包方式",@"前期是否参与项目跟踪、设计",
                 @"历史投标个数",@"历史中标个数",@"项目负责人综合实力",@"项目中标概率",@"资格符合性评审",
                 @"付款方式",@"投标保证金金额及形式",@"履约保证金金额及形式",@"保修期及比例",@"其他"];

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
        _noteLabel.tag = 100 + i;
        _noteLabel.font = _fnt;
        _noteLabel.numberOfLines = 0;
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.backgroundColor = [UIColor clearColor];
        _noteLabel.textColor = [UIColor blackColor];
        [self creatTextViewWithModel:model andLabel:_noteLabel andCount:i andTitleLabel:_titleLabel andTitleSize:_titleSize];
    }
}

- (void)creatTextViewWithModel:(XMTBPSModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    switch (label.tag) {
        case 100:           //  项目负责人
            if ([model.bsProjectinfo[@"uiSourcename"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectinfo[@"uiSourcename"];
            }
            break;
        case 101:           //  业绩归属
            if ([model.bsProjectinfo[@"uiBelongname"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectinfo[@"uiBelongname"];
            }
            break;
        case 102:           //  所属部门
            label.text = self.BelongUser;
            break;
        case 103:           //  工程名称
            if ([model.bsProjectinfo[@"piName"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectinfo[@"piName"];
            }
            break;
        case 104:           //  甲方名称
            if ([model.bsProjectinfo[@"piBuildcompany"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectinfo[@"piBuildcompany"];
            }
            break;
        case 105:           //  甲方性质
            if ([model.bsProjectinfo[@"piPartytype"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                if ([model.bsProjectinfo[@"piPartytype"] integerValue] == 0) {
                    label.text = @"不限";
                }else if ([model.bsProjectinfo[@"piPartytype"] integerValue] == 1) {
                    label.text = @"私营";
                }else if ([model.bsProjectinfo[@"piPartytype"] integerValue] == 2) {
                    label.text = @"国有";
                }else if ([model.bsProjectinfo[@"piPartytype"] integerValue] == 3) {
                    label.text = @"政府机构";
                }else if ([model.bsProjectinfo[@"piPartytype"] integerValue] == 4) {
                    label.text = @"股份制";
                }else if ([model.bsProjectinfo[@"piPartytype"] integerValue] == 5) {
                    label.text = @"外资";
                }else {
                    label.text = @"其他";
                }
            }
            break;
        case 106:           //  工程地址
            if ([model.bsProjectinfo[@"piAddresspca"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectinfo[@"piAddresspca"];
            }
            break;
        case 107:
            label.text = model.beCapitalsource;
            break;
        case 108:
            if ([model.bsProjectinfo[@"piAddresspca"] isEqual:[NSNull alloc]] && [model.bsProjectinfo[@"piBuildingarea"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else if ([model.bsProjectinfo[@"piBuildingarea"] isEqual:[NSNull alloc]]) {
                label.text = [NSString stringWithFormat:@"%@万元",model.bsProjectinfo[@"piPrice"]];
            }else if ([model.bsProjectinfo[@"piAddresspca"] isEqual:[NSNull alloc]]) {
                label.text = [NSString stringWithFormat:@"%@平方米",model.bsProjectinfo[@"piBuildingarea"]];
            }else{
                label.text = [NSString stringWithFormat:@"%@万元/%@平方米",model.bsProjectinfo[@"piPrice"],model.bsProjectinfo[@"piBuildingarea"]];
            }
            break;
        case 109:           //  总工期
            label.text = model.beTotaltime;
            break;
        case 110:           //  截标时间
            label.text = [model.beClosingtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 111:           //  评标办法
            if (model.beEvaluationtype.integerValue == 1) {
                label.text = @"综合评估法";
            }else if (model.beEvaluationtype.integerValue == 2) {
                label.text = @"低价中标法";
            }else if (model.beEvaluationtype.integerValue == 3) {
                label.text = @"抽签定标法";
            }else if (model.beEvaluationtype.integerValue == 4) {
                label.text = @"其他";
            }
            break;
        case 112:           //  招标方式
            if (model.beBiddingtype.integerValue == 1) {
                label.text = @"公开招标";
            }else if (model.beBiddingtype.integerValue == 2) {
                label.text = @"邀请招标";
            }else if (model.beBiddingtype.integerValue == 3) {
                label.text = @"议标";
            }
            break;
        case 113:           //  合同承包方式
            if (model.beContractingtype.integerValue == 1) {
                label.text = @"固定单价";
            }else if (model.beContractingtype.integerValue == 2) {
                label.text = @"总价包干";
            }else if (model.beContractingtype.integerValue == 3) {
                label.text = @"成本加酬金合同";
            }
            break;
        case 114:           //  前期是否参与项目跟踪、设计
            if (model.beIsparticipation.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 115:           //  历史投标个数
            label.text = [NSString stringWithFormat:@"%@",model.beBidnum];
            break;
        case 116:           //  历史中标个数
            label.text = [NSString stringWithFormat:@"%@",model.beWinbidnum];
            break;
        case 117:           //  项目负责人综合实力
            if (model.beComprehensivestrength.integerValue == 1) {
                label.text = @"大型";
            }else if (model.beComprehensivestrength.integerValue == 2) {
                label.text = @"中型";
            }else if (model.beComprehensivestrength.integerValue == 3) {
                label.text = @"小型";
            }
            break;
        case 118:           //  项目中标概率
            label.text = model.beBidprobability;
            break;
        case 119:           //  资格符合性评审
            label.text = model.beJudge;
            break;
        case 120:           //  付款方式
            label.text = model.bePaytype;
            break;
        case 121:           //  投标保证金金额及形式
            label.text = model.beBidbond;
            break;
        case 122:           //  履约保证金金额及形式
            label.text = model.bePerformancebond;
            break;
        case 123:           //  保修期及比例
            label.text = model.beWarrantyperiod;
            break;
        case 124:           //  其他
            label.text = model.beOthers;
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
        [self.passHeightDelegate passHeightFromXMTBPS:_noteHeight + 10];
    }
}

@end
