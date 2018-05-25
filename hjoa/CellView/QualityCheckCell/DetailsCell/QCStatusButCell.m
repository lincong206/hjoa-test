//
//  QCStatusButCell.m
//  hjoa
//
//  Created by 华剑 on 2018/2/28.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCStatusButCell.h"
#import "Header.h"

@interface QCStatusButCell ()
{
    CGFloat _width;
}

@end

@implementation QCStatusButCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)loadQCStatusFromState:(NSString *)state andUserEnabled:(BOOL)abled
{
    _width = (kscreenWidth - (self.butName.count+1)*20)/self.butName.count;
    
    for (int i = 0; i < self.butName.count; i ++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor whiteColor];
        but.frame = CGRectMake(20+((_width+20)*i), 8, _width, 30);
        [but setTitle:self.butName[i] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:14];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.layer.borderColor = [UIColor blackColor].CGColor;
        but.layer.borderWidth = 1.0f;
        but.tag = 100+i;
        but.userInteractionEnabled = abled;
        [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
        
        if (abled) {
            
        }else {
            
            if (but.tag == state.integerValue + 100) {
                // 显示背景色
                switch (state.integerValue) {
                    case 0:
                        but.backgroundColor = [UIColor greenColor];
                        break;
                    case 1:
                        but.backgroundColor = [UIColor yellowColor];
                        break;
                    case 2:
                        but.backgroundColor = [UIColor redColor];
                        break;
                    default:
                        but.backgroundColor = [UIColor whiteColor];
                        break;
                }
            }
            
        }
    }
}

- (void)clickBut:(UIButton *)sender
{
    for (int i = 0; i < self.butName.count; i ++) {
        if (sender.tag == 100 +i) {
            switch (sender.tag) {
                case 100:
                    sender.backgroundColor = [UIColor greenColor];
                    break;
                case 101:
                    sender.backgroundColor = [UIColor yellowColor];
                    break;
                case 102:
                    sender.backgroundColor = [UIColor redColor];
                    break;
                default:
                    sender.backgroundColor = [UIColor whiteColor];
                    break;
            }
            continue;
        }
        UIButton *button = (UIButton *)[self viewWithTag:i + 100];
        button.backgroundColor = [UIColor whiteColor];
    }
    [self.passStatusDelegate passButStatus:sender.titleLabel.text andButTag:sender.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
