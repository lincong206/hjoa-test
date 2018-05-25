//
//  DocDownCell.m
//  hjoa
//
//  Created by 华剑 on 2017/12/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "DocDownCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "CLAmplifyView.h"

@interface DocDownCell () <NSURLConnectionDataDelegate, NSURLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate>

{
    BOOL _isFinish;  // 是否下载完成
    NSString *_downPath; // 下载路径
    NSString *_docName;    // 文件名字
    NSString *_docUrl;  // 下载地址
    NSString *_newPath; // 新路径
    NSString *_endName; // 文件类型
}

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UIButton *downBut;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) NSString *cashes; // 文件路径
@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;

@end

@implementation DocDownCell

- (void)refreshDownDocWithModel:(DocTypeModel *)model
{
    self.status.text = model.rfStatus;
    self.day.text = [model.rfCreattime componentsSeparatedByString:@" "].firstObject;
    if ([model.rfDescribe isEqualToString:@""]) {
        self.name.text = model.rfOthers;
    }else {
        self.name.text = model.rfDescribe;
    }
    
    // 下载
    if (model.cmAttachmentInformation == nil) {
        self.image.hidden = YES;
        self.downBut.hidden = YES;
        self.size.text = @"";
    }else {
        self.image.hidden = NO;
        self.downBut.hidden = NO;
        self.size.text = model.cmAttachmentInformation[@"baiSize"];
        _docName = model.cmAttachmentInformation[@"baiName"];
        _endName = [_docName componentsSeparatedByString:@"."].lastObject;
        if ([_endName isEqualToString:@"docx"] || [_endName isEqualToString:@"doc"]) {
            self.image.image = [UIImage imageNamed:@"comwork_word"];
        }else if ([_endName isEqualToString:@"xls"] || [_endName isEqualToString:@"xlsx"]) {
            self.image.image = [UIImage imageNamed:@"comwork_excel"];
        }else if ([_endName isEqualToString:@"pptx"] || [_endName isEqualToString:@"ppt"]) {
            self.image.image = [UIImage imageNamed:@"comwork_ppt"];
        }else if ([_endName isEqualToString:@"txt"]) {
            self.image.image = [UIImage imageNamed:@"comwork_txt"];
        }else if ([_endName isEqualToString:@"png"] || [_endName isEqualToString:@"jpg"] || [_endName isEqualToString:@"jpeg"] || [_endName isEqualToString:@"PNG"] || [_endName isEqualToString:@"JPG"] || [_endName isEqualToString:@"JPEG"]) {
            self.image.image = [UIImage imageNamed:@"comwork_img"];
        }else if ([_endName isEqualToString:@"mp3"]) {
            self.image.image = [UIImage imageNamed:@"comwork_music"];
        }else if ([_endName isEqualToString:@"pdf"]) {
            self.image.image = [UIImage imageNamed:@"comwork_pdf"];
        }else if ([_endName isEqualToString:@"rmvb"] || [_endName isEqualToString:@"mp4"] || [_endName isEqualToString:@"avi"]) {
            self.image.image = [UIImage imageNamed:@"comwork_video"];
        }else if ([_endName isEqualToString:@"zip"] || [_endName isEqualToString:@"rar"]) {
            self.image.image = [UIImage imageNamed:@"comwork_ys"];
        }else {
            self.image.image = [UIImage imageNamed:@"comwork_other"];
        }
        
        _docUrl = [NSString stringWithFormat:@"%@/%@",intranetURL,model.cmAttachmentInformation[@"baiUrl"]];
        // 检查文件是否已经被下载
        _downPath = [[[[NSHomeDirectory()
                        stringByAppendingPathComponent:@"Library"]
                       stringByAppendingPathComponent:@"Caches"]
                      stringByAppendingPathComponent:self.type]
                     stringByAppendingPathComponent:_docName];
        _isFinish = [[NSFileManager defaultManager] fileExistsAtPath:_downPath];
        
        if (_isFinish) {
            [_downBut setTitle:@"打 开" forState:UIControlStateNormal];
            // 显示图片
            if ([_endName isEqualToString:@"png"] || [_endName isEqualToString:@"jpg"] || [_endName isEqualToString:@"jpeg"] || [_endName isEqualToString:@"PNG"] || [_endName isEqualToString:@"JPG"] || [_endName isEqualToString:@"JPEG"]) {
                [self.image sd_setImageWithURL:[NSURL fileURLWithPath:_downPath]];
            }
        }else {
            [_downBut setTitle:@"下 载" forState:UIControlStateNormal];
        }
        [_downBut.layer setMasksToBounds:YES];
        [_downBut.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [_downBut.layer setBorderWidth:1.5]; //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 14/255.0, 100/255.0, 255/255.0, 1 });
        [_downBut.layer setBorderColor:colorref];//边框颜色
        [_downBut setTitleColor:[UIColor colorWithRed:14/255.0 green:100/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];//title color
        _downBut.backgroundColor = [UIColor whiteColor];
        [_downBut addTarget:self action:@selector(clickDownBut:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)clickDownBut:(UIButton *)sender
{
    if (_isFinish) {
        if ([_endName isEqualToString:@"docx"] || [_endName isEqualToString:@"doc"] || [_endName isEqualToString:@"xls"] || [_endName isEqualToString:@"xlsx"] || [_endName isEqualToString:@"pptx"] || [_endName isEqualToString:@"ppt"] || [_endName isEqualToString:@"txt"] || [_endName isEqualToString:@"pdf"] || [_endName isEqualToString:@"zip"] || [_endName isEqualToString:@"rar"]) {
            // 文档类型 都用第三方软件打开 如WPS
            [self OpenDucumentFromThridApplication];
        }else if ([_endName isEqualToString:@"png"] || [_endName isEqualToString:@"jpg"] || [_endName isEqualToString:@"jpeg"] || [_endName isEqualToString:@"PNG"] || [_endName isEqualToString:@"JPG"] || [_endName isEqualToString:@"JPEG"]) {
            // 如果是图片类型 点击放大
            CLAmplifyView *amplifyView = [[CLAmplifyView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight) andCustomView:self.image andSuperView:nil];
            [[UIApplication sharedApplication].keyWindow addSubview:amplifyView];
        }
    }else {
        _docUrl = [_docUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:_docUrl];
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession* session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        // 创建任务
        NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithURL:url];
        // 开始任务
        [downloadTask resume];
    }
}

// 下载完调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    self.cashes = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *fmr = [NSFileManager defaultManager];
    // 文件类型
    if (self.type) {
        NSString *directryPath = [self.cashes stringByAppendingPathComponent:self.type];
        [fmr createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
        _newPath = [directryPath stringByAppendingPathComponent:_docName];
        [fmr moveItemAtPath:location.path toPath:_newPath error:nil];
    }
    [_downBut setTitle:@"打 开" forState:UIControlStateNormal];
    _isFinish = YES;
    
    if ([_endName isEqualToString:@"png"] || [_endName isEqualToString:@"jpg"] || [_endName isEqualToString:@"jpeg"] || [_endName isEqualToString:@"PNG"] || [_endName isEqualToString:@"JPG"] || [_endName isEqualToString:@"JPEG"]) {
        if (self.type) {
            _downPath = [[[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"]
                               stringByAppendingPathComponent:@"Caches"]
                              stringByAppendingPathComponent:self.type]
                             stringByAppendingPathComponent:_docName];
        }
        [self.image sd_setImageWithURL:[NSURL fileURLWithPath:_downPath]];
        self.image.userInteractionEnabled = YES;
        self.image.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
        [self.image addGestureRecognizer:tap];
    }
}

- (void)clickTap:(UITapGestureRecognizer *)tap
{
    CLAmplifyView *amplifyView = [[CLAmplifyView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight) andGesture:tap andSuperView:self.image];
    [[UIApplication sharedApplication].keyWindow addSubview:amplifyView];
}

- (void)OpenDucumentFromThridApplication
{
    //url 为需要调用第三方打开的文件地址
    _downPath = [[[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"]
                           stringByAppendingPathComponent:@"Caches"]
                          stringByAppendingPathComponent:self.type]
                         stringByAppendingPathComponent:_docName];
    NSURL *url = [NSURL fileURLWithPath:_downPath];
    _documentInteractionController = [UIDocumentInteractionController
                                      interactionControllerWithURL:url];
    [_documentInteractionController setDelegate:self];
//    _documentInteractionController.UTI = @"com.microsoft.word.doc";
    [_documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.contentView animated:YES];
}

@end
