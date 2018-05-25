//
//  QJCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "QJCell.h"
#import "Header.h"

@interface QJCell ()

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

@implementation QJCell

- (void)creatQJApproveUIWithModel:(QJModel *)model
{
    _titleArr = @[@"发起人姓名",@"发起部门",@"发起时间",@"请假人",@"部门",
                  @"职务",@"请假类别",@"请假开始时间",@"请假结束时间",@"请假天数",
                  @"销假时间",@"请假事由",@"备注"];
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

- (void)creatTextViewWithModel:(QJModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  发起人姓名
            label.text = model.uiName;
            break;
        case 201:           //  发起部门
            label.text = model.dlaInitiatordept;
            break;
        case 202:           //  发起时间
            _date = [NSDate dateWithTimeIntervalSince1970:[model.dalCreatetime doubleValue] / 1000.0];
            [_objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            label.text = [[_objDateformat stringFromDate:_date] componentsSeparatedByString:@" "].firstObject;
            break;
        case 203:           //  请假人
            label.text = model.dalName;
            break;
        case 204:           //  部门
            label.text = model.dalDept;
            break;
        case 205:           //  职务
            label.text = model.dalJob;
            break;
        case 206:           //  请假类别
            if (model.dalLeavetype.integerValue == 0) {
                label.text = @"病假";
            }else if (model.dalLeavetype.integerValue == 1) {
                label.text = @"事假";
            }else if (model.dalLeavetype.integerValue == 2) {
                label.text = @"产假";
            }else if (model.dalLeavetype.integerValue == 3) {
                label.text = @"丧假";
            }else if (model.dalLeavetype.integerValue == 4) {
                label.text = @"婚假";
            }else if (model.dalLeavetype.integerValue == 5) {
                label.text = @"其他";
            }
            break;
        case 207:           //  请假开始时间
            label.text = [model.dalLeavestarttime componentsSeparatedByString:@" "].firstObject;
            break;
        case 208:           //  请假结束时间
            label.text = [model.dalLeaveendtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 209:           //  请假天数
            label.text = model.dalLeaveday;
            break;
        case 210:           //  销假时间
            label.text = [model.dalLeaveendtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 211:           //  请假事由
            label.text = model.dalReason;
            break;
        case 212:           //  备注
            label.text = model.dalRemark;
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
        [self.passHeightDelegate passHeightFromQJCell:_noteHeight + 10];
    }
}

@end
