//
//  QCResultCell.m
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCResultCell.h"
#import "Header.h"
#import "QCDetailsModel.h"

@interface QCResultCell ()
{
    CGSize _resultSize;
    NSInteger _row;
    CGFloat _height;
}
@property (strong, nonatomic) UILabel *result;

@end

@implementation QCResultCell

- (UILabel *)result
{
    if (!_result) {
        _result = [[UILabel alloc] init];
        _result.font = [UIFont systemFontOfSize:15];
        _result.numberOfLines = 0;
    }
    return _result;
}

- (void)loadQCResultFromDataSource:(NSString *)birInspectionresult
{
    _resultSize = [birInspectionresult sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
//        NSLog(@"_resultSize--width--%f,height--%f",_resultSize.width,_resultSize.height);
    if (_resultSize.width >= (kscreenWidth-20-10)) {      // 多行文本  横向文字长
        _row = _resultSize.width/(kscreenWidth-30);
        self.result.frame = CGRectMake(20, 8, (kscreenWidth-20-10), (_row+1)*20);
        _height = (_row+1)*20 + 10;
    }else if (_resultSize.height >= 30) {     // 多行文本  纵向文字  (回车多)
        self.result.frame = CGRectMake(20, 8, (kscreenWidth-20-10), _resultSize.height);
        _height = _resultSize.height + 10;
    }else {
        self.result.frame = CGRectMake(20, 8, (kscreenWidth-20-10), 30);
        _height = 44;
    }
    self.result.text = [birInspectionresult stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.passHeightDelegate passHeightFromQCResultCell:_height];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView addSubview:self.result];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
