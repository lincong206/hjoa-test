//
//  DataRecordsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/11/2.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "DataRecordsCell.h"
#import "Header.h"


@interface DataRecordsCell ()
{
    NSMutableArray *_dataSource;
    NSString *_title;
}
@property (strong, nonatomic) UIButton *dateBut;        // 日期选择按钮
@property (strong, nonatomic) UIImageView *round;       // 圆圈显示数据占比

@end

@implementation DataRecordsCell

- (UIButton *)recordDetailed
{
    if (!_recordDetailed) {
        _recordDetailed = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordDetailed.frame = CGRectMake(100-80, 130, 160, 30);
        _recordDetailed.backgroundColor = [UIColor clearColor];
        _recordDetailed.titleLabel.font = [UIFont systemFontOfSize:14];
        [_recordDetailed setTitleColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_recordDetailed setTitle:@"进度明细" forState:UIControlStateNormal];
    }
    return _recordDetailed;
}

- (UIButton *)dateBut
{
    if (!_dateBut) {
        _dateBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateBut.frame = CGRectMake(20, 20, 100, 25);
        _dateBut.backgroundColor = [UIColor clearColor];
        _dateBut.titleLabel.font = [UIFont systemFontOfSize:15];
        [_dateBut setTitleColor:[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0] forState:UIControlStateNormal];
        
    }
    return _dateBut;
}

//
- (void)refreshDataRecordCellWithData:(NSMutableArray *)data
{
    _dataSource = data.copy;
    // 移除cell上的全部视图
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    // 项目选择
    [self.dateBut setTitle:self.xmName forState:UIControlStateNormal];
    [self.contentView addSubview:self.dateBut];
    
    for (DataCountModel *model in data) {
        if ([model.title isEqualToString:@"总合同额"]) {
            // 圆圈图绘制
            [self creatRoundDataWithModel:model];
        }
    }
    // 文字和数字数据
    [self creatNumberViewWithData:data];
}

- (void)creatRoundDataWithModel:(DataCountModel *)model
{
    self.round = [[UIImageView alloc] initWithFrame:CGRectMake((kscreenWidth-200)/2 , 50, 200, 200)];
    self.round.userInteractionEnabled = YES;
    self.round.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.round];
    
    // 底部
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    CAShapeLayer *pathLayer2 = [CAShapeLayer layer];
    [path2 addArcWithCenter:CGPointMake(100, 100) radius:90 startAngle:0 endAngle:2*M_PI clockwise:TRUE];
    pathLayer2.path = path2.CGPath;
    pathLayer2.strokeColor = [[UIColor colorWithWhite:0.95 alpha:1.0]CGColor];
    pathLayer2.fillColor = [[UIColor clearColor]CGColor];//填充颜色
    pathLayer2.lineJoin = kCALineJoinRound;
    pathLayer2.lineWidth = 10.0;
    [self.round.layer addSublayer:pathLayer2];
    
    // 数据占比
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    CAShapeLayer *pathLayer1 = [CAShapeLayer layer];
    [path1 addArcWithCenter:CGPointMake(100, 100) radius:90 startAngle:(-0.5)*M_PI endAngle:((([model.gross floatValue]/[model.currentStatus floatValue])*2)-0.5)*M_PI clockwise:TRUE];
    pathLayer1.path = path1.CGPath;
    pathLayer1.strokeColor = [[UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0]CGColor];//画线颜色
    pathLayer1.fillColor = [[UIColor clearColor]CGColor];//填充颜色
    pathLayer1.lineJoin = kCALineJoinRound;
    pathLayer1.lineWidth = 10.0;
    [self.round.layer addSublayer:pathLayer1];
    
    // 文字
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(100-80, 50, 160, 30)];
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont systemFontOfSize:17];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = @"完工进度";
    [self.round addSubview:text];
    // 数据
    UILabel *data = [[UILabel alloc] initWithFrame:CGRectMake(100-80, 90, 160, 30)];
    data.backgroundColor = [UIColor clearColor];
    data.font = [UIFont systemFontOfSize:22];
    data.textAlignment = NSTextAlignmentCenter;
    data.text = [NSString stringWithFormat:@"%.1f%@",model.completionRate.floatValue,@"%"];
    [self.round addSubview:data];
    // 打卡明细按钮
    [self.round addSubview:self.recordDetailed];
}

// 打卡数据总结
- (void)creatNumberViewWithData:(NSMutableArray *)data
{
    // 打卡显示
    for (int i = 0; i < data.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + (((kscreenWidth - 50)/2)+5)*(i%2), 250+(65*(i/2)), (kscreenWidth - 50)/2, 50)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        imageView.backgroundColor = [UIColor whiteColor];
        // 数字
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageView.bounds.size.width, 25)];
        number.userInteractionEnabled = YES;
        number.textAlignment = NSTextAlignmentCenter;
        number.font = [UIFont fontWithName:@"ArialMT" size:(25.0)];
        number.text = [NSString stringWithFormat:@"%@",[data[i] currentStatus]];
        number.textColor = [UIColor blackColor];
        [imageView addSubview:number];
        // 文字
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, imageView.bounds.size.width, 20)];
        text.userInteractionEnabled = YES;
        text.textAlignment = NSTextAlignmentCenter;
        text.font = [UIFont systemFontOfSize:14];
        text.text = [data[i] title];
        text.textColor = [UIColor blackColor];
        [imageView addSubview:text];
        
        [self.contentView addSubview:imageView];
        // 按钮
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = imageView.frame;
        but.tag = imageView.tag;
        but.backgroundColor = [UIColor clearColor];
        [but addTarget:self action:@selector(clickBackView:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
    }
}

// 被点击哪一个按钮
- (void)clickBackView:(UIButton *)but
{
    DataCountModel *model = _dataSource[but.tag-100];
    _title = model.title;
    [self.passModelDelegate passModel:model withTitle:_title];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
