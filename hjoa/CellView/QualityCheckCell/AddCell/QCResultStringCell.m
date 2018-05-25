//
//  QCResultStringCell.m
//  hjoa
//
//  Created by 华剑 on 2018/3/6.
//  Copyright © 2018年 huajian. All rights reserved.
//

#import "QCResultStringCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface QCResultStringCell () <UITextViewDelegate>
{
    NSString *_pString;
}

@end

@implementation QCResultStringCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _pString = @"";
    
    self.input.alpha = 0.5;
    self.input.text = @"请输入检查结果...";
    self.input.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    toolbar.userInteractionEnabled = YES;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    self.input.inputAccessoryView = toolbar;
    
}

- (void)textFieldDone
{
    [self.passTextDelegate passTextFromQCResultStringCell:self.input.text];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = [NSString stringWithFormat:@"%@",_pString];
    textView.alpha = 1.0;
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
