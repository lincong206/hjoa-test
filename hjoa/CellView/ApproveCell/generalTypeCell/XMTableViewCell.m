//
//  XMTableViewCell.m
//  hjoa
//
//  Created by 华剑 on 2017/6/13.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "XMTableViewCell.h"
#import "Header.h"

@interface XMTableViewCell ()
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

@property (strong, nonatomic) NSString *aptitudetype;
@property (strong, nonatomic) NSArray *aptitudetypeArr;
@end

@implementation XMTableViewCell

- (void)creatXMApproveUIWithModel:(XMModel *)model
{
    _titleArr = @[@"工程名称",@"经营类别",@"来源归属",@"建设单位",@"工程地址",
                  @"项目负责人",@"项目负责人电话",@"业绩归属人",@"工程造价(万元)",@"甲方性质",
                  @"建筑类型",@"工程类别",@"工程类型",@"创建方式",@"资质类型",
                  @"跟踪负责人",@"区域",@"建设单位联系人",@"联系人电话",@"建筑面积(㎡)",
                  @"层数",@"工程内容",@"临时保存",@"备注"];
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

- (void)creatTextViewWithModel:(XMModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  工程名称
            label.text = model.piName;
            break;
        case 201:           //  经营类别
            if (model.piOperatecategory.integerValue == 1) {
                label.text = @"一类项目";
            }else if (model.piOperatecategory.integerValue == 2) {
                label.text = @"二类项目";
            }else {
                label.text = @"三类项目";
            }
            break;
        case 202:           //  来源归属
            label.text = [NSString stringWithFormat:@"%@",model.uiSourceuser];
            break;
        case 203:           //  建设单位
            label.text = model.piBuildcompany;
            break;
        case 204:           //  工程地址
            label.text = model.piAddresspca;
            break;
        case 205:           //  项目负责人
            label.text = model.uiManagername;
            break;
        case 206:           //  项目负责人电话
            label.text = model.uiManagermobile;
            break;
        case 207:           //  业绩归属人
            label.text = model.uiBelongname;
            break;
        case 208:           //  工程造价(万元)
            label.text = [NSString stringWithFormat:@"%@",model.piPrice];
            break;
        case 209:           //  甲方性质
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
        case 210:           //  建筑类型
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
                label.text = @"净化工程";
            }else if (model.piBuildingtype.integerValue == 18) {
                label.text = @"幕墙类";
            }
            break;
        case 211:           //  工程类别
            if (model.piCategory.integerValue == 0) {
                label.text = @"总包";
            }else if (model.piCategory.integerValue == 1) {
                label.text = @"分包";
            }
            break;
        case 212:           //  工程类型
            if (model.piType.integerValue == 0) {
                label.text = @"不限";
            }else if (model.piType.integerValue == 1) {
                label.text = @"A类";
            }else if (model.piType.integerValue == 2) {
                label.text = @"B类";
            }
            break;
        case 213:           //  创建方式
            if (model.piCreatetype.integerValue == 0) {
                label.text = @"不限";
            }else if (model.piCreatetype.integerValue == 1) {
                label.text = @"项目(跟踪)";
            }else if (model.piCreatetype.integerValue == 2) {
                label.text = @"直接投标";
            }else if (model.piCreatetype.integerValue == 3) {
                label.text = @"直接施工";
            }
            break;
        case 214:           //  资质类型
            _aptitudetypeArr = [model.piAptitudetype componentsSeparatedByString:@","];
            _aptitudetype = @"";
            for (int i = 0; i < _aptitudetypeArr.count; i ++) {
                if ([_aptitudetypeArr[i] integerValue] == 0) {
                    NSString *str = @"建筑装修装饰工程专业承包";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 1) {
                    NSString *str = @"建筑幕墙工程专业承包";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 2) {
                    NSString *str = @"机电设备安装工程专业承包";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 3) {
                    NSString *str = @"电子与智能化工程专业承包";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 4) {
                    NSString *str = @"消防设施工程专业承包";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 5) {
                    NSString *str = @"金属门窗工程专业承包";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 6) {
                    NSString *str = @"钢结构工程专业承包";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 7) {
                    NSString *str = @"建筑装饰专项设计甲级";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 8) {
                    NSString *str = @"建筑幕墙专项设计甲级";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 9) {
                    NSString *str = @"承装修、试电力设施";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 10) {
                    NSString *str = @"城市园林绿化";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }else if ([_aptitudetypeArr[i] integerValue] == 11) {
                    NSString *str = @"净化工程";
                    _aptitudetype = [NSString stringWithFormat:@"%@,%@",_aptitudetype,str];
                }
            }
            _aptitudetype = [_aptitudetype substringFromIndex:1];
            label.text = _aptitudetype;
            label.frame = CGRectMake(10 + _size.width + 10 , 10 + count*(30) + count*(10), (kscreenWidth - 10 - _size.width - 10 - 10), 73);
            break;
        case 215:           //  跟踪负责人
            label.text = model.uiFollowuser;
            break;
        case 216:           //  区域
            label.text = model.piRegion;
            break;
        case 217:           //  建设单位联系人
            label.text = model.piBuildcompanycontacts;
            break;
        case 218:           //  联系人电话
            label.text = model.piBuildcompanymoblienlie;
            break;
        case 219:           //  建筑面积(㎡)
            label.text = [NSString stringWithFormat:@"%@",model.piBuildingarea];
            break;
        case 220:           //  层数
            label.text = [NSString stringWithFormat:@"%@",model.piStoriedbuilding];
            break;
        case 221:           //  工程内容
            label.text = model.piContent;
            break;
        case 222:           //  临时保存
            if (model.piTempsave.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"";
            }
            break;
        case 223:           //  备注
            label.text = model.piDescrinfo;
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
        [self.passHeightDelegate passHeightFromXMCell:_noteHeight + 10];
    }
}

@end
