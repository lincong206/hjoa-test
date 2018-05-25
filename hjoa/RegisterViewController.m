//
//  RegisterViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/10/23.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "Header.h"
@interface RegisterViewController () <UITextFieldDelegate>

{
    NSInteger _sex;
}

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *pw;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [self.view addGestureRecognizer:tap];
}
// 收起键盘
- (void)clickTap
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
// 开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
// 结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
// 创建
- (IBAction)registeBut:(id)sender {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if ([self.name.text isEqualToString:@""] || [self.account.text isEqualToString:@""] || [self.password.text isEqualToString:@""] || [self.phone.text isEqualToString:@""]) {
        [self showAlertControllerMessage:@"请填写必填内容" andTitle:@"提示" andIsReturn:NO];
    }else {
        
        if (![self.password.text isEqualToString:self.pw.text]) {
            [self showAlertControllerMessage:@"请确认两次密码输入相同" andTitle:@"提示" andIsReturn:NO];
        }else {
        
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            
            [parameters setObject:self.name.text forKey:@"uiName"];
            [parameters setObject:self.account.text forKey:@"uiAccount"];
            [parameters setObject:self.password.text forKey:@"uiPassword"];
            [parameters setObject:[NSString stringWithFormat:@"%ld",(long)_sex] forKey:@"uiSex"];
            [parameters setObject:self.phone.text forKey:@"uiMobile"];
            [parameters setObject:@"55" forKey:@"psId"];
            [parameters setObject:@"1" forKey:@"uiIsleader"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:[NSDate date]];
            [parameters setObject:dateTime forKey:@"uiCreatetime"];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSMutableArray *arr1 = [NSMutableArray array];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"" forKey:@"ueStarttime"];
            [dic setObject:@"" forKey:@"ueEndtime"];
            [dic setObject:@"" forKey:@"ueSchoolname"];
            [dic setObject:@"2" forKey:@"ueIsstudy"];
            [dic setObject:@"" forKey:@"ueEducation"];
            [dic setObject:@"" forKey:@"ueMajor"];
            [dic setObject:@"" forKey:@"ueCertificate"];
            [dic setObject:@"" forKey:@"ueProfessionalcertificate"];
            [arr1 addObject:dic];
            [params setObject:arr1 forKey:@"jiaoyu"];
            
            NSMutableArray *arr2 = [NSMutableArray array];
            [params setObject:arr2 forKey:@"gongzuo"];
            
            NSMutableArray *arr3 = [NSMutableArray array];
            [params setObject:arr3 forKey:@"peixun"];
            
            [params setObject:@"add" forKey:@"statu"];
            // 字典转data
            NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
            NSString *paramsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [parameters setObject:paramsStr forKey:@"params"];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            NSString *creatUrl = [NSString stringWithFormat:@"%@/paUserInfo/save",intranetURL];
            [manager POST:creatUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self.passDelegate passAccount:self.account.text andPW:self.password.text];
                [self showAlertControllerMessage:@"创建成功" andTitle:@"提示" andIsReturn:YES];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    [self showAlertControllerMessage:@"创建失败" andTitle:@"提示" andIsReturn:NO];
                }
            }];
        }
    }
}
// 选择
- (IBAction)clickSeg:(id)sender {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    _sex = [sender selectedSegmentIndex];
}

- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsReturn:(BOOL)isR;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isR) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
