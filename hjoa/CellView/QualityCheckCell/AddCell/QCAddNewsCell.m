//
//  QCAddNewsCell.m
//  hjoa
//
//  Created by 华剑 on 2018/3/5.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCAddNewsCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation QCAddNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    toolbar.userInteractionEnabled = YES;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    self.text.inputAccessoryView = toolbar;
}

- (void)textFieldDone
{
    [self.passTextDelegate passTextFromQCAddNewsCell:self.text.text];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
