//
//  WTSCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "WTSCell.h"
#import "Header.h"

@interface WTSCell ()
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
@implementation WTSCell

- (void)creatWTSApproveUIWithModel:(WTSModel *)model
{
    _titleArr = @[@"申请类型",@"编号",@"申请人",@"被授权人",@"联系电话",
                  @"授权人",@"授权人职务",@"权限",@"授权内容",@"生效时间",
                  @"失效时间",@"签发时间",@"代理人性别",@"代理人年龄",@"代理职务",
                  @"工作证号",@"授权单位",@"授权单位法人",@"备注"];
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

- (void)creatTextViewWithModel:(WTSModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];

    switch (label.tag) {
        case 200:           //  申请类型
            label.text = @"一般委托书";
            break;
        case 201:           //  编号
            label.text = model.enIdnum;
            break;
        case 202:           //  申请人
            label.text = model.uiName;
            break;
        case 203:           //  被授权人
            label.text = model.enLicensee;
            break;
        case 204:           //  联系电话
            label.text = model.enPhone;
            break;
        case 205:           //  授权人
            label.text = model.enAuthorizer;
            break;
        case 206:           //  授权人职务
            label.text = model.enAuthorizerjob;
            break;
        case 207:           //  权限
            label.text = model.enPrivilege;
            break;
        case 208:           //  授权内容
            label.text = model.enContent;
            break;
        case 209:           //  生效时间
            label.text = [[model.enTimevalid componentsSeparatedByString:@" "] firstObject];
            break;
        case 210:           //  失效时间
            label.text = [[model.enTimelose componentsSeparatedByString:@" "] firstObject];
            break;
        case 211:           //  签发时间
            label.text = [[model.enTimesign componentsSeparatedByString:@" "] firstObject];
            break;
        case 212:           //  代理人性别
            if (model.enAgencysex.integerValue == 2) {
                label.text = @"未设置";
            }else if (model.enAgencysex.integerValue == 1) {
                label.text = @"女";
            }else if (model.enAgencysex.integerValue == 0) {
                label.text = @"男";
            }
            break;
        case 213:           //  代理人年龄
            label.text = [NSString stringWithFormat:@"%@",model.enAgencyage];
            break;
        case 214:           //  代理职务
            label.text = model.enAgencyjob;
            break;
        case 215:           //  工作证号
            label.text = model.enJobnum;
            break;
        case 216:           //  授权单位
            label.text = model.enAccredit;
            break;
        case 217:           //  授权单位法人
            label.text = model.enAccreditlegal;
            break;
        case 218:           //  备注
            label.text = model.enRemark;
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
        [self.passHeightDelegate passHeightFromWTSCell:_noteHeight + 10];
    }
}

@end
