//
//  ZYLKCell.m
//  hjoa
//
//  Created by 华剑 on 2018/1/26.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "ZYLKCell.h"
#import "Header.h"

@interface ZYLKCell ()
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

@implementation ZYLKCell

- (void)creatZYLKApproveUIWithModel:(ZYLKModel *)model
{
    _titleArr = @[@"项目编号",@"项目名称",@"合同编号",@"合同名称",@"建设单位",
                  @"合同总金额(元)",@"原合同金额",@"补充金额",@"建设单位联系人",@"业绩归属人",
                  @"项目管理责任人",@"责任人电弧",@"付款方式",@"来款单位",@"工程款类型",
                  @"批次",@"本次来款金额",@"本次到款日期",@"上期末累积到账金额(元)",@"累计到账金额",
                  @"工程进度",@"到款比例",@"现场情况",@"备注"];
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
- (void)creatTextViewWithModel:(ZYLKModel *)model andLabel:(UILabel *)label andCount:(int)count andTitleLabel:(UILabel *)titleLabel andTitleSize:(CGSize )titleSize
{
    titleLabel.text = _titleArr[count];
    _titleSize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    
    switch (label.tag) {
        case 200:           //  项目编号
            label.text = model.piIdnum;
            break;
        case 201:           //  项目名称
            label.text = model.piName;
            break;
        case 202:           //  合同编号
            label.text = model.bpcRealcontractid;
            break;
        case 203:           //  合同名称
            label.text = model.bpcName;
            break;
        case 204:           //  建设单位
            label.text = model.piBuildcompany;
            break;
        case 205:           //  合同总金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.bpcSupplyfee];
            break;
        case 206:           //  原合同金额
            label.text = [NSString stringWithFormat:@"%@",model.bpcProjectprice];
            break;
        case 207:           //  补充金额
            label.text = [NSString stringWithFormat:@"%@",model.supperMoney];
            break;
        case 208:           //  建设单位联系人
            label.text = model.piBuildcompanycontacts;
            break;
        case 209:           //  业绩归属人
            label.text = model.uiBelongname;
            break;
        case 210:           //  项目管理责任人
            label.text = model.uiManagername;
            break;
        case 211:           //  责任人电话
            label.text = model.uiManagermobile;
            break;
        case 212:           //  付款方式
            label.text = model.bpcPayway;
            break;
        case 213:           //  来款单位
            label.text = model.sprPayeeorganization;
            break;
        case 214:           //  工程款类型
            label.text = model.sprProjectcosttype;
            break;
        case 215:           //  批次
            label.text = model.sprBatch;
            break;
        case 216:           //  本次来款金额
            label.text = [NSString stringWithFormat:@"%@",model.sprCurrentpaymoney];
            break;
        case 217:           //  本次到款日期
            label.text = model.sprCurrentpaydate;
            break;
        case 218:           //  上期末累计到账金额(元)
            label.text = [NSString stringWithFormat:@"%@",model.sprLasttotalpayee];
            break;
        case 219:           //  累计到账金额
            label.text = [NSString stringWithFormat:@"%@",model.sprTotalpayee];
            break;
        case 220:           //  工程进度
            label.text = model.sprProgress;
            break;
        case 221:           //  到款比例
            label.text = model.sprPayeeratio;
            break;
        case 222:           //  现场情况
            label.text = model.sprSitecondition;
            break;
        case 223:           //  备注
            label.text = model.sprRemark;
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
        [self.passHeightDelegate passHeightFromZYLKCell:_noteHeight + 10];
    }
}
@end
