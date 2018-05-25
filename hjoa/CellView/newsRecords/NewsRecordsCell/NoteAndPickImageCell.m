//
//  NoteAndPickImageCell.m
//  hjoa
//
//  Created by 华剑 on 2017/9/26.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "NoteAndPickImageCell.h"
#import "AFNetworking.h"
#import "Header.h"

@interface NoteAndPickImageCell ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) UIImagePickerController *imagePick;
@end

@implementation NoteAndPickImageCell

- (UIImagePickerController *)imagePick
{
    if (!_imagePick) {
        _imagePick = [[UIImagePickerController alloc] init];
        _imagePick.delegate = self;
        _imagePick.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePick.allowsEditing = YES;
    }
    return _imagePick;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.content.delegate = self;
    
    self.cameraImage.image = [UIImage imageNamed:@"record_camera"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    [self.cameraImage addGestureRecognizer:tap];

    [self hidekeyboard];
}

// 给键盘添加一个完成按钮
- (void)hidekeyboard
{
    UIToolbar * backView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [backView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.frame = CGRectMake(2, 5, 70, 30);
    [btn addTarget:self action:@selector(cancelInput:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray * buttonsArray = @[btnSpace,doneBtn];
    [backView setItems:buttonsArray];
    [self.content setInputAccessoryView:backView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.passNotesDelegate passNotesFromNoteCell:textField.text];
}

- (void)cancelInput:(UIButton *)but
{
    [self.content resignFirstResponder];
}

// 调用系统相机 (模拟器不支持)
- (void)clickTap:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 设置照片来源为相机
        self.imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        self.imagePick.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 展示选取照片控制器
        [self.passImagePickDelegate passPickImageVCFromNoteCell:self.imagePick];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self upLoadImageWith:image];
    self.cameraImage.image = image;
}

// 上传图片
- (void)upLoadImageWith:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSString *url = [NSString stringWithFormat:@"%@/caImgupload/imgSubmit",intranetURL];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:date]] mimeType:@"image/jpg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            [self.passImageNewsDelegate passPostImageNewsFromNoteCellWithImageNews:responseObject[@"result"] andSuccess:YES];
        }
        [self.passImageNewsDelegate passPostImageNewsFromNoteCellWithImageNews:nil andSuccess:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.passImageNewsDelegate passPostImageNewsFromNoteCellWithImageNews:nil andSuccess:NO];
    }];
}

@end
