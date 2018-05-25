//
//  TBCH.m
//  hjoa
//
//  Created by 华剑 on 2017/8/29.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "TBCH.h"
#import "Header.h"
@interface TBCH ()
{
    UIFont *_fnt;
    CGFloat _noteHeight;    // 内容文字高度
    CGSize _size;
    NSInteger _shang;
    CGFloat _titleHeight;
}
@property (strong, nonatomic) UILabel *noteLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSArray *titleArr;

@end

@implementation TBCH

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSArray array];
    }
    return _titleArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreTBCHUIWithModel:(TBCHModel *)model
{
    // 标题
    self.titleArr = @[@"项目",@"工作地点",@"收费金额(元)",@"编制责任人",@"要求完成时间"];
    _fnt = [UIFont systemFontOfSize:12];
    for (int i = 0; i < self.titleArr.count; i ++) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + i*(((kscreenWidth - 30)/5)+5), 5, (kscreenWidth - 30)/5, 20)];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = self.titleArr[i];
        self.titleLabel.font = _fnt;
        [self.contentView addSubview:self.titleLabel];
    }
    _titleHeight = 0.0;
    _noteHeight = 0.0;
    // 以地址的高度为统一高度
    for (int i = 0; i < 4; i ++) {
        self.noteLabel = [[UILabel alloc] init];
        self.noteLabel.backgroundColor = [UIColor whiteColor];
        self.noteLabel.font = _fnt;
        self.noteLabel.tag = 100+i;
        self.noteLabel.numberOfLines = 0;
        [self creatTextViewWithModel:model andLabel:self.noteLabel andCount:i];
    }
    
//    NSLog(@"%f",_noteHeight);
    
    // 创建生成其他内容
    [self creatOtherNoteLabelWithModel:model];
    
    [self.passHeightDelegate passHeightFromTBCH:(30 + _titleHeight)];
    
}

- (void)creatTextViewWithModel:(TBCHModel *)model andLabel:(UILabel *)label andCount:(NSInteger )count
{
    switch (label.tag) {
        case 100:
            label.text = model.bsProjectbidplot[@"pbpPricebidworkaddress"];
            break;
        case 101:
            label.text = model.bsProjectbidplot[@"pbpTechnicalbidaddress"];
            break;
        case 102:
            label.text = model.bsProjectbidplot[@"pbpCreditbidworkaddress"];
            break;
        case 103:
            label.text = model.bsProjectbidplot[@"pbpOtheraddress"];
            break;
        default:
            label.text = @"";
            break;
    }
    if (label.text == nil || [label.text isEqualToString:@"(null)"] || [label.text isEqual:[NSNull alloc]] || [label.text isEqualToString:@""] || [label.text isEqualToString:@" "] || [label.text isEqualToString:@"<null>"]) {
        label.text = @"--";
    }
    _size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    // 为多行时
    if (_size.width > ((kscreenWidth - 30)/5)) {
        NSInteger shang = _size.width/((kscreenWidth - 30)/5);
        _noteHeight = (shang+1)*_size.height;
    }else {
        _noteHeight = _size.height;
    }
    label.frame = CGRectMake(5 + (((kscreenWidth - 30)/5)+5), 25+5+_titleHeight, (kscreenWidth - 30)/5, _noteHeight);
    [self.contentView addSubview:label];
    
    //第一列
    self.titleArr = @[@"商务标",@"技术标",@"资信标",@"其他"];
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25+5+_titleHeight, (kscreenWidth - 30)/5, _noteHeight)];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.text = self.titleArr[count];
    [self.contentView addSubview:self.noteLabel];
    
    // 第三列
    self.titleArr = @[model.bsProjectbidplot[@"pbpPricebidcharge"],
                      model.bsProjectbidplot[@"pbpTechnicalbidcharge"],
                      model.bsProjectbidplot[@"pbpCreditbidcharge"],
                      model.bsProjectbidplot[@"pbpOthercharge"]];
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + 2*(((kscreenWidth - 30)/5)+5), 25+5+_titleHeight, (kscreenWidth - 30)/5, _noteHeight)];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.text = [NSString stringWithFormat:@"%@",self.titleArr[count]];
    [self.contentView addSubview:self.noteLabel];
    
    // 第四列
    self.titleArr = @[model.bsProjectbidplot[@"pbpPricebidusername"],
                      model.bsProjectbidplot[@"pbpTechnicalbidusername"],
                      model.bsProjectbidplot[@"pbpCreditbidusername"],
                      model.bsProjectbidplot[@"pbpOthercompilername"]];
    
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + 3*(((kscreenWidth - 30)/5)+5), 25+5+_titleHeight, (kscreenWidth - 30)/5, _noteHeight)];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.text = self.titleArr[count];
    [self.contentView addSubview:self.noteLabel];
    
    self.titleArr = @[model.bsProjectbidplot[@"pbpPricebidfinishtime"],
                      model.bsProjectbidplot[@"pbpTechnicalbidfinish"],
                      model.bsProjectbidplot[@"pbpCreditbidfinishtime"],
                      model.bsProjectbidplot[@"pbpOtherfinishtime"]];
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + 4*(((kscreenWidth - 30)/5)+5), 25+5+_titleHeight, (kscreenWidth - 30)/5, _noteHeight)];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.text = [self.titleArr[count] componentsSeparatedByString:@" "].firstObject;
    [self.contentView addSubview:self.noteLabel];
    
    _titleHeight += _noteHeight + 5;
}

- (void)creatOtherNoteLabelWithModel:(TBCHModel *)model
{
//    _titleHeight = 0;
    self.titleArr = @[@"材料样板要求及完成情况",@"开标携带证件清单",@"送标、开标答辩人员安排",@"标前动员会议内容",@"备注"];
    
    // 材料样板要求及完成情况
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.backgroundColor = [UIColor whiteColor];
    leftLabel.text = self.titleArr[0];
    leftLabel.font = _fnt;
    leftLabel.numberOfLines = 0;
    
//    CGFloat width = ((kscreenWidth-30)*3)/5;
    _size = [model.bsProjectbidplot[@"pbpMatsampreqandperf"] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    self.noteLabel = [[UILabel alloc] init];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.text = model.bsProjectbidplot[@"pbpMatsampreqandperf"];
    if (_size.width > kscreenWidth-180) {
        _shang = _size.width/(kscreenWidth-180);
        self.noteLabel.frame = CGRectMake(175, 30+_titleHeight, kscreenWidth - 175, (_shang+1)*_size.height);
        leftLabel.frame = CGRectMake(5, 30+_titleHeight + (20+5)*0, 150, (_shang+1)*_size.height);
    }else {
        self.noteLabel.frame = CGRectMake(175, 30+_titleHeight, kscreenWidth - 175 - 5, _size.height);
        leftLabel.frame = CGRectMake(5, 30+_titleHeight + (20+5)*0, 150, _size.height);
    }
    [self.contentView addSubview:leftLabel];
    [self.contentView addSubview:self.noteLabel];
    
    
    _titleHeight += (_shang+1)*_size.height + 5;
    
    //开标携带证件清单
    UILabel *left1Label = [[UILabel alloc] init];
    left1Label.backgroundColor = [UIColor whiteColor];
    left1Label.text = self.titleArr[1];
    left1Label.font = _fnt;
    left1Label.numberOfLines = 0;
    
    //    CGFloat width = ((kscreenWidth-30)*3)/5;
    _size = [model.bsProjectbidplot[@"pbpBidopcarrycertlist"] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    self.noteLabel = [[UILabel alloc] init];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.text = model.bsProjectbidplot[@"pbpBidopcarrycertlist"];
    if (_size.width > kscreenWidth-180) {
        _shang = _size.width/(kscreenWidth-180);
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175, (_shang+1)*_size.height);
        left1Label.frame = CGRectMake(5, 30 + _titleHeight, 150, (_shang+1)*_size.height);
    }else {
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175 - 5, _size.height);
        left1Label.frame = CGRectMake(5, 30 + _titleHeight, 150, _size.height);
    }
    [self.contentView addSubview:left1Label];
    [self.contentView addSubview:self.noteLabel];
    
    _titleHeight += (_shang+1)*_size.height + 5;
    
    //送标、开标答辩人员安排
    UILabel *left2Label = [[UILabel alloc] init];
    left2Label.backgroundColor = [UIColor whiteColor];
    left2Label.text = self.titleArr[2];
    left2Label.font = _fnt;
    left2Label.numberOfLines = 0;
    
    //    CGFloat width = ((kscreenWidth-30)*3)/5;
    _size = [model.bsProjectbidplot[@"pbpBidsendbidoppleader"] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    self.noteLabel = [[UILabel alloc] init];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.text = model.bsProjectbidplot[@"pbpBidsendbidoppleader"];
    if (_size.width > kscreenWidth-180) {
        _shang = _size.width/(kscreenWidth-180);
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175, (_shang+1)*_size.height);
        left2Label.frame = CGRectMake(5, 30 + _titleHeight, 150, (_shang+1)*_size.height);
    }else {
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175 - 5, _size.height);
        left2Label.frame = CGRectMake(5, 30 + _titleHeight, 150, _size.height);
    }
    [self.contentView addSubview:left2Label];
    [self.contentView addSubview:self.noteLabel];
    
    _titleHeight += (_shang+1)*_size.height + 5;
    
    //标前动员会议内容
    UILabel *left3Label = [[UILabel alloc] init];
    left3Label.backgroundColor = [UIColor whiteColor];
    left3Label.text = self.titleArr[3];
    left3Label.font = _fnt;
    left3Label.numberOfLines = 0;
    
    //    CGFloat width = ((kscreenWidth-30)*3)/5;
    _size = [model.bsProjectbidplot[@"pbpBidmeetingcontent"] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    self.noteLabel = [[UILabel alloc] init];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.text = model.bsProjectbidplot[@"pbpBidmeetingcontent"];
    if (_size.width > kscreenWidth-180) {
        _shang = _size.width/(kscreenWidth-180);
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175, (_shang+1)*_size.height);
        left3Label.frame = CGRectMake(5, 30 + _titleHeight, 150, (_shang+1)*_size.height);
    }else {
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175 - 5, _size.height);
        left3Label.frame = CGRectMake(5, 30 + _titleHeight, 150, _size.height);
    }
    [self.contentView addSubview:left3Label];
    [self.contentView addSubview:self.noteLabel];
    
    _titleHeight += (_shang+1)*_size.height + 5;
    
    //备注
    UILabel *left4Label = [[UILabel alloc] init];
    left4Label.backgroundColor = [UIColor whiteColor];
    left4Label.text = self.titleArr[4];
    left4Label.font = _fnt;
    left4Label.numberOfLines = 0;
    
    //    CGFloat width = ((kscreenWidth-30)*3)/5;
    _size = [model.bsProjectbidplot[@"pbpRemarks"] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_fnt,NSFontAttributeName, nil]];
    self.noteLabel = [[UILabel alloc] init];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = _fnt;
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.text = model.bsProjectbidplot[@"pbpRemarks"];
    if (_size.width > kscreenWidth-180) {
        _shang = _size.width/(kscreenWidth-180);
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175, (_shang+1)*_size.height);
        left4Label.frame = CGRectMake(5, 30 + _titleHeight, 150, (_shang+1)*_size.height);
    }else {
        self.noteLabel.frame = CGRectMake(175, 30 + _titleHeight, kscreenWidth - 175 - 5, _size.height);
        left4Label.frame = CGRectMake(5, 30 + _titleHeight, 150, _size.height);
    }
    [self.contentView addSubview:left4Label];
    [self.contentView addSubview:self.noteLabel];
    
    _titleHeight += (_shang+1)*_size.height + 5;
}


@end
