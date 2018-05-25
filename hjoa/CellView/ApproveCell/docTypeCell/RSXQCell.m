//
//  RSXQCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RSXQCell.h"
#import "Header.h"

@interface RSXQCell ()
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

@implementation RSXQCell

- (void)creatRSXQApproveUIWithModel:(RSXQModel *)model
{
    _titleArr = @[@"发起人姓名",@"发起时间",@"发起部门",@"岗位级别",@"需求职位",
                  @"需求名额",@"申请部门领导",@"部门主管领导",@"聘用原因",@"原因说明",
                  @"性别",@"年龄",@"专业",@"学历需求",@"语言能力",
                  @"程度",@"工作经验",@"专长",@"驾驶执照",@"其他需求",
                  @"岗位职责",@"聘用方式",@"甄选方式",@"笔试科目",@"特殊劳动条件",
                  @"希望聘用日期",@"希望到职日期"];
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

- (void)creatTextViewWithModel:(RSXQModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  发起人姓名
            label.text = model.uiName;
            break;
        case 201:           //  发起时间
            _date = [NSDate dateWithTimeIntervalSince1970:[model.dpmdCreatetime doubleValue] / 1000.0];
            [_objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            label.text = [[_objDateformat stringFromDate:_date] componentsSeparatedByString:@" "].firstObject;
            break;
        case 202:           //  发起部门
            label.text = model.dpmdDept;
            break;
        case 203:           //  岗位级别
            label.text = model.dpmdJobgrade;
            break;
        case 204:           //  需求职位
            label.text = model.dpmdDemandjob;
            break;
        case 205:           //  需求名额
            label.text = model.dpmdDemandnum;
            break;
        case 206:           //  申请部门领导
            label.text = model.dpmdDaptleader;
            break;
        case 207:           //  部门主管领导
            label.text = model.dpmdChargeleader;
            break;
        case 208:           //  聘用原因
            if (model.dpmdReason.integerValue == 0) {
                label.text = @"补充离职";
            }else if (model.dpmdReason.integerValue == 1) {
                label.text = @"补充调职";
            }else if (model.dpmdReason.integerValue == 2) {
                label.text = @"业务扩充";
            }else if (model.dpmdReason.integerValue == 3) {
                label.text = @"储备人力";
            }else if (model.dpmdReason.integerValue == 4) {
                label.text = @"短期需要";
            }
            break;
        case 209:           //  性别
            if (model.dpmdSex.integerValue == 0) {
                label.text = @"男";
            }else {
                label.text = @"女";
            }
            break;
        case 210:           //  年龄
            label.text = [NSString stringWithFormat:@"%@ 至 %@",model.dpmdMinage,model.dpmdMaxage];
            break;
        case 211:           //  专业
            label.text = model.dpmdMajor;
            break;
        case 212:           //  学历需求
            label.text = model.dpmdEducation;
            break;
        case 213:           //  语言能力
            if (model.dpmdLanguage.integerValue == 0) {
                label.text = @"英语";
            }else if (model.dpmdLanguage.integerValue == 1) {
                label.text = @"日语";
            }else {
                label.text = @"其他";
            }
            break;
        case 214:           //  程度
            if (model.dpmdDegree.integerValue == 0) {
                label.text = @"优";
            }else if (model.dpmdDegree.integerValue == 1) {
                label.text = @"良";
            }else {
                label.text = @"一般";
            }
            break;
        case 215:           //  工作经验
            label.text = model.dpmdWoekexperience;
            break;
        case 216:           //  专长
            label.text = model.dpmdSpeciality;
            break;
        case 217:           //  驾驶执照
            if (model.dpmdDriver.integerValue == 0) {
                label.text = @"C照";
            }else if (model.dpmdDriver.integerValue == 1) {
                label.text = @"B照";
            }else if (model.dpmdDriver.integerValue == 2) {
                label.text = @"A照";
            }else {
                label.text = @"其他";
            }
            break;
        case 218:           //  其他需求
            label.text = model.dpmdOtherdemand;
            break;
        case 219:           //  岗位职责
            label.text = model.dpmdJobpost;
            break;
        case 220:           //  聘用方式
            if (model.dpmdEmployway.integerValue == 0) {
                label.text = @"招聘";
            }else if (model.dpmdEmployway.integerValue == 1) {
                label.text = @"推荐";
            }else {
                label.text = @"其他";
            }
            break;
        case 221:           //  甄选方式
            if (model.dpmdSelect.integerValue == 0) {
                label.text = @"笔试";
            }else if (model.dpmdSelect.integerValue == 1) {
                label.text = @"面试";
            }else if (model.dpmdSelect.integerValue == 2) {
                label.text = @"语言测试";
            }else {
                label.text = @"资格审查";
            }
            break;
        case 222:           //  笔试科目
            label.text = model.dpmdWritsubject;
            break;
        case 223:           //  原因说明
            label.text = model.dpmdCondition;
            break;
        case 224:           //  原因说明
            label.text = [model.dpmdEmploydate componentsSeparatedByString:@" "].firstObject;
            break;
        case 225:           //  原因说明
            label.text = [model.dpmdTakedate componentsSeparatedByString:@" "].firstObject;
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
        [self.passHeightDelegate passHeightFromRSXQCell:_noteHeight + 10];
    }
}

@end
