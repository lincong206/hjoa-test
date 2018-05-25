//
//  CalenderNewsCell.m
//  hjoa
//
//  Created by 华剑 on 2017/10/19.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "CalenderNewsCell.h"
#import "Header.h"
#import "NSDate+Formatter.h"
#import "MonthModel.h"
#import "CalenderCollectionCell.h"
#import "CalenderCollectionReusableView.h"
#define HeaderViewHeight 30
@interface CalenderNewsCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSString *_now; // 日期参数做为判断
    NSString *_time;
    NSDateFormatter *_formatter;
    NSString *_selectDate;      // 选择查看日期
    BOOL _isWeek;                // 是否为周末
}
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionView *calenderCollection;
@property (strong, nonatomic) NSDate *tempDate;     // 当前日期

@end

@implementation CalenderNewsCell

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)passDate:(NSString *)date
{
    self.calenderCollection.delegate = self;
    self.calenderCollection.dataSource = self;
    
    [self.calenderCollection registerNib:[UINib nibWithNibName:@"CalenderCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ccCell"];
    [self.calenderCollection registerNib:[UINib nibWithNibName:@"CalenderCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ccHeader"];
    
    _formatter = [[NSDateFormatter alloc]init];
    _formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];//零区时间
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    
    if (date) {
        _time = date;
        _now = [_formatter stringFromDate:[NSDate date]];
        // 转化成date类型
        self.tempDate = [_formatter dateFromString:date];
        [self getDataDayModel:self.tempDate];
    }
    
}

- (void)getDataDayModel:(NSDate *)date
{
    // 月总天数
    NSUInteger days = [self numberOfDaysInMonth:date];
    // 月总星期熟
    NSInteger week = [self startDayOfWeek:date];
    // 载装数据之前，把数据源清空
    [self.dataSource removeAllObjects];
    int day = 1;
    for (int i= 1; i<days+week; i++) {
        if (i<week) {
            [self.dataSource addObject:@""];
        }else{
            MonthModel *mon = [MonthModel new];
            mon.dayValue = day;
            // 获取当天时间
            NSDate *dayDate = [self dateOfDay:day];
            mon.dateValue = dayDate;
            if (_selectDate) {
                if (day == [[_selectDate componentsSeparatedByString:@"-"].lastObject integerValue]) {
                    mon.isSelectedDay = YES;
                }
            }else {
                if (day == [[_time componentsSeparatedByString:@"-"].lastObject intValue]) {
                    mon.isSelectedDay = YES;
                }
            }
            // 每个时间与当前时间对比。过去时间下面显示红点
            if ([self compareNowTime:_now withOtherTime:[_formatter stringFromDate:mon.dateValue] withDateFormatter:_formatter]) {
                mon.isPass = YES;
            }else {
                mon.isPass = NO;
            }
            // 判断周末
            if ((i-1)%7 == 0 || (i-7)%7 == 0) {
                mon.isWeek = YES;
            }else {
                mon.isWeek = NO;
            }
            [self.dataSource addObject:mon];
            day++;
        }
    }
    [self.calenderCollection reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalenderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ccCell" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 20;
    // 判断是否为空。
    id mon = self.dataSource[indexPath.row];
    if ([mon isKindOfClass:[MonthModel class]]) {
        MonthModel *model = self.dataSource[indexPath.row];
        cell.dayLabel.text = [NSString stringWithFormat:@"%02ld",(long)[model dayValue]];
        cell.dayLabel.userInteractionEnabled = YES;
        cell.diandian.hidden = !model.isPass;
        if (model.isSelectedDay) {
            cell.dayLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor colorWithRed:50/255.0 green:145/255.0 blue:234/255.0 alpha:1.0];
        }else {
            cell.dayLabel.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor whiteColor];
        }
        // 判断周末
        if (model.isWeek) {
            cell.dayLabel.textColor = [UIColor lightGrayColor];
            cell.diandian.hidden = YES;
        }
    }else {
        // 为上个月空的几天
        cell.dayLabel.text = @"";
        cell.diandian.hidden = YES;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthModel *model = self.dataSource[indexPath.row];
    // 改变颜色
    for (int i = 0; i < self.dataSource.count; i++) {
        if ([self.dataSource[i] isKindOfClass:[MonthModel class]]) {
            MonthModel *mon = self.dataSource[i];
            mon.isSelectedDay = NO;
        }
    }
    // 选择日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if (![model isEqual:@""]) {
        _selectDate = [formatter stringFromDate:model.dateValue];
        // 传日期参数
        [self.passDayDelegate passSelectDay:_selectDate andIsWeek:model.isWeek];
        model.isSelectedDay = YES;
        [self.calenderCollection reloadData];
    }
}

// 头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CalenderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ccHeader" forIndexPath:indexPath];
    NSArray *weekArray = [[NSArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    for (int i=0; i<weekArray.count; i++) {
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*Iphone6Scale(54), 0, Iphone6Scale(54), HeaderViewHeight)];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.textColor = [UIColor blackColor];
        weekLabel.font = [UIFont systemFontOfSize:14.f];
        weekLabel.text = weekArray[i];
        [headerView addSubview:weekLabel];
    }
    return headerView;
}

// 查询日期与当前日期做判断
- (BOOL )compareNowTime:(NSString *)nowTime withOtherTime:(NSString *)otherTime withDateFormatter:(NSDateFormatter *)formatter
{
    NSDate *dateA = [formatter dateFromString:nowTime];
    NSDate *dateB = [formatter dateFromString:otherTime];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedSame || result == NSOrderedDescending) {    // 两者时间是同一个时间   说明是当天 //nowTime比 otherTime时间晚 说明otherTime是过去时间
        return YES;
    }else {     // 说明otherTime是未来时间
        return NO;
    }
}

#pragma mark -Private
// 这个月有多少天
- (NSUInteger)numberOfDaysInMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
}
// 这个月的第一天
- (NSDate *)firstDateOfMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:date];
    comps.day = 1;
    return [greCalendar dateFromComponents:comps];
}
//这个月开始的日子
- (NSUInteger)startDayOfWeek:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];//Asia/Shanghai
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:[self firstDateOfMonth:date]];
    return comps.weekday;
}
//上个月
- (NSDate *)getLastMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month -= 1;
    return [greCalendar dateFromComponents:comps];
}
//下个月
- (NSDate *)getNextMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month += 1;
    return [greCalendar dateFromComponents:comps];
}
//当天
- (NSDate *)dateOfDay:(NSInteger)day{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:self.tempDate];
    comps.day = day;
    return [greCalendar dateFromComponents:comps];
}

@end
