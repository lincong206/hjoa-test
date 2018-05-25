//
//  ReplyQRButViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/4/18.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  整改按钮or复检按钮 回复消息页面

#import "ReplyQRButViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import <Photos/Photos.h>
#import "QCDetailsCell.h"
#import "QCResultStringCell.h"
#import "LeavePhotoCell.h"
#import "NowPhotosCell.h"
#import "PhotosModel.h"
#import "PhotosViewController.h"
#import "ApproveEnclosureModel.h"
#import "ReplyButCell.h"

#import "QualityCheckListViewController.h"

@interface ReplyQRButViewController () <UITableViewDelegate, UITableViewDataSource, passQCResultStringCellText, passSelectPhotos, passButTag>
{
    BOOL _isFJ;
    NSInteger _shang;
    NSString *_tag;
    NSString *_replyContent;
    NSString *_imageId;
    NSString *_time;
}
@property (strong, nonatomic) UITableView *replyTable;
@property (strong, nonatomic) NSMutableArray *nowPhotos;

@property (strong, nonatomic) NSDateFormatter *formatter;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation ReplyQRButViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSDateFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
    }
    return _formatter;
}

- (NSMutableArray *)nowPhotos
{
    if (!_nowPhotos) {
        _nowPhotos = [NSMutableArray array];
    }
    return _nowPhotos;
}

- (UITableView *)replyTable
{
    if (!_replyTable) {
        _replyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight-50) style:UITableViewStylePlain];
        _replyTable.backgroundColor = [UIColor whiteColor];
        _replyTable.delegate = self;
        _replyTable.dataSource = self;
        _replyTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    }
    return _replyTable;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(FinishClick:)];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)FinishClick:(UIButton *)but
{
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    [self.formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    _time = [self.formatter stringFromDate:[NSDate date]];
    
    if (_isFJ) {    // 复检回复
        if (_replyContent) {
            [paras setValue:_replyContent forKey:@"brrRecheckcontent"];
        }
        if (_tag) {
            [paras setValue:_tag forKey:@"brrResultstatus"];
        }
        [paras setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"brrRecheckuiid"];
        if (self.bqiId) {
            [paras setValue:self.bqiId forKey:@"bqiId"];
        }
        if (self.brrId) {
            [paras setValue:self.brrId forKey:@"brrId"];
        }else {
            [paras setValue:@"" forKey:@"brrId"];
        }
        [paras setValue:_time forKey:@"brrRechecktime"];
        // 上传提交
        if ([_replyContent isEqualToString:@""] || _replyContent == nil || [_tag isEqualToString:@""] || _tag == nil) {
            [self showAlertControllerMessage:@"请填写回复信息" andTitle:@"提示" andIsReturn:NO];
        }else {
            [self.manager POST:qcRelpyUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"%@",responseObject);
                if ([responseObject[@"status"] isEqualToString:@"success"]) {
                    if (_tag.integerValue == 1) {
                         [self.passZGFJStatusDelegate passZGFJStatusWithRQRButVC:@"FJsuccess"];
                    }else {
                         [self.passZGFJStatusDelegate passZGFJStatusWithRQRButVC:@"success"];
                    }
                    _imageId = responseObject[@"id"];
                    if (self.nowPhotos.count > 0) {
                        [self upLoadImageWithImageId:_imageId andType:@"FJ"];
                    }else {
                        [self showAlertControllerMessage:@"复检回复成功" andTitle:@"提示" andIsReturn:YES];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    [self showAlertControllerMessage:@"提交失败，请稍后再试" andTitle:@"提示" andIsReturn:NO];
                }
            }];
        }
    }else {         // 整改回复
        if (_replyContent) {
            [paras setValue:_replyContent forKey:@"brrRectificationcontent"];
        }
        [paras setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"brrRectificationuiid"];
        if (self.bqiId) {
            [paras setValue:self.bqiId forKey:@"bqiId"];
        }
        [paras setObject:_time forKey:@"brrRectificationtime"];
        // 上传提交
        if ([_replyContent isEqualToString:@""] || _replyContent == nil) {
            [self showAlertControllerMessage:@"请填写回复信息" andTitle:@"提示" andIsReturn:NO];
        }else {
            [self.manager POST:qcRelpyUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if ([responseObject[@"status"] isEqualToString:@"success"]) {
                    [self.passZGFJStatusDelegate passZGFJStatusWithRQRButVC:@"ZGsuccess"];
                    _imageId = responseObject[@"id"];
                    // 判断有没有附件需要上传
                    if (self.nowPhotos.count > 0) {
                        [self upLoadImageWithImageId:_imageId andType:@"ZG"];
                    }else {
                        [self showAlertControllerMessage:@"整改回复成功" andTitle:@"提示" andIsReturn:YES];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    [self showAlertControllerMessage:@"提交失败，请稍后再试" andTitle:@"提示" andIsReturn:NO];
                }
            }];
        }
    }
}

- (void)upLoadImageWithImageId:(NSString *)imageId andType:(NSString *)type
{
    NSString *fileString = @"";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    if (self.nowPhotos.count != 0) {        // 上传图片信息
        for (ApproveEnclosureModel *model in self.nowPhotos) {
            NSMutableDictionary *photos = [NSMutableDictionary dictionary];
            [photos setObject:model.baiName forKey:@"baiName"];
            [photos setObject:@"" forKey:@"baiState"];
            [photos setObject:model.baiSize forKey:@"baiSize"];
            // 上传成功时，返回的id
            [photos setObject:imageId forKey:@"piId"];
            [photos setObject:type forKey:@"piType"];
            [photos setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uiId"] forKey:@"uiId"];
            [photos setObject:model.baiSubsequent forKey:@"baiSubsequent"];
            [photos setObject:model.baiUrl forKey:@"baiUrl"];
            fileString = [NSString stringWithFormat:@"%@%@!",fileString,photos];
            
            fileString = [fileString stringByReplacingOccurrencesOfString:@"=" withString:@":"];
            fileString = [fileString stringByReplacingOccurrencesOfString:@";" withString:@","];
            NSString *lastString = [fileString substringToIndex:fileString.length-4];
            fileString = [NSString stringWithFormat:@"%@}!",lastString];
        }
    }
    [paras setValue:fileString forKey:@"params"];

    [self.manager POST:qcUploadImage parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"success"]) {
            if ([type isEqualToString:@"ZG"]) {
                [self showAlertControllerMessage:@"整改回复成功" andTitle:@"提示" andIsReturn:YES];
            }else {
                [self showAlertControllerMessage:@"复检回复成功" andTitle:@"提示" andIsReturn:YES];
            }
        }else {
            [self showAlertControllerMessage:@"提交失败，请稍后再试" andTitle:@"提示" andIsReturn:NO];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self showAlertControllerMessage:@"提交失败，请稍后再试" andTitle:@"提示" andIsReturn:NO];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if ([self.title isEqualToString:@"整改回复"]) {
        _isFJ = false;
    }else {
        _isFJ = true;
    }
    
    [self.view addSubview:self.replyTable];
    
    [self registCell];
}

- (void)registCell
{
    [self.replyTable registerNib:[UINib nibWithNibName:@"QCDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcDetailsCell"];
    [self.replyTable registerNib:[UINib nibWithNibName:@"QCResultStringCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcRStingCell"];
    [self.replyTable registerNib:[UINib nibWithNibName:@"LeavePhotoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"lphotoCell"];
    [self.replyTable registerNib:[UINib nibWithNibName:@"NowPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nowPhotosCell"];
    [self.replyTable registerNib:[UINib nibWithNibName:@"ReplyButCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"replyButCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isFJ) {
        return 3;
    }else {
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else {
        return 5;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            QCDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcDetailsCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_isFJ) {
                cell.title.text = @"复检人:";
            }else {
                cell.title.text = @"整改人:";
            }
            cell.icon.image = [UIImage imageNamed:@"qc_person"];
            cell.content.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"uiName"];
            return cell;
        }else {
            QCResultStringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcRStingCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.input.text = @"请输入回复内容...";
            cell.passTextDelegate = self;
            return cell;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = @"上传附件";
            cell.image.hidden = YES;
            return cell;
        }else {
            NowPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nowPhotosCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.nowPhotos.count) {
                [cell loadNowPhotosFromData:self.nowPhotos];
            }
            return cell;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            LeavePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lphotoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title.text = @"复检结果";
            cell.image.hidden = YES;
            return cell;
        }else {
            ReplyButCell *cell = [tableView dequeueReusableCellWithIdentifier:@"replyButCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            [cell addButName:@[@"通过",@"不通过"]];
            cell.passTagDelegate = self;
            return cell;
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44;
        }else {
            return 120;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 44;
        }else {
            return _shang*((kscreenWidth-40)/3) + (_shang * 10);
        }
    }else {
        if (indexPath.row == 0) {
            return 44;
        }else {
            return 100;
        }
    }
}

// 点击复检
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self creatAlertController];
        }
    }
}

#pragma mark --文字输入--
- (void)passTextFromQCResultStringCell:(NSString *)text
{
    _replyContent = text;
}
#pragma mark --通过不通过按钮--
- (void)passButTag:(NSInteger)tag
{
    _tag = [NSString stringWithFormat:@"%ld",tag-100];
}

//  通过警告控制器选择  附件从相册选出还是相机相机选出
- (void)creatAlertController
{
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 设置相册警告响应事件
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getOriginalImages];
    }];
    [alert addAction:photosAction];
    [alert addAction:cancelAction];
    // 展示警告控制器
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 *  获得所有相簿的原图
 */
- (void)getOriginalImages
{
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll];
}
/**
 *  遍历相簿中的所有图片
 *
 *  @param assetCollection 相簿
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    PhotosViewController *photosVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"attachmentsVC"];
    photosVC.title = assetCollection.localizedTitle;
    photosVC.passDelegate = self;
    
    for (PHAsset *asset in assets) {
        @autoreleasepool {
            // 从asset中获得图片
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                if (imageData) {
                    PhotosModel *model = [[PhotosModel alloc] init];
                    model.select = NO;
                    model.photosData = imageData;
                    [photosVC.data addObject:model];
                }
            }];
        }
    }
    [self.navigationController pushViewController:photosVC animated:YES];
}
#pragma mark --选择图片passDelegate--
- (void)passSelectPhotosFromPhotosVC:(NSMutableArray *)selectArr
{
    // 删除之前所有图片
    [self.nowPhotos removeAllObjects];
    if (selectArr.count%3 == 0) {
        _shang = selectArr.count/3;
    }else {
        _shang = (NSInteger)(selectArr.count/3) + 1;
    }
    for (UIImage *image in selectArr) {
        [self upLoadImageWith:image];
    }
    [self.replyTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

// 上传图片
- (void)upLoadImageWith:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    if (data) {
        NSString *url = [NSString stringWithFormat:@"%@/uploadFile/saveFile?num=1",intranetURL];
        [self.formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *imageDate = [self.formatter stringFromDate:[NSDate date]];
        
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        [self.manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"files" fileName:[NSString stringWithFormat:@"%@.jpg",imageDate] mimeType:self.title];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            for (NSDictionary *dic in responseObject[@"rows"]) {
                ApproveEnclosureModel *model = [[ApproveEnclosureModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.nowPhotos addObject:model];
            }
            if ([responseObject[@"status"] isEqualToString:@"yes"]) {
                // 刷新
                [self.replyTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self showAlertControllerMessage:@"上传成功" andTitle:@"提示" andIsReturn:NO];
            }else {
                [self showAlertControllerMessage:@"上传失败,网络错误" andTitle:@"提示" andIsReturn:NO];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertControllerMessage:@"上传失败" andTitle:@"提示" andIsReturn:NO];
        }];
    }else {
        [self showAlertControllerMessage:@"上传失败" andTitle:@"提示" andIsReturn:NO];
    }
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 显示
- (void)showAlertControllerMessage:(NSString *) message andTitle:(NSString *)title andIsReturn:(BOOL)isR
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        if (isR) {
            for (UIViewController *vc in self.navigationController.childViewControllers) {
                if ([vc isKindOfClass:[QualityCheckListViewController class]]) {
                    QualityCheckListViewController *qcListVC = (QualityCheckListViewController *)vc;
                    [self.navigationController popToViewController:qcListVC animated:YES];
                }
            }
        }
    }];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}
@end
