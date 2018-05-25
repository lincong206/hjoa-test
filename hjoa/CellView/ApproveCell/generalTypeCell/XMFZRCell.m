//
//  XMFZRCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "XMFZRCell.h"
#import "Header.h"

#import "DataBaseManager.h"
#import "addressModel.h"

@interface XMFZRCell ()
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

@property (strong, nonatomic) NSString *name;
@end

@implementation XMFZRCell

- (void)creatXMFZRApproveUIWithModel:(XMFZRModel *)model
{
    NSMutableArray *leadDataArrM = [[DataBaseManager shareDataBase] searchAllData];
    for (addressModel *admodel in leadDataArrM) {
        if (model.pmUserbelong) {
            if (admodel.uiId.integerValue == model.pmUserbelong.integerValue) {
                self.name = admodel.uiName;
            }
        }
    }
    _titleArr = @[@"项目经理姓名",@"身份证",@"性别",@"移动电话",@"常驻地址",
                  @"住房套数",@"客户归属人",@"介绍人",@"房产所在地",@"面积(平方米)",
                  @"房产市值(万元)",@"名下车辆数",@"车型",@"车辆市值(万元)",@"银行存款(万元)",
                  @"资产总值(万元)",@"健康状况",@"婚姻状况",@"现任职务",@"从业年限",
                  @"介绍人电话",@"学历",@"籍贯",@"出生年月",@"资格证书编号",@"其他证书情况",@"职业类型",
                  @"技术职称",@"紧急联系人",@"紧急联系人电话",@"其他优势",@"背景",
                  @"邮箱地址",@"擅长的施工专业类型",@"是否自有施工队伍、规模",@"是否具有承接大项目能力",@"是否具有承接中小项目能力",
                  @"是否具有承接小项目能力"];
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

- (void)creatTextViewWithModel:(XMFZRModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];

    switch (label.tag) {
        case 200:           //  项目经理姓名
            label.text = model.pmName;
            break;
        case 201:           //  身份证
            label.text = model.pmCarid;
            break;
        case 202:           //  性别
            if (model.pmSex.integerValue == 0) {
                label.text = @"男";
            }else {
                label.text = @"女";
            }
            break;
        case 203:           //  移动电话
            label.text = model.pmMobile;
            break;
        case 204:           //  常驻地址
            label.text = model.pmAddress;
            break;
        case 205:           //  住房套数
            label.text = [NSString stringWithFormat:@"%@",model.pmHousetype];
            break;
        case 206:           //  客户归属人
            label.text = self.name;
            break;
        case 207:           //  介绍人
            label.text = model.pmIntroducer;
            break;
        case 208:           //  房产所在地
            label.text = model.pmHousenum;
            break;
        case 209:           //  面积(平方米)
            label.text = [NSString stringWithFormat:@"%@",model.pmAreaunits];
            break;
        case 210:           //  房产市值(万元)
            label.text = [NSString stringWithFormat:@"%@",model.pmHousemoney];
            break;
        case 211:           //  名下车辆数
            label.text = model.pmPlatenumber;
            break;
        case 212:           //  车型
            label.text = model.pmCartype;
            break;
        case 213:           //  车辆市值
            label.text = [NSString stringWithFormat:@"%@",model.pmMarketvalue];
            break;
        case 214:           //  银行存款
            label.text = [NSString stringWithFormat:@"%@",model.pmDepositbank];
            break;
        case 215:           //  资产总值
            label.text = [NSString stringWithFormat:@"%@",model.pmTotalmoney];
            break;
        case 216:           //  健康状况
            if (model.pmHealthy.integerValue == 0) {
                label.text = @"良好";
            }else {
                label.text = @"一般";
            }
            break;
        case 217:           //  婚姻状况
            if (model.pmMarriagetype.integerValue == 0) {
                label.text = @"未婚";
            }else {
                label.text = @"已婚";
            }
            break;
        case 218:           //  现任职务
            label.text = model.pmDuties;
            break;
        case 219:           //  从业年限
            label.text = model.pmWorkingtime;
            break;
        case 220:           //  介绍人电话
            label.text = model.pmIntroducermoblie;
            break;
        case 221:           //  学历
            if (model.pmEducation.integerValue == 0) {
                label.text = @"小学";
            }else if (model.pmEducation.integerValue == 1) {
                label.text = @"初中";
            }else if (model.pmEducation.integerValue == 2) {
                label.text = @"高中";
            }else if (model.pmEducation.integerValue == 3) {
                label.text = @"大专";
            }else if (model.pmEducation.integerValue == 4) {
                label.text = @"大学本科";
            }else if (model.pmEducation.integerValue == 5) {
                label.text = @"研究生";
            }else if (model.pmEducation.integerValue == 6) {
                label.text = @"博士";
            }else if (model.pmEducation.integerValue == 7) {
                label.text = @"其他";
            }
            break;
        case 222:           //  籍贯
            label.text = model.pmOrigin;
            break;
        case 223:           //  出生年月
            label.text = model.pmBirthday;
            break;
        case 224:           //  资格证书编号
            label.text = model.pmCredentials;
            break;
        case 225:           //  其他证书情况
            label.text = model.pmCredentialsother;
            break;
        case 226:           //  职业类型
            if (model.pmJobtype.integerValue == 0) {
                label.text = @"全职";
            }else {
                label.text = @"兼职";
            }
            break;
        case 227:           //  技术职称
            if (model.pmEducation.integerValue == 0) {
                label.text = @"无";
            }else if (model.pmEducation.integerValue == 1) {
                label.text = @"临时一级建造师,工程师";
            }else if (model.pmEducation.integerValue == 2) {
                label.text = @"一级建造师,高级工程师";
            }else if (model.pmEducation.integerValue == 3) {
                label.text = @"一级建造师,工程师";
            }else if (model.pmEducation.integerValue == 4) {
                label.text = @"工程师";
            }else if (model.pmEducation.integerValue == 5) {
                label.text = @"一级建造师,造价工程师";
            }else if (model.pmEducation.integerValue == 6) {
                label.text = @"助工";
            }else if (model.pmEducation.integerValue == 7) {
                label.text = @"二级建造师";
            }
            break;
        case 228:           //  紧急联系人
            label.text = model.pmContacts;
            break;
        case 229:           //  紧急联系人电话
            label.text = model.pmContactsmoblie;
            break;
        case 230:           //  其他优势
            label.text = model.pmAdvantage;
            break;
        case 231:           //  背景
            label.text = model.pmBackground;
            break;
        case 232:           //  邮箱地址
            label.text = model.pmEmail;
            break;
        case 233:           //  擅长的施工专业类型
            if (model.pmGoodconstructiontype.integerValue == 0) {
                label.text = @"装饰";
            }else if (model.pmGoodconstructiontype.integerValue == 1) {
                label.text = @"幕墙";
            }else if (model.pmGoodconstructiontype.integerValue == 2) {
                label.text = @"机电";
            }else if (model.pmGoodconstructiontype.integerValue == 3) {
                label.text = @"净化";
            }else if (model.pmGoodconstructiontype.integerValue == 4) {
                label.text = @"智能化";
            }else if (model.pmGoodconstructiontype.integerValue == 5) {
                label.text = @"消防";
            }else if (model.pmGoodconstructiontype.integerValue == 6) {
                label.text = @"钢结构";
            }else if (model.pmGoodconstructiontype.integerValue == 7) {
                label.text = @"装饰设计";
            }else if (model.pmGoodconstructiontype.integerValue == 8) {
                label.text = @"幕墙设计";
            }
            break;
        case 234:           //  是否自有施工队伍、规模
            if (model.pmConstructionteam.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 235:           //  是否具有承接大项目能力
            if (model.pmBigprojectability.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 236:           //  是否具有承接中小项目能力
            if (model.pmMiddleprojectability.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 237:           //  是否具有承接小项目能力
            if (model.pmSmallprojectability.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
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
        [self.passHeightDelegate passHeightFromXMFZRCell:_noteHeight + 10];
    }
}

@end
