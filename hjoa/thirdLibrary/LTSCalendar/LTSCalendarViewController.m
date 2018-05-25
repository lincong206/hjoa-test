//
//  ViewController.m
//  scrollTest
//
//  Created by leetangsong_macbk on 16/5/19.
//  Copyright © 2016年 macbook. All rights reserved.


#import "LTSCalendarViewController.h"
#import "LTSCalendarDayView.h"
#import "LTSCalendarContentView.h"

#import "LTSCalendarEventSource.h"
#import "LTSCalendarMonthView.h"
#import "LTSCalendarWeekView.h"


#define kTopBarWithStatusHeight 64
#define CriticalHeight 30  //滚动的 临界高度
@interface LTSCalendarViewController ()<UITableViewDelegate,UITableViewDataSource,LTSCalendarEventSource>{
    NSMutableDictionary *eventsByDate;
}





@property (nonatomic,strong) UIView *headerView;
// 手指触摸 开始滚动 tableView 的offectY
@property (nonatomic,assign)CGFloat dragStartOffectY;
// 手指离开 屏幕 tableView 的offectY
@property (nonatomic,assign)CGFloat dragEndOffectY;
@end

@implementation LTSCalendarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
    //日历 加事件的 容器  方便 做悬浮效果
    self.containerView = [UIView new];
   
    self.containerView.frame = CGRectMake(0, WEEK_DAY_VIEW_HEIGHT+kTopBarWithStatusHeight, self.view.frame.size.width, self.view.frame.size.height - WEEK_DAY_VIEW_HEIGHT-kTopBarWithStatusHeight);
    [self.view addSubview:self.containerView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加 日历事件 表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame))];
    [self.containerView addSubview:self.tableView];
   
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // 日历开始的星期   星期一
    LTSCalendarManager *calendar = [LTSCalendarManager new];
    calendar.calendarAppearance.calendar.firstWeekday = 2;
    self.calendar = calendar;
    
    
    //初始化weekDayView    // 日历上面的星期显示
    LTSCalendarWeekDayView *weekDayView = [LTSCalendarWeekDayView new];
    weekDayView.frame = CGRectMake(0, kTopBarWithStatusHeight, self.view.frame.size.width, WEEK_DAY_VIEW_HEIGHT);
    self.calendar.weekDayView = weekDayView;
    
    
    // 日历上半部分
    LTSCalendarSelectedWeekView *weekView = [LTSCalendarSelectedWeekView new];
    weekView.pagingEnabled = YES;
    [calendar setSelectedWeekView:weekView];
    weekView.frame = CGRectMake(0, 400, self.view.frame.size.width, 50);
    
    
    //初始化  contentViw   日历下半部门
    LTSCalendarContentView *view= [LTSCalendarContentView new];
    [calendar setContentView:view];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
   
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    headerView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:view];
    [headerView addSubview:weekView];
    
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    
//    view.backgroundColor = [UIColor grayColor];
    

    self.calendar.eventSource = self;
    calendar.currentDate = [NSDate date];
    calendar.calendarAppearance.weekDayTextColor = DarkText;
    calendar.calendarAppearance.dayCircleColorSelected=RGBCOLOR(251, 52, 65);
    calendar.calendarAppearance.dayTextColor = DarkText;
    calendar.calendarAppearance.lunarDayTextColorOtherMonth = PrimaryText;
    calendar.calendarAppearance.lunarDayTextColor = PrimaryText;
    calendar.calendarAppearance.dayTextColorOtherMonth = PrimaryText;
    calendar.calendarAppearance.backgroundColor = RGBCOLOR(235, 236, 237);
    calendar.calendarAppearance.dayDotColor = PrimaryText;
    calendar.calendarAppearance.dayDotColorSelected = PrimaryText;
    calendar.calendarAppearance.isShowLunarCalender = YES;
//    calendar.calendarAppearance.dayCircleColorSelected = [UIColor redColor];
    
    
    [self.calendar reloadAppearance];
    //数据加载完
    [self.calendar reloadData];
   //初始化 第一项数据  初始数据
    self.calendar.currentDateSelected = [NSDate date];
    
    self.calendar.lastSelectedWeekOfMonth = [self.calendar getWeekFromDate:self.calendar.currentDateSelected];
    
     [self.view addSubview:weekDayView];
    [self.view bringSubviewToFront:weekDayView];
    
    
    //添加事件
    [self createRandomEvents];
  
     [self.calendar reloadData];
    self.view.backgroundColor = self.calendar.calendarAppearance.backgroundColor;
    
    
}




- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    //初始化插入  第一个WeekView
    [self.calendar sendSubviewToSelectedWeekViewWithIndex:self.calendar.currentSelectedWeekOfMonth];
    self.calendar.currentDate = self.calendar.currentDate;

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;

}





- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    
    return dateFormatter;
}
#pragma mark - JTCalendarDataSource
// 该日期是否有事件
- (BOOL)calendarHaveEvent:(LTSCalendarManager *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
//
    return NO;
}
//当前 选中的日期  执行的方法
- (void)calendarDidDateSelected:(LTSCalendarManager *)calendar date:(NSDate *)date
{
   
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    self.title = key;
   
    if (events.count>0) {
       
        //该日期有事件    tableView 加载数据
    }

}



//当tableView 滚动完后  判断位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat startSingleOriginY = self.calendar.calendarAppearance.weekDayHeight*5;
    
    self.dragEndOffectY  = scrollView.contentOffset.y;
    //<0方向向上 >0 方向向下
    
    //用于判断滑动方向
    CGFloat distance = self.dragStartOffectY - self.dragEndOffectY;
    
    
    if (self.tableView.contentOffset.y > CriticalHeight ) {
        if (self.tableView.contentOffset.y < startSingleOriginY) {
            if (self.tableView.contentOffset.y > startSingleOriginY-CriticalHeight) {
                [self showSingleWeekView:YES];
                return;
            }
            //向下滑动
            if (distance < 0) {
                [self showSingleWeekView:YES];
            }
            
            else [self showAllView:YES];
        }
        
        
    }
    else if (self.tableView.contentOffset.y > 0)
        [self showAllView:YES];
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.containerView.backgroundColor = self.calendar.calendarAppearance.backgroundColor;
   
    CGFloat startSingleOriginY = self.calendar.calendarAppearance.weekDayHeight*5;
    
    self.dragEndOffectY  = scrollView.contentOffset.y;
    //<0方向向上 >0 方向向下
    CGFloat distance = self.dragStartOffectY - self.dragEndOffectY;
    
    
    if (self.tableView.contentOffset.y>CriticalHeight ) {
        if (self.tableView.contentOffset.y<startSingleOriginY) {
            if (self.tableView.contentOffset.y>startSingleOriginY - CriticalHeight) {
                [self showSingleWeekView:YES];
                return;
            }
            if (distance<0) {
                [self showSingleWeekView:YES];
            }
            else [self showAllView:YES];
        }
        
        
    }
    else if (self.tableView.contentOffset.y > 0)
        [self showAllView:YES];

    
    
    
}

//当手指 触摸 滚动 就 设置 上一次选择的 跟当前选择的 周 的index 相等
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.dragStartOffectY  = scrollView.contentOffset.y;
    
   self.calendar.lastSelectedWeekOfMonth = self.calendar.currentSelectedWeekOfMonth;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   
    
    CGFloat offectY = scrollView.contentOffset.y;
    
    CGRect contentFrame = self.calendar.contentView.frame;


   //  当 offectY 大于 滚动到要悬浮的位置
   if ( offectY>self.calendar.startFrontViewOriginY) {
       
       self.containerView.backgroundColor = [UIColor whiteColor];
       contentFrame.origin.y = -self.calendar.startFrontViewOriginY;
       
       self.calendar.contentView.frame = contentFrame;

       
       //把 selectedView 插入到 containerView 的最上面
       [self.containerView insertSubview:self.calendar.selectedWeekView atIndex:999];
        // 把tableView 里的 日历视图 插入到 表底部
       [self.containerView insertSubview:self.calendar.contentView atIndex:0];
       
   }else{
       self.containerView.backgroundColor = self.calendar.calendarAppearance.backgroundColor;
       contentFrame.origin.y = 0;
       self.calendar.contentView.frame = contentFrame;
       
       [self.headerView insertSubview:self.calendar.selectedWeekView atIndex:1];
       [self.headerView insertSubview:self.calendar.contentView atIndex:0];
       
   }

    
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}
//回到全部显示初始位置
- (void)showAllView:(BOOL)animate{
    
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:animate];
    
    
}
//滚回到 只显示 一周 的 位置
- (void)showSingleWeekView:(BOOL)animate{
    
    [self.tableView setContentOffset:CGPointMake(0, self.calendar.calendarAppearance.weekDayHeight*5) animated:animate];
    
}


- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
