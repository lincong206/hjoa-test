//
//  BSJJCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/27.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "BSJJCell.h"
#import "Header.h"

@interface BSJJCell ()
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
@implementation BSJJCell

- (void)creatBSJJApproveUIWithModel:(BSJJModel *)model
{
    _titleArr = @[@"申请人",@"申请时间",@"项目负责人",@"电话",@"工程名称",
                  @"建设单位",@"工程地点",@"标书类型",@"标书份数",@"截标时间",
                  @"投标保证金",@"缴纳截止时间",@"标书答疑联系人",@"联系方式",@"对招标文件提出疑问的截止时间",
                  @"拟派授权委托人",@"拟派建造师",@"人员是否要求到达现场",@"标书编制有无特殊要求",@"开标是否需要原件",
                  @"备注"];
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

- (void)creatTextViewWithModel:(BSJJModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];

    switch (label.tag) {
        case 200:           //  申请人
            label.text = model.uiName;
            break;
        case 201:           //  申请时间
            label.text = [model.pbjEndtime componentsSeparatedByString:@" "].firstObject;
            break;
        case 202:           //  项目负责人
            label.text = model.piManagername;
            break;
        case 203:           //  电话
            label.text = model.piPhone;
            break;
        case 204:           //  工程名称
            label.text = model.piName;
            break;
        case 205:           //  建设单位
            if ([model.bidHandOverInfoVo[@"piBuildcompany"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bidHandOverInfoVo[@"piBuildcompany"];
            }
            break;
        case 206:           //  工程地点
            if ([model.bidHandOverInfoVo[@"piAdress"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bidHandOverInfoVo[@"piAdress"];
            }
            break;
        case 207:           //  标书类型
            if (model.pbjBidtype.integerValue == 0) {
                label.text = @"商务标";
            }else if (model.pbjBidtype.integerValue == 1) {
                label.text = @"技术标";
            }else if (model.pbjBidtype.integerValue == 2) {
                label.text = @"资信标";
            }else if (model.pbjBidtype.integerValue == 3) {
                label.text = @"其它";
            }
            break;
        case 208:           //标书份数
            label.text = model.pbjNum;
            break;
        case 209:           //  截标时间
            label.text = model.pbjEndtime;
            break;
        case 210:           //  投标保证金
            if ([model.bidHandOverInfoVo[@"pbdTenderbond"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bidHandOverInfoVo[@"pbdTenderbond"];
            }
            break;
        case 211:           //  缴纳截止时间
            if ([model.bidHandOverInfoVo[@"pbdDeadline"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bidHandOverInfoVo[@"pbdDeadline"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 212:           //  标书答疑联系人
            if ([model.bidHandOverInfoVo[@"pbdMentoringname"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bidHandOverInfoVo[@"pbdMentoringname"];
            }
            break;
        case 213:           //  联系方式
            if ([model.bidHandOverInfoVo[@"pbdMentoringcontactway"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bidHandOverInfoVo[@"pbdMentoringcontactway"];
            }
            break;
        case 214:           //  对招标文件提出疑问的截止时间
            if ([model.bidHandOverInfoVo[@"pbdMentoringtenderbond"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bidHandOverInfoVo[@"pbdMentoringtenderbond"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 215:           //  拟派授权委托人
            label.text = model.pbjAuthorizedman;
            break;
        case 216:           //  拟派建造师
            label.text = model.pbjArchitect;
            break;
        case 217:           //  人员是否要求到达现场
            if (model.pbjIsarrive.integerValue == 0) {
                label.text = @"授权委托人";
            }else if (model.pbjIsarrive.integerValue == 1) {
                label.text = @"建造师";
            }else if (model.pbjIsarrive.integerValue == 2) {
                label.text = @"其它";
            }
            break;
        case 218:           //  标书编制有无特殊要求
            label.text = model.pbjIsspecialrequirements;
            break;
        case 219:           //  开标是否需要原件
            if (model.pbjArchitect.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 220:           //  备注
            label.text = model.pbjRemark;
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
        [self.passHeightDelegate passHeightFromBSJJCell:_noteHeight + 10];
    }
}

@end
