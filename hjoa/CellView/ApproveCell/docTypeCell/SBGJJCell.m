//
//  SBGJJCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "SBGJJCell.h"
#import "Header.h"

@interface SBGJJCell ()
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

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDateFormatter *objDateformat;

@end

@implementation SBGJJCell

- (void)creatSBGJJApproveUIWithModel:(SBGJJModel *)model
{
    _titleArr = @[@"发起人姓名",@"发起部门",@"发起时间",@"姓名",@"部门",
                  @"职务",@"社保接纳基数",@"公积金缴纳基数",@"是否公司员工",@"是否持证人员",
                  @"原缴纳基数",@"现缴纳基数",@"医保综合",@"其他",@"收费方式",
                  @"申请理由",@"备注"];
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

- (void)creatTextViewWithModel:(SBGJJModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  发起人姓名
            label.text = model.uiName;
            break;
        case 201:           //  发起部门
            label.text = model.dssaInitiatordept;
            break;
        case 202:           //  发起时间
            _date = [NSDate dateWithTimeIntervalSince1970:[model.dssaCreatedate doubleValue] / 1000.0];
            [_objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            label.text = [[_objDateformat stringFromDate:_date] componentsSeparatedByString:@" "].firstObject;
            break;
        case 203:           // 姓名
            label.text = model.dssaName;
            break;
        case 204:           //  部门
            label.text = model.dssaDept;
            break;
        case 205:           //  职务
            label.text = model.dssaJob;
            break;
        case 206:           //  社保接纳基数
            label.text = [NSString stringWithFormat:@"%@",model.dssaSocialsecuritybase];
            break;
        case 207:           //  公积金缴纳基数
            label.text = [NSString stringWithFormat:@"%@",model.dssaAccumulationfundbase];
            break;
        case 208:           //  是否公司员工
            if (model.dssaIsemploy.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 209:           //  是否持证人员
            if (model.dssaIsholder.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 210:           //  原缴纳基数
            label.text = [NSString stringWithFormat:@"%@",model.dssaBeforepayment];
            break;
        case 211:           //  现缴纳基数
            label.text = [NSString stringWithFormat:@"%@",model.dssaNowpayment];
            break;
        case 212:           //  医保综合
            if ([model.dssaHealthinsurance integerValue] == 0) {
                label.text = @"综合医疗一档";
            }else if ([model.dssaHealthinsurance integerValue] == 1) {
                label.text = @"综合医疗二档";
            }else {
                label.text = @"";
            }
            break;
        case 213:           //  其他
            label.text = model.dssaOther;
            break;
        case 214:           //  驾驶执照
            if (model.dssaCharge.integerValue == 0) {
                label.text = @"公司收费";
            }else {
                label.text = @"个人付费";
            }
            break;
        case 215:           //  其他需求
            label.text = model.dssaApplyreason;
            break;
        case 216:           //  岗位职责
            label.text = model.dssaRemark;
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
        [self.passHeightDelegate passHeightFromSBGJJCell:_noteHeight + 10];
    }
}

@end
