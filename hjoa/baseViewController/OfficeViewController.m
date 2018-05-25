//
//  OfficeViewController.m
//  hjoa
//
//  Created by 华剑 on 2017/3/15.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "OfficeViewController.h"
#import "OfficeCell.h"
#import "addressModel.h"
#import "Header.h"
#import "AFNetworking.h"
#import "OfficeHeaderView.h"
#import "ScheduleModel.h"

#import "NewRecordViewController.h" // 考勤
#import "ApproveViewController.h"   // 审批
#import "ScheduleViewController.h"  // 制度
#import "BusinessNewsViewController.h"  // 企业要闻
#import "LeaveViewController.h"     // 请假
#import "YBBXViewController.h"      // 一般报销
#import "WeeklyViewController.h"    // 周报
#import "CostProjectViewController.h"   // 费用报销
#import "RecordsCountViewController.h"  // 项目管控
#import "ChuChaiViewController.h"   // 出差
#import "CheckReportViewController.h"    // 检查报告
#import "DocManagerViewController.h"    // 文档管理
#import "QualityCheckViewController.h"  // 指令检查

@interface OfficeViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *officeCollection;
@property (strong, nonatomic) NSMutableArray *officeData;

@property (strong, nonatomic) NSArray *labelArr;
@property (strong, nonatomic) NSArray *ybArr;
@property (strong, nonatomic) NSArray *xzrsArr;
@property (strong, nonatomic) NSArray *xmArr;
@property (strong, nonatomic) NSArray *zhbgArr;
@property (strong, nonatomic) NSArray *gcArr;
@property (strong, nonatomic) NSArray *other;
@property (strong, nonatomic) NSArray *nameArr;
@property (assign, nonatomic) BOOL isClick;
@property (assign, nonatomic) NSInteger section;
@end

@implementation OfficeViewController

- (NSMutableArray *)officeData
{
    if (!_officeData) {
        _officeData = [NSMutableArray array];
    }
    return _officeData;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addDataFromlocal];
    
}

// 给本地赋值
- (void)addDataFromlocal
{
    self.labelArr = @[@"管理",@"内外勤管理",@"财务管理",@"业务汇报"];
    
    self.other = @[@"审批",@"我的申请",@"企业要闻",@"制度管理"];//,@"文档管理"];//,@"组织架构"];
    self.ybArr = @[@"请假",@"出差"];
    self.xmArr = @[@"一般报销",@"项目报销"];//,@"项目管控"];
    self.xzrsArr = @[@"我的汇报",@"检查报告",@"质量检查"];//,@"移动考勤"];
    
    self.nameArr = [NSArray arrayWithObjects:self.other,self.ybArr,self.xmArr,self.xzrsArr, nil];
    
    for (int i = 0; i < self.labelArr.count; i ++) {
        ScheduleModel *model = [[ScheduleModel alloc] init];
        model.title = self.labelArr[i];
        model.arr = self.nameArr[i];
        [self.officeData addObject:model];
    }
    self.isClick = false;
}

#pragma mark--collection delegate--
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.officeData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.officeData[section] arr] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OfficeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OfficeCell" forIndexPath:indexPath];
    cell.nameLabel.text = [self.officeData[indexPath.section] arr][indexPath.row];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"work_%ld_%ld",(long)indexPath.section,(long)indexPath.row]];
    return cell;
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    OfficeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.backgroundColor = [UIColor whiteColor];
    ScheduleModel *model = self.officeData[indexPath.section];
    header.name.text = model.title;
//    header.but.tag = indexPath.section + 100;
//    header.but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [header.but addTarget:self action:@selector(putSectionCell:) forControlEvents:UIControlEventTouchUpInside];
//    // 隐藏个数少于4个
//    if (indexPath.section == 2 || indexPath.section == 4) {
//        header.but.hidden = YES;
//    }else {
//        header.but.hidden = NO;
//    }
//    [header.but setTitle:@"收起" forState:UIControlStateNormal];
    return header;
}

#pragma mark---collection Cell 收起和展示----
- (void)putSectionCell:(UIButton *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:sender.tag - 100];
    ScheduleModel *model = self.officeData[indexPath.section];
    
//    if (model.arr.count > 4) {
//        self.isClick = false;
//        model.arr = [model.arr subarrayWithRange:NSMakeRange(0, 4)];
//        [self.officeCollection reloadData];
//    }else {
//        self.isClick = true;
//        model.arr = self.nameArr[indexPath.section];
//        [self.officeCollection reloadData];
//    }
    //  点击改变文字BUG
    switch (sender.tag - 100) {
        case 0:
            if (model.arr.count > 4) {
                [sender setTitle:@"展开" forState:UIControlStateNormal];
                model.arr = [model.arr subarrayWithRange:NSMakeRange(0, 4)];
                [self.officeCollection reloadData];
            }else {
                [sender setTitle:@"收起" forState:UIControlStateNormal];
                model.arr = self.nameArr[indexPath.section];
                [self.officeCollection reloadData];
            }
            break;
        case 1:
            if (model.arr.count > 4) {
                [sender setTitle:@"展开" forState:UIControlStateNormal];
                model.arr = [model.arr subarrayWithRange:NSMakeRange(0, 4)];
                [self.officeCollection reloadData];
            }else {
                [sender setTitle:@"收起" forState:UIControlStateNormal];
                model.arr = self.nameArr[indexPath.section];
                [self.officeCollection reloadData];
            }
            break;
        case 3:
            if (model.arr.count > 4) {
                [sender setTitle:@"展开" forState:UIControlStateNormal];
                model.arr = [model.arr subarrayWithRange:NSMakeRange(0, 4)];
                [self.officeCollection reloadData];
            }else {
                [sender setTitle:@"收起" forState:UIControlStateNormal];
                model.arr = self.nameArr[indexPath.section];
                [self.officeCollection reloadData];
            }
            break;
        case 5:
            if (model.arr.count > 4) {
                [sender setTitle:@"展开" forState:UIControlStateNormal];
                model.arr = [model.arr subarrayWithRange:NSMakeRange(0, 4)];
                [self.officeCollection reloadData];
            }else {
                [sender setTitle:@"收起" forState:UIControlStateNormal];
                model.arr = self.nameArr[indexPath.section];
                [self.officeCollection reloadData];
            }
            break;
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",[self.officeData[indexPath.section] arr][indexPath.row]);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //  第一段
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //  审批
            ApproveViewController *apvc = [sb instantiateViewControllerWithIdentifier:@"ApproveVC"];
            apvc.title = [self.officeData[indexPath.section] arr][indexPath.row];
            apvc.url = approveListURL;
            apvc.isApprove = true;
            [self.navigationController pushViewController:apvc animated:YES];
        }else if (indexPath.row == 1) {
            //  我的申请
            ApproveViewController *apvc = [sb instantiateViewControllerWithIdentifier:@"ApproveVC"];
            apvc.title = [self.officeData[indexPath.section] arr][indexPath.row];
            apvc.url = myApproveURL;
            apvc.isApprove = false;
            [self.navigationController pushViewController:apvc animated:YES];
            
        }else if (indexPath.row == 2) {
            //  企业要闻
            BusinessNewsViewController *bnVC = [sb instantiateViewControllerWithIdentifier:@"bnVC"];
            bnVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:bnVC animated:YES];
            
        }else if (indexPath.row == 3) {
            //  制度管理
            ScheduleViewController *scheduleVC = [sb instantiateViewControllerWithIdentifier:@"scheduleVC"];
            scheduleVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:scheduleVC animated:YES];
            
        }else if (indexPath.row == 4) {
            //  组织架构
            DocManagerViewController *docVC = [sb instantiateViewControllerWithIdentifier:@"docManagerVC"];
            docVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:docVC animated:YES];
            
        }
    //  第二段
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            // 请假申请
            LeaveViewController *leave = [sb instantiateViewControllerWithIdentifier:@"leaveVC"];
            leave.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:leave animated:YES];
            
        }else if (indexPath.row == 1) {
            // 出差
            ChuChaiViewController *chuchaiVC = [sb instantiateViewControllerWithIdentifier:@"chuchaiVC"];
            chuchaiVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:chuchaiVC animated:YES];
        }
    // 第三段
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            // 一般报销
            YBBXViewController *ybbx = [sb instantiateViewControllerWithIdentifier:@"ybbxVC"];
            ybbx.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:ybbx animated:YES];
            
        }else if (indexPath.row == 1) {
            // 项目费用报销
            CostProjectViewController *costVC = [sb instantiateViewControllerWithIdentifier:@"costPjtVC"];
            costVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:costVC animated:YES];
            
        }else if (indexPath.row == 2) {
            // 项目管控
            RecordsCountViewController *count = [sb instantiateViewControllerWithIdentifier:@"rCountVC"];
            count.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:count animated:YES];
        }
    // 第四段
    }else if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            //  我的周报
            WeeklyViewController *weeklyVC = [sb instantiateViewControllerWithIdentifier:@"weeklyVC"];
            weeklyVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:weeklyVC animated:YES];
            
        }else if (indexPath.row == 1) {
            // 检查报告
            CheckReportViewController *crVC = [sb instantiateViewControllerWithIdentifier:@"checkReportVC"];
            crVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:crVC animated:YES];

        }else if (indexPath.row == 2) {
            //  质量检查
            QualityCheckViewController *qcVC = [sb instantiateViewControllerWithIdentifier:@"qcVC"];
            qcVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:qcVC animated:YES];
        }else if (indexPath.row == 3) {
            //  新移动考勤 弃用
            NewRecordViewController *nrVC = [sb instantiateViewControllerWithIdentifier:@"nrVC"];
            nrVC.title = [self.officeData[indexPath.section] arr][indexPath.row];
            [self.navigationController pushViewController:nrVC animated:YES];
        }
    }
//    if (indexPath.row == 2)
//    {
//        // 公文申请界面
////        DocumentDetailsViewController *ddVC = [sb instantiateViewControllerWithIdentifier:@"ddVC"];
////        ddVC.title = [self.officeData[indexPath.row] uiName];
////        [self.navigationController pushViewController:ddVC animated:YES];
    
}

@end
