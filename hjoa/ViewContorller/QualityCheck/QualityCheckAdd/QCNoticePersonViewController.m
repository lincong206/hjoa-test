//
//  QCNoticePersonViewController.m
//  hjoa
//
//  Created by 华剑 on 2018/3/7.
//  Copyright © 2018年 huajian. All rights reserved.
//
//  检查通知人 (已弃用)

#import "QCNoticePersonViewController.h"
#import "Header.h"
#import "BMChineseSort.h"
#import "DataBaseManager.h"
#import "QCPersonCell.h"
#import "addressModel.h"

@interface QCNoticePersonViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *selectIndexs; //多选选中的行

@property (strong, nonatomic) UITableView *noticeTable;
@property (strong, nonatomic) NSMutableArray *letterResultArr;
@property (strong, nonatomic) NSMutableArray *indexArray;

@property (strong, nonatomic) NSMutableArray *selectMan;
@end

@implementation QCNoticePersonViewController

- (NSMutableArray *)selectMan
{
    if (!_selectMan) {
        _selectMan = [NSMutableArray array];
    }
    return _selectMan;
}

- (NSMutableArray *)letterResultArr
{
    if (!_letterResultArr) {
        _letterResultArr = [NSMutableArray array];
    }
    return _letterResultArr;
}
- (NSMutableArray *)indexArray
{
    if (!_indexArray) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}
- (UITableView *)noticeTable
{
    if (!_noticeTable) {
        _noticeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight - 50) style:UITableViewStylePlain];
        _noticeTable.delegate = self;
        _noticeTable.dataSource = self;
        _noticeTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _noticeTable;
}

- (NSMutableArray *)selectIndexs
{
    if (!_selectIndexs) {
        _selectIndexs = [NSMutableArray array];
    }
    return _selectIndexs;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"通知人";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBut)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)clickRightBut
{
    for (NSIndexPath *index in self.selectIndexs) {
        addressModel *model = self.letterResultArr[index.section] [index.row];
        [self.selectMan addObject:model];
    }
    [self.passPersonDelegate passNoticePersonFromVC:self.selectMan];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self separateDataSource:[[DataBaseManager shareDataBase] searchAllData]];
    
    [self.view addSubview:self.noticeTable];
    
    [self.noticeTable registerNib:[UINib nibWithNibName:@"QCPersonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"qcPersonCell"];
}

//根据Person对象的 name 属性 按中文 对 Person数组 排序
- (void)separateDataSource:(NSMutableArray *)arrM
{
    self.indexArray = [BMChineseSort IndexWithArray:arrM Key:@"uiName" Sequence:false];
    self.letterResultArr = [BMChineseSort sortObjectArray:arrM Key:@"uiName" Sequence:false];
    [self.noticeTable reloadData];
}
#pragma mark --tableviewDelegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArray.count;
}
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.indexArray objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.letterResultArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qcPersonCell" forIndexPath:indexPath];
    [cell refreshUI:[[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    // 判断当前是否为选中状态
    for (NSIndexPath *index in self.selectIndexs) {
        if (indexPath == index) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}
//多选和单选 isSingleSelected -> true 单选
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) { //当为选中状态时，再点击变为未选中状态。
        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
        [self.selectIndexs removeObject:indexPath]; //数据移除
    }else { //未选中
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        [self.selectIndexs addObject:indexPath]; //添加索引数据到数组
        if (self.isSingleSelected) {    // 单选
            [self clickRightBut];
        }
    }
}

@end
