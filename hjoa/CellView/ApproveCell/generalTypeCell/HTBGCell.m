//
//  HTBGCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "HTBGCell.h"
#import "Header.h"

@interface HTBGCell ()
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

@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSArray *name;

@end

@implementation HTBGCell

- (void)creatHTBGApproveUIWithModel:(HTBGModel *)model
{
    _titleArr = @[@"工程名称",@"项目编号",@"经营类别",@"建设单位",@"来源归属",
                  @"项目负责人",@"项目负责人电话",@"业绩归属人",@"工程造价(万元)",@"甲方性质",
                  @"建筑类型",@"工程类别",@"工程类型",@"资质类型",@"工程地址",
                  @"备注",@"合同编号",@"合同名称",@"合同份数",@"合同金额小写(元)",
                  @"是否含清包工",@"是否含甲供材",@"合同金额大写",@"合同签订日期",@"合同开工日期",
                  @"合同竣工日期",@"工期",@"合同质保期",@"合同预付款比例(%)",@"合同预付款金额(元)",
                  @"合同进度款比例(%)",@"合同进度款金额(元)",@"合同竣工款比例(%)",@"合同竣工款金额(元)",@"合同结算款比例(%)",
                  @"合同结算款金额(元)",@"合同质保金比例(%)",@"合同质保金款金额(元)",@"付款方式",@"工程责任书状态",
                  @"是否需要单项工程责任书",@"购买保险方式",@"合同账号章",@"合同承包范围",@"工程竣工验收条款",
                  @"合同质保金条款",@"资料员姓名",@"资料员电话",@"资料移交",@"合同归档日期",
                  @"归档编号",@"归档人",@"备注"];
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

- (void)creatTextViewWithModel:(HTBGModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    switch (label.tag) {
        case 200:           //  工程名称
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piName"]];
            break;
        case 201:           //  项目编号
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piIdnum"]];
            break;
        case 202:           //  经营类别
            if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piOperatecategory"]].integerValue == 0) {
                label.text = @"不限";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piOperatecategory"]].integerValue == 1) {
                label.text = @"一类项目";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piOperatecategory"]].integerValue == 2) {
                label.text = @"二类项目";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piOperatecategory"]].integerValue == 3) {
                label.text = @"三类项目";
            }else {
                label.text = @"";
            }
            break;
        case 203:           //  建设单位
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildcompany"]];
            break;
        case 204:           //  来源归属
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"uiSourcename"]];
            break;
        case 205:           //  项目负责人
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"uiManagername"]];
            break;
        case 206:           //  项目负责人电话
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"uiManagermobile"]];
            break;
        case 207:           //  业绩归属人
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"uiBelongname"]];
            break;
        case 208:           //  工程造价(万元)
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPrice"]];
            break;
        case 209:           //  甲方性质
            if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPartytype"]].integerValue == 0) {
                label.text = @"不限";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPartytype"]].integerValue == 1) {
                label.text = @"私营";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPartytype"]].integerValue == 2) {
                label.text = @"国有";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPartytype"]].integerValue == 3) {
                label.text = @"政府机构";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPartytype"]].integerValue == 4) {
                label.text = @"股份制";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piPartytype"]].integerValue == 5) {
                label.text = @"外资";
            }else {
                label.text = @"其他";
            }
            break;
        case 210:           //  建筑类型
            if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 0) {
                label.text = @"不限";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 1) {
                label.text = @"酒店及会所";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 2) {
                label.text = @"行政及办公空间";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 3) {
                label.text = @"医疗建筑";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 4) {
                label.text = @"商业空间";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 5) {
                label.text = @"住宅精装修";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 6) {
                label.text = @"金融场所";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 7) {
                label.text = @"交通场所";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 8) {
                label.text = @"文化建筑";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 9) {
                label.text = @"教育机构";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 10) {
                label.text = @"农业建筑";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 11) {
                label.text = @"政府公众设施";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 12) {
                label.text = @"工业建筑";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 13) {
                label.text = @"其他类别";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 14) {
                label.text = @"医院";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 15) {
                label.text = @"银行";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 16) {
                label.text = @"邮电通信建筑";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 17) {
                label.text = @"进化工程";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piBuildingtype"]].integerValue == 18) {
                label.text = @"幕墙类";
            }else {
                label.text = @"";
            }
            break;
        case 211:           //  工程类别
            if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piCategory"]].integerValue == 0) {
                label.text = @"总包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piCategory"]].integerValue == 1) {
                label.text = @"分包";
            }else {
                label.text = @"";
            }
            break;
        case 212:           //  工程类型
            if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piType"]].integerValue == 0) {
                label.text = @"不限";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piType"]].integerValue == 1) {
                label.text = @"A类";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piType"]].integerValue == 2) {
                label.text = @"B类";
            }else {
                label.text = @"";
            }
            break;
        case 213:           //  资质类型
            if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 0) {
                label.text = @"建筑装修装饰工程专业承包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 1) {
                label.text = @"建筑幕墙工程专业承包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 2) {
                label.text = @"机电设备安装工程专业承包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 3) {
                label.text = @"建筑智能化工程专业承包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 4) {
                label.text = @"消防设施工程专业承包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 5) {
                label.text = @"金属门窗工程专业承包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 6) {
                label.text = @"钢结构工程专业承包";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 7) {
                label.text = @"建筑装饰专项设计甲级";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 8) {
                label.text = @"建筑幕墙专项设计甲级";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 9) {
                label.text = @"承装修、试电力设施";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 10) {
                label.text = @"城市园林绿化";
            }else if ([NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAptitudetype"]].integerValue == 11) {
                label.text = @"净化工程";
            }else {
                label.text = @"";
            }
            break;
        case 214:           //  工程地址
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piAdress"]];
            break;
        case 215:           //  备注
            label.text = [NSString stringWithFormat:@"%@",model.bsProjectinfo[@"piDescrinfo"]];
            break;
        case 216:           //  合同编号
            label.text = model.pcaRealcontractid;
            break;
        case 217:           //  合同名称
            label.text = model.pcaName;
            break;
        case 218:           //  合同份数
            label.text = [NSString stringWithFormat:@"%@",model.pcaCopies];
            break;
        case 219:           //  合同金额小写（元）
            label.text = [NSString stringWithFormat:@"%@",model.pcaProjectprice];
            break;
        case 220:           //  是否含清包工
            if (model.pcaClearcontractor.integerValue == 0) {
                label.text = @"请选择";
            }else if (model.pcaClearcontractor.integerValue == 1) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 221:           //  项目负责人
            if (model.pcaOwnerpromaterial.integerValue == 0) {
                label.text = @"请选择";
            }else if (model.pcaOwnerpromaterial.integerValue == 1) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 222:           //  合同金额大写
            label.text = model.pcaProjectbigprice;
            break;
        case 223:           //  合同签订日期
            label.text = model.pcaSigneddate;
            break;
        case 224:           //  合同开工日期
            label.text = model.pcaStartdate;
            break;
        case 225:           //  合同竣工日期
            label.text = model.pcaWorkeddate;
            break;
        case 226:           //  工期
            label.text = model.pcaWorkingtime;
            break;
        case 227:           //  合同质保期
            label.text = model.pcaRetentiondate;
            break;
        case 228:           //  合同预付款比例（%）
            label.text = [NSString stringWithFormat:@"%@",model.pcaAdvancepay];
            break;
        case 229:           //  合同预付款金额（元）
            label.text = [NSString stringWithFormat:@"%@",model.pcaAdvancepaym];
            break;
        case 230:           //  合同进度款比例（%）
            label.text = [NSString stringWithFormat:@"%@",model.pcaProgresspay];
            break;
        case 231:           //  合同进度款金额（元）
            label.text = [NSString stringWithFormat:@"%@",model.pcaProgresspaym];
            break;
        case 232:           //  合同竣工款比例（%）
            label.text = [NSString stringWithFormat:@"%@",model.pcaWorkedpay];
            break;
        case 233:           //  合同竣工款金额（元）
            label.text = [NSString stringWithFormat:@"%@",model.pcaWorkedpaym];
            break;
        case 234:           //  合同结算款比例（%）
            label.text = [NSString stringWithFormat:@"%@",model.pcaSettlepay];
            break;
        case 235:           //  合同结算款金额（元）
            label.text = [NSString stringWithFormat:@"%@",model.pcaSettlepaym];
            break;
        case 236:           //  合同质保金比例（%）
            label.text = [NSString stringWithFormat:@"%@",model.pcaRetentionpay];
            break;
        case 237:           //  合同质保金款金额（元）
            label.text = [NSString stringWithFormat:@"%@",model.pcaRetentionpaym];
            break;
        case 238:           //  付款方式
            label.text = model.pcaPayway;
            break;
        case 239:           //  工程责任书状态
            if (model.pcaProjectitemsstate.integerValue == 0) {
                label.text = @"不限";
            }else if (model.pcaProjectitemsstate.integerValue == 1) {
                label.text = @"未返回";
            }else {
                label.text = @"已移交";
            }
            break;
        case 240:           //  是否需要单项工程责任书
            if (model.pcaIssingleitems.integerValue == 0) {
                label.text = @"是";
            }else if (model.pcaIssingleitems.integerValue == 1) {
                label.text = @"否";
            }else {
                label.text = @"";
            }
            break;
        case 241:           //  购买保险方式
            if (model.pcaInsuranceway.integerValue == 0) {
                label.text = @"不限";
            }else if (model.pcaInsuranceway.integerValue == 1) {
                label.text = @"自行购买";
            }else if (model.pcaInsuranceway.integerValue == 2) {
                label.text = @"委托公司购买";
            }else if (model.pcaInsuranceway.integerValue == 3) {
                label.text = @"不购买(项目已完工)";
            }else {
                label.text = @"不购买(与其他项目共享)";
            }
            break;
        case 242:           //  合同账号章
            if (model.pcaContractaccount.integerValue == 0) {
                label.text = @"华夏银行(陕西省)";
            }else if (model.pcaContractaccount.integerValue == 1) {
                label.text = @"建设银行(江苏省)";
            }else if (model.pcaContractaccount.integerValue == 2) {
                label.text = @"中国银行(其他地区)";
            }else if (model.pcaContractaccount.integerValue == 3) {
                label.text = @"招商银行";
            }else {
                label.text = @"无(默认)";
            }
            break;
        case 243:           //  合同承包范围
            label.text = model.pcaContractingscope;
            break;
        case 244:           //  工程竣工验收条款
            label.text = model.pcaWorkedacceptterm;
            break;
        case 245:           //  合同质保金条款
            label.text = model.pcaRetentionterm;
            break;
        case 246:           //  资料员姓名
            label.text = model.pcaOperatename;
            break;
        case 247:           //  资料员电话
            label.text = model.pcaOperatephone;
            break;
        case 248:           //  资料移交
            _name = @[@"招标文件",@"投标文件",@"中标通知书",@"预算",@"图纸",@"结算通知书",@"验收报告",@"开工报告",@"工程量清单"];
            for (NSString *string in [model.pcaOperatemove componentsSeparatedByString:@","]) {
                _nameString = [NSString stringWithFormat:@"%@;%@",_name[string.integerValue],_nameString];
            }
            label.text = [_nameString componentsSeparatedByString:@"(null)"].firstObject;
            break;
        case 249:           //  合同归档日期
            label.text = model.pcaArchivedate;
            break;
        case 250:           //  归档编号
            label.text = model.pcaArchiveid;
            break;
        case 251:           //  归档人
            label.text = model.pcaArchivename;
            break;
        case 252:           //  备注
            label.text = model.pcaThenote;
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
        [self.passHeightDelegate passHeightFromHTBGCell:_noteHeight + 10];
    }
}


@end
