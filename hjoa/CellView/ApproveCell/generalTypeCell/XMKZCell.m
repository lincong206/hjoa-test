//
//  XMKZCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "XMKZCell.h"
#import "Header.h"

@interface XMKZCell ()
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

@implementation XMKZCell

- (void)creatXMKZApproveUIWithModel:(XMKZModel *)model
{
    _titleArr = @[@"申请类型",@"编号",@"填表时间",@"申请人",@"申请人电话",@"项目名称",
                  @"项目编号",@"工程地点",@"建设单位",@"合同编号",@"合同造价",
                  @"项目负责人",@"联系电话",@"合同工期",@"监理单位",@"开竣日期",
                  @"印章类别",@"印章保管人",@"联系电话",@"印章申请方式",@"印章使用期限",
                  @"押金",@"押金金额",@"刻章费",@"刻章费金额",@"刻印内容",
                  @"印鉴内容",@"备注"];
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

- (void)creatTextViewWithModel:(XMKZModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];

    switch (label.tag) {
        case 200:           //  申请类型
            if ([model.stIdtype isEqualToString:@"XMKZ"]) {
                label.text = @"项目刻章申请";
            }
            break;
        case 201:           //  编号
            label.text = model.stIdnum;
            break;
        case 202:           //  填表时间
            label.text = [[model.stCreattime componentsSeparatedByString:@" "] firstObject];
            break;
        case 203:           //  申请人
            label.text = model.uiName;
            break;
        case 204:           //  申请人电话
            label.text = model.uiPhone;
            break;
        case 205:           //  项目名称
            label.text = model.stProjectname;
            break;
        case 206:           //  项目编号
            label.text = model.stProjectidnum;
            break;
        case 207:           //  工程地点
            label.text = model.stProjectadress;
            break;
        case 208:           //  建设单位
            label.text = model.stConstruction;
            break;
        case 209:           //  合同编号
            label.text = model.stContractidnum;
            break;
        case 210:           //  合同造价
            label.text = model.stContractprice;
            break;
        case 211:           //  项目负责人
            label.text = model.stProjectleader;
            break;
        case 212:           //  联系电话
            label.text = model.stProjectleaderphone;
            break;
        case 213:           //  合同工期
            label.text = model.stContracttime;
            break;
        case 214:           //  监理单位
            label.text = model.stSupervisor;
            break;
        case 215:           //  开竣日期
            label.text = [NSString stringWithFormat:@"%@至%@",[[model.stStarttime componentsSeparatedByString:@" "] firstObject],[[model.stEndtime componentsSeparatedByString:@" "] firstObject]];
            break;
        case 216:           //  印章类别
            if (model.stStamptype.integerValue == 0) {
                label.text = @"项目专用章";
            }else if (model.stStamptype.integerValue == 1) {
                label.text = @"财务章";
            }else {
                label.text = @"私章";
            }
            break;
        case 217:           //  印章保管人
            label.text = model.stStampcarepople;
            break;
        case 218:           //  联系电话
            label.text = model.stStampphone;
            break;
        case 219:           //  印章申请方式
            if (model.stStampapple.integerValue == 0) {
                label.text = @"借用";
            }else if (model.stStampapple.integerValue == 1) {
                label.text = @"竣工图章";
            }else {
                label.text = @"图纸报审章";
            }
            break;
        case 220:           //  印章使用期限
            label.text = [NSString stringWithFormat:@"%@至%@有效,其他%@",[[model.stStampusestartime componentsSeparatedByString:@" "] firstObject],[[model.stStampuseendtime componentsSeparatedByString:@" "] firstObject],model.stStampuseother];
            break;
        case 221:           //  押金
            if (model.stCash.integerValue == 0) {
                label.text = @"转账";
            }else if (model.stCash.integerValue == 1) {
                label.text = @"现金";
            }else if (model.stCash.integerValue == 2) {
                label.text = @"扣款工程";
            }else {
                label.text = @"其他";
            }
            break;
        case 222:           //  押金金额
            label.text = model.stCashmoney;
            break;
        case 223:           //  刻章费
            if (model.stStampseals.integerValue == 0) {
                label.text = @"转账";
            }else if (model.stStampseals.integerValue == 1) {
                label.text = @"现金";
            }else if (model.stStampseals.integerValue == 2) {
                label.text = @"扣款工程";
            }else {
                label.text = @"其他";
            }
            break;
        case 224:           //  刻章费金额
            label.text = model.stStampmoney;
            break;
        case 225:           //  刻印内容
            label.text = model.stStampcontect;
            break;
        case 226:           //  印鉴内容
            label.text = model.stSpecimen;
            break;
        case 227:           //  备注
            label.text = model.stRemark;
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
        [self.passHeightDelegate passHeightFromXMKZCell:_noteHeight + 10];
    }
}
@end
