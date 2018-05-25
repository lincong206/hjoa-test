//
//  JDCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/10.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "JDCell.h"
#import "Header.h"

@interface JDCell ()
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

@implementation JDCell

- (void)creatJDApproveUIWithModel:(JDModel *)model
{
    _titleArr = @[@"编号",@"发起人",@"发起部门",@"申请人",@"申请人电话",
                  @"接待时间",@"投标项目",@"考察方单位",@"工程造价(元)",@"考察方联系人",
                  @"考察方人数",@"考察方电话",@"是否考察项目",@"考察项目名称",@"是否设置欢迎词",
                  @"会议室布置",@"是否购买水果",@"消费金额(元)",@"是否用车",@"用车天数(天)",
                  @"路桥费",@"消费金额(元)",@"是否用餐(会所)",@"用餐人数",@"用餐天数",
                  @"消费金额(元)",@"是否订往返机票",@"是否代订住房",@"是否代订餐",@"消费金额(元)",
                  @"参与接待人员",@"备注",@"本次接待结果",@"本次接待消费总金额(元)",@"注意"];
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

- (void)creatTextViewWithModel:(JDModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  编号
            label.text = model.draIdnum;
            break;
        case 201:           //  发起人
            label.text = model.uiName;
            break;
        case 202:           //  发起部门
            label.text = model.uiPsname;
            break;
        case 203:           //  申请人
            label.text = model.draUiname;
            break;
        case 204:           //  申请人电话
            label.text = model.draPhone;
            break;
        case 205:           //  接待时间
            label.text = [model.draReceptiontime componentsSeparatedByString:@" "].firstObject;
            break;
        case 206:           //  投标项目
            label.text = model.draBidproject;
            break;
        case 207:           //  考察方单位
            label.text = model.draInspectunit;
            break;
        case 208:           //  工程造价(元)
            label.text = [NSString stringWithFormat:@"%@",model.draProjectcost];
            break;
        case 209:           //  考察方联系人
            label.text = model.draInspectcontactman;
            break;
        case 210:           //  考察方人数
            label.text = [NSString stringWithFormat:@"%@",model.draInspectnum];
            break;
        case 211:           //  考察方电话
            label.text = model.draInspectphone;
            break;
        case 212:           //  是否考察项目
            if (model.draIsinpectproject.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 213:           //  考察项目名称
            label.text = model.draInspectname;
            break;
        case 214:           //  是否设置欢迎词
            if (model.draIsdecorate.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 215:           //  会议室布置
            label.text = model.uiName;
            break;
        case 216:           //  是否购买水果
            if (model.draIsbuyfruit.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 217:           //  消费金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.draBuyfruitcost];
            break;
        case 218:           //  是否用车
            if (model.draIsusecar.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 219:           //  用车天数(天)
            label.text = [NSString stringWithFormat:@"%@",model.draUsecarday];
            break;
        case 220:           //  路桥费
            label.text = [NSString stringWithFormat:@"%@",model.draCrossbridgecost];
            break;
        case 221:           //  消费金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.draUsecarcost];
            break;
        case 222:           //  是否用餐(会所)
            if (model.draIsdiner.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 223:           //  用餐人数
            label.text = [NSString stringWithFormat:@"%@",model.draDinernum];
            break;
        case 224:           //  用餐天数
            label.text = [NSString stringWithFormat:@"%@",model.draDinerday];
            break;
        case 225:           //  消费金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.draDinercost];
            break;
        case 226:           //  是否订往返机票
            if (model.draIsbookticket.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
        case 227:           //  是否代订住房
            if (model.draIsbookhousing.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 228:           //  是否代订餐
            if (model.draIsbookmeal.integerValue == 0) {
                label.text = @"是";
            }else {
                label.text = @"否";
            }
            break;
        case 229:           //  消费金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.draThmcost];
            break;
        case 230:           //  参与接待人员
            label.text = model.draReceptionman;
            break;
        case 231:           //  备注
            label.text = model.draRemark;
            break;
        case 232:           //  本次接待结果
            label.text = model.draIsaccomplish;
            break;
        case 233:           //  本次接待消费总金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.draAllcost];
            break;
        case 234:           //  注意
            label.text = @"会所用餐只针对公司客户，不对合作经营客户开放";
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
        [self.passHeightDelegate passHeightFromJDCell:_noteHeight + 10];
    }
}
@end
