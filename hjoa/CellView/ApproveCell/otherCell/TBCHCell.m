//
//  TBCHCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "TBCHCell.h"
#import "Header.h"

@interface TBCHCell ()

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

@property (strong, nonatomic) NSString *nameStr;
@property (strong, nonatomic) NSArray *name;

@end

@implementation TBCHCell

- (void)creatTBCHApproveUIWithModel:(TBCHModel *)model
{
    _titleArr = @[@"项目编号",@"工程名称",@"工程地址",@"经营类别",@"来源归属",
                  @"建设单位",@"项目负责人",@"项目负责人电话",@"业绩归属人",@"工程造价(万元)",
                  @"甲方性质",@"建筑类型",@"工程类别",@"工程类型",@"创建方式",
                  @"资质类型",@"报名编号",@"报名截止时间",@"制作时间",@"拟派项目经理",
                  @"拟派项目其他人员",@"授权委托人",@"资料编制人",@"报名综合记录",@"预审编号",
                  @"预审文件时间",@"预审文件完成时间",@"预审初查时间",@"预审递交截止时间",@"文件递交地点",
                  @"项目经理是否到场",@"预审文件份数",@"主要负责人",@"拟派项目经理",@"协助人",
                  @"是否收费",@"应收金额",@"实收金额",@"资料编辑人",@"评估得分",
                  @"预审状态"];
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

- (void)creatTextViewWithModel:(TBCHModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  项目编号
            label.text = model.piIdnum;
            break;
        case 201:           //  工程名称
            label.text = model.piName;
            break;
        case 202:           //  工程地址
            label.text = model.piAddresspca;
            break;
        case 203:           //  经营类别
            if ( model.piOperatecategory.integerValue == 0) {
                label.text = @"不限";
            }else if (model.piOperatecategory.integerValue == 1) {
                label.text = @"一类项目";
            }else if (model.piOperatecategory.integerValue == 2) {
                label.text = @"二类项目";
            }else if (model.piOperatecategory.integerValue == 3) {
                label.text = @"三类项目";
            }
            break;
        case 204:           //  来源归属
            label.text = model.uiSourcename;
            break;
        case 205:           //  建设单位
            label.text = model.piBuildcompany;//
            break;
        case 206:           //  项目负责人
            label.text = model.uiManagername;
            break;
        case 207:           //  项目负责人电话
            label.text = model.uiManagermobile;
            break;
        case 208:           //  业绩归属人
            label.text = model.uiBelongname;
            break;
        case 209:           //  工程造价(万元)
            label.text = [NSString stringWithFormat:@"%@",model.piPrice];
            break;
        case 210:           //  甲方性质
            if (model.piPartytype.integerValue == 0) {
                label.text = @"不限";
            }else if (model.piPartytype.integerValue == 1) {
                label.text = @"私营";
            }else if (model.piPartytype.integerValue == 2) {
                label.text = @"国有";
            }else if (model.piPartytype.integerValue == 3) {
                label.text = @"政府机构";
            }else if (model.piPartytype.integerValue == 4) {
                label.text = @"股份制";
            }else if (model.piPartytype.integerValue == 5) {
                label.text = @"外资";
            }else if (model.piPartytype.integerValue == 6) {
                label.text = @"其他";
            }
            break;
        case 211:           //  建筑类型
            if (model.piBuildingtype.integerValue == 0) {
                label.text = @"不限";
            }else if (model.piBuildingtype.integerValue == 1) {
                label.text = @"酒店及会所";
            }else if (model.piBuildingtype.integerValue == 2) {
                label.text = @"行政及办公空间";
            }else if (model.piBuildingtype.integerValue == 3) {
                label.text = @"医疗建筑";
            }else if (model.piBuildingtype.integerValue == 4) {
                label.text = @"商业空间";
            }else if (model.piBuildingtype.integerValue == 5) {
                label.text = @"住宅精装修";
            }else if (model.piBuildingtype.integerValue == 6) {
                label.text = @"金融场所";
            }else if (model.piBuildingtype.integerValue == 7) {
                label.text = @"交通场所";
            }else if (model.piBuildingtype.integerValue == 8) {
                label.text = @"文化建筑";
            }else if (model.piBuildingtype.integerValue == 9) {
                label.text = @"教育机构";
            }else if (model.piBuildingtype.integerValue == 10) {
                label.text = @"农业建筑";
            }else if (model.piBuildingtype.integerValue == 11) {
                label.text = @"政府公众设施";
            }else if (model.piBuildingtype.integerValue == 12) {
                label.text = @"工业建筑";
            }else if (model.piBuildingtype.integerValue == 13) {
                label.text = @"其他类别";
            }else if (model.piBuildingtype.integerValue == 14) {
                label.text = @"医院";
            }else if (model.piBuildingtype.integerValue == 15) {
                label.text = @"银行";
            }else if (model.piBuildingtype.integerValue == 16) {
                label.text = @"邮电通信建筑";
            }else if (model.piBuildingtype.integerValue == 17) {
                label.text = @"进化工程";
            }else if (model.piBuildingtype.integerValue == 18) {
                label.text = @"幕墙类";
            }
            break;
        case 212:           //  工程类别
            if (model.piCategory.integerValue == 0) {
                label.text = @"总包";
            }else {
                label.text = @"分包";
            }
            break;
        case 213:           //  工程类型
            if (model.piType.integerValue == 0) {
                label.text = @"不限";
            }else if (model.piType.integerValue == 1) {
                label.text = @"A类";
            }else {
                label.text = @"B类";
            }
            break;
        case 214:           //  创建方式
            if (model.piCreatetype.integerValue == 0) {
                label.text = @"不限";
            }else if (model.piCreatetype.integerValue == 1) {
                label.text = @"项目(跟踪)";
            }else if (model.piCreatetype.integerValue == 2) {
                label.text = @"直接投标";
            }else {
                label.text = @"直接施工";
            }
            break;
        case 215:           //  资质类型
            _name = @[@"建筑装修装饰工程专业承包",@"建筑幕墙工程专业承包",@"机电设备安装工程专业承包",@"建筑智能化工程专业承包",@"消防设施工程专业承包",@"金属门窗工程专业承包",@"钢结构工程专业承包",@"建筑装饰专项设计甲级",@"建筑幕墙专项设计甲级",@"承装修、试电力设施",@"城市园林绿化",@"净化工程"];
            for (NSString *string in [model.piAptitudetype componentsSeparatedByString:@","]) {
                _nameStr = [NSString stringWithFormat:@"%@;%@",_name[string.integerValue],_nameStr];
            }
            label.text = [_nameStr componentsSeparatedByString:@"(null)"].firstObject;
            break;
        case 216:           //  报名编号
            if ([model.bsProjectEnroll[@"peIdnum"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectEnroll[@"peIdnum"];
            }
            break;
        case 217:           //  报名截止时间
            if ([model.bsProjectEnroll[@"peEnrollendtime"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bsProjectEnroll[@"peEnrollendtime"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 218:           //  制作时间
            if ([model.bsProjectEnroll[@"peEdittime"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bsProjectEnroll[@"peEdittime"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 219:           //  拟派项目经理
            if ([model.bsProjectEnroll[@"pePmdraft"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectEnroll[@"pePmdraft"];
            }
            break;
        case 220:           //  拟派项目其他人员
            if ([model.bsProjectEnroll[@"peOthersdraft"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectEnroll[@"peOthersdraft"];
            }
            break;
        case 221:           //  授权委托人
            if ([model.bsProjectEnroll[@"peAccreditor"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectEnroll[@"peAccreditor"];
            }
            break;
        case 222:           //  资料编制人
            if ([model.bsProjectEnroll[@"peEditor"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectEnroll[@"peEditor"];
            }
            break;
        case 223:           //  报名综合记录
            if ([model.bsProjectEnroll[@"peRecord"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectEnroll[@"peRecord"];
            }
            break;
        case 224:           //  预审编号
            if ([model.bsProjectPre[@"ppIdnum"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectPre[@"ppIdnum"];
            }
            break;
        case 225:           //  预审文件时间
            if ([model.bsProjectPre[@"ppPrefiletime"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bsProjectPre[@"ppPrefiletime"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 226:           //  预审文件完成时间
            if ([model.bsProjectPre[@"ppPretrialfilefinish"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bsProjectPre[@"ppPretrialfilefinish"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 227:           //  预审初查时间
            if ([model.bsProjectPre[@"ppPretrialfirstcheck"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bsProjectPre[@"ppPretrialfirstcheck"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 228:           //  预审递交截止时间
            if ([model.bsProjectPre[@"ppPretrialdeadline"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [model.bsProjectPre[@"ppPretrialdeadline"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 229:           //  文件递交地点
            if ([model.bsProjectPre[@"peRecord"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectPre[@"peRecord"];
            }
            break;
        case 230:           //  项目经理是否到场
            if ([model.bsProjectPre[@"ppWhetherpmbepresent"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                if ([model.bsProjectPre[@"ppWhetherpmbepresent"] integerValue] == 0) {
                    label.text = @"是";
                }else {
                    label.text = @"否";
                }
            }
            break;
        case 231:           //  预审文件份数
            if ([model.bsProjectPre[@"ppPretrialfilequantity"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppPretrialfilequantity"]];
            }
            break;
        case 232:           //  主要负责人
            if ([model.bsProjectPre[@"ppMaindirector"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectPre[@"ppMaindirector"];
            }
            break;
        case 233:           //  拟派项目经理
            if ([model.bsProjectPre[@"ppPmplantoassign"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectPre[@"ppPmplantoassign"];
            }
            break;
        case 234:           //  协助人
            if ([model.bsProjectPre[@"ppPatron"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectPre[@"ppPatron"];
            }
            break;
        case 235:           //  是否收费
            if ([model.bsProjectPre[@"ppWhethercharge"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                if ([model.bsProjectPre[@"ppWhethercharge"] integerValue] == 0) {
                    label.text = @"是";
                }else {
                    label.text = @"否";
                }
            }
            break;
        case 236:           //  应收金额
            if ([model.bsProjectPre[@"ppAmountreceivable"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppAmountreceivable"]];
            }
            break;
        case 237:           //  实收金额
            if ([model.bsProjectPre[@"ppAmountreceived"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppAmountreceived"]];
            }
            break;
        case 238:           //  资料编辑人
            if ([model.bsProjectPre[@"uiName"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectPre[@"uiName"];
            }
            break;
        case 239:           //  评估得分
            if ([model.bsProjectPre[@"ppAssessscore"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppAssessscore"]];
            }
            break;
        case 240:           //  预审状态
            if ([model.bsProjectPre[@"ppPretrialstate"] isEqual:[NSNull alloc]]) {
                label.text = @"--";
            }else {
                label.text = model.bsProjectPre[@"ppPretrialstate"];
            }
            break;
        default:
            break;
    }
    
    if (label.text == nil || [label.text isEqualToString:@"(null)"] || [label.text isEqualToString:@""] || [label.text isEqualToString:@" "] || [label.text isEqualToString:@"<null>"]) {
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
        [self.passHeightDelegate passHeightFromTBCHCell:_noteHeight + 10];
    }
}
@end
