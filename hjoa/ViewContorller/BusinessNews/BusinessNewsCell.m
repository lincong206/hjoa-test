//
//  BusinessNewsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/8/18.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "BusinessNewsCell.h"
#import "ContentCell.h"
#import "ContentFristCell.h"

@interface BusinessNewsCell () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *ContentTable;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation BusinessNewsCell

- (void)passData:(NSMutableArray *)arr
{
    self.ContentTable.delegate = self;
    self.ContentTable.dataSource = self;
    self.ContentTable.scrollEnabled = false;
    [self.ContentTable registerNib:[UINib nibWithNibName:@"ContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"contentCell"];
    [self.ContentTable registerNib:[UINib nibWithNibName:@"ContentFristCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cfCell"];
    self.dataSource = arr;
    [self.ContentTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ContentFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cfCell" forIndexPath:indexPath];
        [cell refreContentFristCellDataWithModel:self.dataSource[indexPath.row]];
        return cell;
    }else {
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
        [cell refreContentCellDataWithModel:self.dataSource[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }else {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClickNewsViewController *cvc = [[ClickNewsViewController alloc] init];
    BusinssNewsModel *model = self.dataSource[indexPath.row];
    cvc.htmlStr = model.naContent;
    [self.passDelegate passViewForPush:cvc];
}

@end
