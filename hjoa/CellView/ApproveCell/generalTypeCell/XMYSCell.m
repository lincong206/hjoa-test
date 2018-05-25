//
//  XMYSCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "XMYSCell.h"
#import "Header.h"

@interface XMYSCell ()
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
@implementation XMYSCell

- (void)creatXMYSApproveUIWithModel:(XMYSModel *)model
{
    _titleArr = @[@"项目编号",@"区域",@"工程名称",@"工程地址",@"建筑面积",
                  @"层数",@"工程造价(万元)",@"资质类型",@"建筑类型",@"建设单位",
                  @"建设单位联系人",@"建设单位联系人电话",@"申办人",@"申办人电话",@"申办时间",
                  @"跟踪负责人",@"项目登记人",@"项目登记时间",@"报名编号",@"报名时间",
                  @"制作时间",@"拟派项目经理",@"拟派其他人员",@"授权委托人",@"资料编制人",
                  @"报名状态",@"预审编号",@"预审文件时间",@"预审文件完成时间",@"预审初查时间",
                  @"预审递交截止时间",@"文件递交地点",@"项目经理是否到场",@"预审文件份数",@"主要负责人",
                  @"拟派项目经理",@"协助人",@"是否收费",@"应收金额(元)",@"实收金额(元)",
                  @"资料编辑人",@"评估得分"];
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

- (void)creatTextViewWithModel:(XMYSModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  项目编号
            label.text = model.bsProjectinfo[@"piIdnum"];
            break;
        case 201:           //  区域
            label.text = model.bsProjectinfo[@"piRegion"];
            break;
        case 202:           //  工程名称
            label.text = model.bsProjectinfo[@"piName"];
            break;
        case 203:           //  工程地址
            label.text = model.bsProjectinfo[@"piAdress"];
            break;
        case 204:           //  建筑面积
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingarea"]];
            break;
        case 205:           //  层数
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piStoriedbuilding"]];
            break;
        case 206:           //  工程造价(万元)
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPrice"]];
            break;
        case 207:           //  资质类型
            if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 0) {
                label.text = @"建筑装修装饰工程专业承包";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 1) {
                label.text = @"建筑幕墙工程专业承包";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 2) {
                label.text = @"机电设备安装专业承包";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 3) {
                label.text = @"建筑智能化工程专业承包";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 4) {
                label.text = @"消防设施工程专业承包";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 5) {
                label.text = @"金属门窗工程专业承包";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 6) {
                label.text = @"钢结构工程专业承包";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 7) {
                label.text = @"建筑装饰专项设计甲级";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 8) {
                label.text = @"建筑幕墙专项设计甲级";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 9) {
                label.text = @"承装修、试电力设施";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 10) {
                label.text = @"城市园林绿化";
            }else if ([model.bsProjectinfo[@"piAptitudetype"] integerValue] == 11) {
                label.text = @"净化工程";
            }
            break;
        case 208:           //  建筑类型
            if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 0) {
                label.text = @"不限";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 1) {
                label.text = @"酒店及会所";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 2) {
                label.text = @"行政及办公空间";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 3) {
                label.text = @"医疗建筑";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 4) {
                label.text = @"商业空间";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 5) {
                label.text = @"住宅精装修";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 6) {
                label.text = @"金融场所";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 7) {
                label.text = @"交通场所";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 8) {
                label.text = @"文化建筑";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 9) {
                label.text = @"教育机构";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 10) {
                label.text = @"农业建筑";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 11) {
                label.text = @"政府公众设施";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 12) {
                label.text = @"工业建筑";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 13) {
                label.text = @"其他类别";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 14) {
                label.text = @"医院";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 15) {
                label.text = @"银行";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 16) {
                label.text = @"邮电通信建筑";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 17) {
                label.text = @"进化工程";
            }else if ([model.bsProjectinfo[@"piBuildingtype"] integerValue] == 18) {
                label.text = @"幕墙类";
            }
            break;
        case 209:           //  建设单位
            label.text = model.bsProjectinfo[@"piBuildcompany"];
            break;
        case 210:           //  建设单位联系人
            label.text = model.bsProjectinfo[@"piBuildcompanycontacts"];
            break;
        case 211:           //  建设单位联系人电话
            label.text = model.bsProjectinfo[@"piBuildcompanymoblienlie"];
            break;
        case 212:           //  申办人
            label.text = model.bsProjectinfo[@"uiManagername"];
            break;
        case 213:           //  申办人电话
            label.text = model.bsProjectinfo[@"uiManagermobile"];
            break;
        case 214:           //  申办时间
            label.text = [model.bsProjectinfo[@"piCreatetime"] componentsSeparatedByString:@" "].firstObject;
            break;
        case 215:           //  跟踪负责人
            label.text = model.bsProjectinfo[@"uiFollowuser"];
            break;
        case 216:           //  项目登记人
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"uiInputuser"]];
            break;
        case 217:           //  项目登记时间
            label.text = [model.bsProjectinfo[@"piCreatetime"] componentsSeparatedByString:@" "].firstObject;
            break;
        case 218:           //  报名编号
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"bsProjectEnroll"][@"peIdnum"]];
            break;
        case 219:           //  报名时间
            if ([model.bsProjectinfo[@"bsProjectEnroll"][@"peEnrollendtime"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = [NSString stringWithFormat:@"%@",[model.bsProjectinfo[@"bsProjectEnroll"][@"peEnrollendtime"] componentsSeparatedByString:@" "].firstObject];
            }
            break;
        case 220:           //  制作时间
            if ([model.bsProjectinfo[@"bsProjectEnroll"][@"peEdittime"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = [NSString stringWithFormat:@"%@",[model.bsProjectinfo[@"bsProjectEnroll"][@"peEdittime"] componentsSeparatedByString:@" "].firstObject];
            }
            break;
        case 221:           //  拟派项目经理
            if ([model.bsProjectinfo[@"bsProjectEnroll"][@"pePmdraft"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = model.bsProjectinfo[@"bsProjectEnroll"][@"pePmdraft"];
            }
            break;
        case 222:           //  拟派其他人员
            if ([model.bsProjectinfo[@"bsProjectEnroll"][@"peOthersdraft"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = model.bsProjectinfo[@"bsProjectEnroll"][@"peOthersdraft"];
            }
            break;
        case 223:           //  授权委托人
            if ([model.bsProjectinfo[@"bsProjectEnroll"][@"peAccreditor"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = model.bsProjectinfo[@"bsProjectEnroll"][@"peAccreditor"];
            }
            break;
        case 224:           //  资料编制人
            if ([model.bsProjectinfo[@"bsProjectEnroll"][@"peEditor"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = model.bsProjectinfo[@"bsProjectEnroll"][@"peEditor"];
            }
            break;
        case 225:           //  报名状态
            if (model.ptTaskstatus.integerValue == 0) {
                label.text = @"代办理";
            }else if (model.ptTaskstatus.integerValue == 1) {
                label.text = @"办理中";
            }else {
                label.text = @"办理完成";
            }
            break;
        case 226:           //  预审编号
            label.text = model.bsProjectPre[@"ppIdnum"];
            break;
        case 227:           //  预审文件时间
            if ([model.bsProjectPre[@"ppPrefiletime"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = [model.bsProjectPre[@"ppPrefiletime"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 228:           //  预审文件完成时间
            if ([model.bsProjectPre[@"ppPretrialfilefinish"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = [model.bsProjectPre[@"ppPretrialfilefinish"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 229:           //  预审初查时间
            if ([model.bsProjectPre[@"ppPretrialfirstcheck"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = [model.bsProjectPre[@"ppPretrialfirstcheck"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 230:           //  预审递交截止时间
            if ([model.bsProjectPre[@"ppPretrialdeadline"] isKindOfClass:[NSNull class]]) {
                label.text = @"";
            }else {
                label.text = [model.bsProjectPre[@"ppPretrialdeadline"] componentsSeparatedByString:@" "].firstObject;
            }
            break;
        case 231:           //  文件递交地点
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppFilesubmittingsite"]];
            break;
        case 232:           //  项目经理是否到场
            if ([model.bsProjectPre[@"ppWhetherpmbepresent"] integerValue] == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 233:           //  预审文件份数
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppPretrialfilequantity"]];
            break;
        case 234:           //  主要负责人
            label.text = model.bsProjectPre[@"ppMaindirector"];
            break;
        case 235:           //  拟派项目经理
            label.text = model.bsProjectPre[@"ppPmplantoassign"];
            break;
        case 236:           //  协助人
            label.text = model.bsProjectPre[@"ppPatron"];
            break;
        case 237:           //  是否收费
            if ([model.bsProjectPre[@"ppWhethercharge"] integerValue] == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 238:           //  应收金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppAmountreceivable"]];
            break;
        case 239:           //  实收金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppAmountreceived"]];
            break;
        case 240:           //  资料编辑人
            label.text = model.bsProjectPre[@"uiName"];
            break;
        case 241:           //  评估得分
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectPre[@"ppAssessscore"]];
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
        [self.passHeightDelegate passHeightFromXMYSCell:_noteHeight + 10];
    }
}

@end
