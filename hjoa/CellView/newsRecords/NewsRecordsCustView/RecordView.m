//
//  RecordView.m
//  hjoa
//
//  Created by 华剑 on 2017/9/22.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  打卡View (外勤打卡View和早退打卡View)

#import "RecordView.h"
#import "AFNetworking.h"
#import "Header.h"
#define viewWidth self.bounds.size.width
#define viewHeight self.bounds.size.height
@interface RecordView () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UILabel *recordTimeLabel;
@property (strong, nonatomic) UILabel *recordAddressLabel;
@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) UIImageView *cameraImage;
@property (strong, nonatomic) UITextView *content;
@property (strong, nonatomic) NSString *finaStr;
@property (strong, nonatomic) UIImagePickerController *imagePick;
@end

@implementation RecordView

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

- (UIImageView *)cameraImage
{
    if (!_cameraImage) {
        _cameraImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, viewHeight-110, 60, 60)];
        _cameraImage.image = [UIImage imageNamed:@"record_camera"];
        _cameraImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_cameraImage addGestureRecognizer:tap];
    }
    return _cameraImage;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 50)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UILabel *)recordTimeLabel
{
    if (!_recordTimeLabel) {
        _recordTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 55, 70, 20)];
        _recordTimeLabel.backgroundColor = [UIColor whiteColor];
        _recordTimeLabel.font = [UIFont systemFontOfSize:15];
        _recordTimeLabel.text = @"打卡时间:";
        _recordTimeLabel.textColor = [UIColor grayColor];
    }
    return _recordTimeLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, viewWidth - 80, 20)];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UILabel *)recordAddressLabel
{
    if (!_recordAddressLabel) {
        _recordAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 70, 20)];
        _recordAddressLabel.backgroundColor = [UIColor whiteColor];
        _recordAddressLabel.font = [UIFont systemFontOfSize:15];
        _recordAddressLabel.textColor = [UIColor grayColor];
        _recordAddressLabel.text = @"打卡地点:";
    }
    return _recordAddressLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = [UIColor grayColor];
    }
    return _addressLabel;
}

- (UITextView *)content
{
    if (!_content) {
        _content = [[UITextView alloc] initWithFrame:CGRectMake(5, self.height+95, viewWidth-10, (viewHeight-self.height-90-40-65))];
        _content.backgroundColor = [UIColor whiteColor];
        _content.text = @"请填写打卡备注(选填)";
        _content.font = [UIFont systemFontOfSize:15];
        _content.alpha = 0.5;
        _content.delegate = self;
    }
    return _content;
}

- (UIButton *)sureBut
{
    if (!_sureBut) {
        _sureBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBut.frame = CGRectMake(viewWidth/2, viewHeight-40, viewWidth/2, 40);
        _sureBut.backgroundColor = [UIColor whiteColor];
        [_sureBut setTitleColor:[UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_sureBut setTitle:@"提交" forState:UIControlStateNormal];
        _sureBut.titleLabel.font = [UIFont systemFontOfSize:15];
        _sureBut.layer.borderWidth = 1.0f;
        _sureBut.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _sureBut;
}

- (UIButton *)cancelBut
{
    if (!_cancelBut) {
        _cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBut.frame = CGRectMake(0, viewHeight-40, viewWidth/2, 40);
        _cancelBut.backgroundColor = [UIColor whiteColor];
        [_cancelBut setTitleColor:[UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancelBut setTitle:@"不打卡" forState:UIControlStateNormal];
        _cancelBut.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelBut.layer.borderWidth = 1.0f;
        _cancelBut.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _cancelBut;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.finaStr = @"";
    
    // 标题
    [self addSubview:self.titleLabel];
    // 时间
    [self addSubview:self.recordTimeLabel];
    // 时间参数
    [self addSubview:self.timeLabel];
    // 地址
    [self addSubview:self.recordAddressLabel];
    // 地址参数
    if (self.addressLabel.text) {
        CGSize titleSize = [self.addressLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
        if (titleSize.width > (viewWidth-60)) {
            int i = titleSize.width/(viewWidth-60);
            self.addressLabel.frame = CGRectMake(80, 80, viewWidth-80, 20*(i+1));
        }else {
            self.addressLabel.frame = CGRectMake(80, 80, viewWidth-80, 20);
        }
        [self addSubview:self.addressLabel];
        self.height = self.addressLabel.bounds.size.height;
    }
    // 图片
    [self addSubview:self.cameraImage];
    // 按钮
    [self addSubview:self.sureBut];
    [self addSubview:self.cancelBut];
    // 打卡内容
    [self addSubview:self.content];
    // 增加隐藏键盘的按钮
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
// 内容delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = [NSString stringWithFormat:@"%@",self.finaStr];
    textView.alpha = 1.0;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.finaStr = textView.text;
    [self.passNoteDelegate passNotesFromRecordView:self.finaStr];
}

- (void)cancelInput:(UIButton *)but
{
    [self.content resignFirstResponder];
}

// 调用系统相机 (模拟器不支持)
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 设置照片来源为相机
        self.imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        self.imagePick.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 展示选取照片控制器
        [self.passImagePickdelegate passImagePickFromRecordView:self.imagePick];
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
            [self.passImageNewsDelegate passPostImageNewsFromRecordView:responseObject[@"result"] andSuccess:YES];
        }
        [self.passImageNewsDelegate passPostImageNewsFromRecordView:nil andSuccess:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.passImageNewsDelegate passPostImageNewsFromRecordView:nil andSuccess:NO];
    }];
}

@end
