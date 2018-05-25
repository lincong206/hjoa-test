//
//  ApprovalOpinionsViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/7/5.
//  Copyright © 2017年 huajian. All rights reserved.
//
//  审批意见填写和提交

#import "ApprovalOpinionsViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "ApproveViewController.h"

@interface ApprovalOpinionsViewController () <UITextViewDelegate>

@property (strong, nonatomic) NSString *finaStr;

@property (assign, nonatomic) NSInteger butStatus;

@end

@implementation ApprovalOpinionsViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        self.title = @"审批意见";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBut)];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBut)];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)clickLeftBut
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.finaStr = @"";
    
    _inputText = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, kscreenWidth - 10, 300)];
    _inputText.backgroundColor = [UIColor whiteColor];
    _inputText.layer.borderColor = [UIColor whiteColor].CGColor;
    _inputText.textAlignment = NSTextAlignmentLeft;
    _inputText.alpha = 0.5;
    _inputText.font = [UIFont systemFontOfSize:15];
    _inputText.delegate = self;
    
    [self.view addSubview:_inputText];
    
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTag)];
    [self.view addGestureRecognizer:tag];
    
}

- (void)clickTag
{
    [self.view endEditing:YES];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = [NSString stringWithFormat:@"%@",self.finaStr];
    textView.alpha = 1.0;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.finaStr = textView.text;
}

- (void)clickRightBut
{
    [self.view endEditing:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uiId = [user objectForKey:@"uiId"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([self.butName isEqualToString:@"延审"]) {
        self.butStatus = 4;
        [params setObject:self.Omodel.asrSort forKey:@"asrSort"];
        [params setObject:self.Omodel.asrId forKey:@"asrId"];
        [params setObject:self.Omodel.asrName forKey:@"asrName"];
        [params setObject:self.Omodel.astId forKey:@"astId"];
        // 传实际审批人
        [params setObject:self.Omodel.uiId forKey:@"uiId"];
        [params setObject:self.Omodel.astCreatetime forKey:@"arvReceivetime"];
        [params setObject:@"iOS"forKey:@"arvTerrace"];
        [params setObject:self.finaStr forKey:@"arvRemark"];
        [params setObject:uiId forKey:@"userId"];
    }else {
        // 延审按钮之外的数据结构
        [params setObject:self.Omodel.arvId forKey:@"arvId"];
        [params setObject:self.Omodel.uiId forKey:@"uiId"];
        
        NSMutableDictionary *stepreceive = [NSMutableDictionary dictionary];
        [stepreceive setObject:self.Omodel.asrId forKey:@"asrId"];
        [stepreceive setObject:self.Omodel.astId forKey:@"astId"];
        [stepreceive setObject:self.Omodel.asrSort forKey:@"asrSort"];
        [stepreceive setObject:self.Omodel.asrApprovaltype forKey:@"asrApprovaltype"];
        
        NSMutableDictionary *receive = [NSMutableDictionary dictionary];
        
        if (self.finaStr == nil || [self.inputText.text isEqualToString:@"请输入审批意见(非必填)"] || [self.finaStr isEqualToString:@""] || [self.inputText.text isEqualToString:@""]) {
            // 当输入框中没有文字数据时，提交默认文字数据    (用户直接点击提交) (用户先点击输入框，但是没有内容)
            if ([self.butName isEqualToString:@"通过"]) {
                // 通过
                self.butStatus = 1;
                [receive setObject:self.butName forKey:@"arvRemark"];  // 传状态
                [receive setObject:@"2" forKey:@"arvStatus"];  // 传状态对应的数字编码
                [receive setObject:uiId forKey:@"uiSid"];  // 传当前用户id
                [receive setObject:@"iOS" forKey:@"arvTerrace"];
            }else if ([self.butName isEqualToString:@"不通过"]) {
                // 不通过
                self.butStatus = 2;
                [receive setObject:self.butName forKey:@"arvRemark"];  // 传状态
                [receive setObject:@"4" forKey:@"arvStatus"];  // 传状态对应的数字编码
                [receive setObject:uiId forKey:@"uiSid"];  // 传当前用户id
                [receive setObject:@"iOS" forKey:@"arvTerrace"];
            }else if ([self.butName isEqualToString:@"重新起草"]) {
                // 重新起草
                self.butStatus = 3;
                [receive setObject:self.butName forKey:@"arvRemark"];  // 传状态
                [receive setObject:@"6" forKey:@"arvStatus"];  // 传状态对应的数字编码
                [receive setObject:uiId forKey:@"uiSid"];  // 传当前用户id
                [receive setObject:@"iOS" forKey:@"arvTerrace"];
            }
        }else {
            // 当输入框中有文字数据时，提交文字数据
            if ([self.butName isEqualToString:@"通过"]) {
                // 通过
                self.butStatus = 1;
                [receive setObject:self.finaStr forKey:@"arvRemark"];  // 传状态
                [receive setObject:@"2" forKey:@"arvStatus"];  // 传状态对应的数字编码
                [receive setObject:uiId forKey:@"uiSid"];  // 传当前用户id
                [receive setObject:@"iOS" forKey:@"arvTerrace"];
            }else if ([self.butName isEqualToString:@"不通过"]) {
                // 不通过
                self.butStatus = 2;
                [receive setObject:self.finaStr forKey:@"arvRemark"];  // 传状态
                [receive setObject:@"4" forKey:@"arvStatus"];  // 传状态对应的数字编码
                [receive setObject:uiId forKey:@"uiSid"];  // 传当前用户id
                [receive setObject:@"iOS" forKey:@"arvTerrace"];
            }else if ([self.butName isEqualToString:@"重新起草"]) {
                // 重新起草
                self.butStatus = 3;
                [receive setObject:self.finaStr forKey:@"arvRemark"];  // 传状态
                [receive setObject:@"6" forKey:@"arvStatus"];  // 传状态对应的数字编码
                [receive setObject:uiId forKey:@"uiSid"];  // 传当前用户id
                [receive setObject:@"iOS" forKey:@"arvTerrace"];
            }
        }
        [params setObject:stepreceive forKey:@"apApprovalstepreceive"];
        [params setObject:receive forKey:@"apApprovalreceive"];
    }
    //    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    // 需要将里面两个字典转成json形式
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *paramsD = [NSMutableDictionary dictionary];
    [paramsD setObject:paramsStr forKey:@"params"];
    
    if (![self.butName isEqualToString:@"延审"]) {
        [self postApproveStatus:postApproveButStatus andParameters:paramsD];
    }else if ([self.finaStr isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请输入延审理由" andTitle:@"提示"];
    }else {
        [self postApproveStatus:postLateApproveButStatus andParameters:paramsD];
    }
}

- (void)postApproveStatus:(NSString *)url andParameters:(NSMutableDictionary *)params
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            [self.refreCellDelegate refreApproveCellStatus:self.butStatus];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"提交失败，请稍后再提交" andTitle:@"提示"];
        }
    }];
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}



@end
