//
//  ReplyButCell.m
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "ReplyButCell.h"
#import "Header.h"
@interface ReplyButCell ()

{
    NSArray *_name;
}

@end

@implementation ReplyButCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)addButName:(NSArray *)butName
{
    _name = butName;
    for (int i = 0; i < butName.count; i ++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(((kscreenWidth-240)/3)*(i+1) + 120*i, 20, 120, 40);
        but.backgroundColor = [UIColor lightGrayColor];
        [but setTitle:butName[i] forState:UIControlStateNormal];
        [but setTitle:butName[i] forState:UIControlStateSelected];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        but.titleLabel.font = [UIFont systemFontOfSize:14];
        but.tag = 100+i;
        [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
    }
}

- (void)clickBut:(UIButton *)but
{
    for (int i = 0; i < _name.count; i++) {
        if (but.tag == 100+i) {
            if (but.tag == 100) {
                but.backgroundColor = [UIColor greenColor];
            }else {
                but.backgroundColor = [UIColor redColor];
            }
            continue;
        }
        UIButton *button = (UIButton *)[self viewWithTag:i+100];
        button.backgroundColor = [UIColor lightGrayColor];
    }
    [self.passTagDelegate passButTag:but.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
