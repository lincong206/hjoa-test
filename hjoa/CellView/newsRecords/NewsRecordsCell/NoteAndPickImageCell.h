//
//  NoteAndPickImageCell.h
//  hjoa
//
//  Created by 华剑 on 2017/9/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passNotesFromNoteCell <NSObject>

- (void)passNotesFromNoteCell:(NSString *)notes;

@end

@protocol passPostImageNewsFromNoteCell <NSObject>

- (void)passPostImageNewsFromNoteCellWithImageNews:(NSString *)imageNews andSuccess:(BOOL)success;

@end

@protocol passPickImageVCFromNoteCell <NSObject>

- (void)passPickImageVCFromNoteCell:(UIImagePickerController *)imagePick;

@end

@interface NoteAndPickImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *content;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImage;

@property (weak, nonatomic) id<passPickImageVCFromNoteCell> passImagePickDelegate;  // 传相机界面
@property (weak, nonatomic) id<passPostImageNewsFromNoteCell> passImageNewsDelegate;// 传图片信息
@property (weak, nonatomic) id<passNotesFromNoteCell> passNotesDelegate;    // 传备注信息

@end
