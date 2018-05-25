//
//  RecordView.h
//  hjoa
//
//  Created by 华剑 on 2017/9/22.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  打卡View

#import <UIKit/UIKit.h>

@protocol passNotesFromRecordView <NSObject>

- (void)passNotesFromRecordView:(NSString *)notes;

@end

@protocol passPostImageNewsFromRecordView <NSObject>

- (void)passPostImageNewsFromRecordView:(NSString *)imageNews andSuccess:(BOOL)success;

@end

@protocol passImagePickFromRecordView <NSObject>

- (void)passImagePickFromRecordView:(UIImagePickerController *)imagePick;

@end

@interface RecordView : UIView

@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIButton *sureBut;
@property (strong, nonatomic) UIButton *cancelBut;

@property (weak, nonatomic) id<passImagePickFromRecordView> passImagePickdelegate;
@property (weak, nonatomic) id<passPostImageNewsFromRecordView> passImageNewsDelegate;
@property (weak, nonatomic) id<passNotesFromRecordView> passNoteDelegate;

@end
