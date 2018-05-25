//
//  LWFBHTCell.m
//  hjoa
//
//  Created by 华剑 on 2018/5/21.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "LWFBHTCell.h"
#import "Header.h"
#import "DataBaseManager.h"
#import "addressModel.h"

@interface LWFBHTCell ()
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
@property (strong, nonatomic) UILabel *noteLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSArray *titleArr;

@end
@implementation LWFBHTCell
- (void)creatLWFBHTApproveUIWithModel:(LWFBHTModel *)model
{
    if ([model.uiId isEqual:[NSNull alloc]]) {
        _name = @"--";
    }else {
        NSMutableArray *dataArrM = [[DataBaseManager shareDataBase] searchAllData];
        for (addressModel *addresModel in dataArrM) {
            if ([model.uiId integerValue] == addresModel.uiId.intValue) {
                _name = addresModel.uiName;
            }
        }
    }
    
    _titleArr = @[@"工程名称",@"项目地址",@"合同内容",@"合同编号",@"甲方",
                  @"乙方",@"甲方地址",@"乙方地址",@"甲方联系人",@"乙方电话",
                  @"甲方电话",@"工程范围、内容",@"人工费总价小写(元)",@"承包方式",@"工程质量标准",
                  @"施工开始时间",@"施工竣工时间",@"工期(天)",@"合同订立形式",@"合同签订日期",
                  @"操作人",@"其它说明",@"固定文件"];
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
- (void)creatTextViewWithModel:(LWFBHTModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  工程名称
            label.text = model.piName;
            break;
        case 201:           //  项目地址
            label.text = model.piAddresspca;
            break;
        case 202:           //  合同内容
            label.text = model.rlcTreatycontent;
            break;
        case 203:           //  合同编号
            label.text = model.rlcContractnum;
            break;
        case 204:           //  甲方
            label.text = model.rlcPecific;
            break;
        case 205:           //  乙方
            label.text = model.rlcSecond;
            break;
        case 206:           //  甲方地址
            label.text = model.rlcPecificaddress;
            break;
        case 207:           //  乙方地址
            label.text = model.rlcSecondaddress;
            break;
        case 208:           //  甲方联系人
            label.text = model.rlcPecificname;
            break;
        case 209:           //  乙方电话
            label.text = model.rlcSecondphone;
            break;
        case 210:           //  甲方电话
            label.text = model.rlcPecificphone;
            break;
        case 211:           //  工程范围、内容
            label.text = model.rlcProjectcontent;
            break;
        case 212:           //  人工费总价小写(元)
            label.text = [NSString stringWithFormat:@"%@",model.rlcManpower];
            break;
        case 213:           //  承包方式
            label.text = model.rlcDesignbuild;
            break;
        case 214:           //  工程质量标准
            if (model.rlcStandard.integerValue == 0) {
                label.text = @"合格";
            }else if (model.rlcStandard.integerValue == 1){
                label.text = @"鲁班奖";
            }else if (model.rlcStandard.integerValue == 2){
                label.text = @"市优";
            }else if (model.rlcStandard.integerValue == 3){
                label.text = @"省优";
            }else if (model.rlcStandard.integerValue == 4){
                label.text = @"国优";
            }else {
                label.text = @"";
            }
            break;
        case 215:           //  施工开始时间
            label.text = [model.rlcConstructionstarttime componentsSeparatedByString:@" "].firstObject;
            break;
        case 216:           //  施工竣工时间
            label.text = [model.rlcConstructionendtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 217:           //  工期(天)
            label.text = model.rlcDuration;
            break;
        case 218:           //  合同订立形式
            if (model.rlcContractform.integerValue == 0) {
                label.text = @"书面合同";
            }else if (model.rlcContractform.integerValue == 1) {
                label.text = @"口头合同";
            }else {
                label.text = @"";
            }
            break;
        case 219:           //  合同签订日期
            label.text = [model.rlcDateofcontract componentsSeparatedByString:@" "].firstObject;
            break;
        case 220:           //  操作人
            label.text = _name;
            break;
        case 221:           //  其它说明
            label.text = model.rlcExplain;
            break;
        case 222:           //  固定文件
            label.text = @"工资表,考勤表,专款到账表";
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
        [self.passHeightDelegate passHeightFromLWFBHT:_noteHeight + 10];
    }
}
@end
