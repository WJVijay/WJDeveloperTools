//
//  CalendarScrollVC.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/6/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "CalendarScrollVC.h"
#import "FSCalendar.h"
#import "Masonry.h"
#define CalendarHeihgt (self.view.frame.size.width < 375)? 270:300 //日历适配

@interface CalendarScrollVC ()<FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>
{
    void * _KVOContext;
}

@property (strong, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;

@end

@implementation CalendarScrollVC

- (void)click:(UIButton *)sender{
    
    sender.selected =!sender.selected;
    
   
    if (sender.selected) {
        
            [self.calendar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view.mas_top).mas_offset(64);
            }];
  
    }else{
        
        [self.calendar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).mas_offset(-300);
        }];

    }
    [self.view setNeedsLayout];
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self.calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset((0));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    //日历控件
    [self.view addSubview:self.calendar];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(15);
        make.trailing.mas_equalTo(self.view).mas_offset(-15);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(-300);
        make.height.mas_offset((300));
    }];
    
    //tableView
    [self.view addSubview:self.tableView];
    //    WithFrame:CGRectMake(0,40*KHScale, KKMAINWIDTH, KKMAINHEIGHT-64-40*KHScale)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.calendar.mas_bottom).mas_offset(0);
        make.leading.mas_equalTo(self.view.mas_leading).mas_offset(0);
        make.trailing.mas_equalTo(self.view.mas_trailing).mas_offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(0);
    }];
    self.tableView.showsVerticalScrollIndicator = NO;

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
    // While the scope gesture begin, the pan gesture of tableView should cancel.
    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    self.calendar.scope = FSCalendarScopeMonth;
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
}



#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    //    NSLog(@"%@",(calendar.scope==FSCalendarScopeWeek?@"week":@"month"));
    NSLog(@"%lf",CGRectGetHeight(bounds));
    
    [self.calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset((CGRectGetHeight(bounds)));
    }];
    [self.view layoutIfNeeded];//112
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld----%ld",indexPath.section,indexPath.row];
    return cell;
}

- (FSCalendar *)calendar{
    
    if (_calendar == nil) {
        
        //实例化日历控件
        // 450 for iPad and 300 for iPhone
        //    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 260;
        self.calendar = [[FSCalendar alloc] init];
        //    self.calendar.frame = CGRectMake(15, CGRectGetMaxY(self.headerView.frame), KKMAINWIDTH-15*2, 0);
        
        
        
        _calendar.layer.cornerRadius = 7.5;
        _calendar.layer.borderWidth = 1;
//        _calendar.layer.borderColor = [UIColor DW_lightBlueColor].CGColor;
        _calendar.backgroundColor = [UIColor whiteColor];
        [_calendar registerClass:[FSCalendarCell class] forCellReuseIdentifier:@"cell"];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.allowsMultipleSelection = NO;
        _calendar.allowsSelection = YES;
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
        _calendar.calendarHeaderView.backgroundColor = [UIColor colorWithHexString:@"01a3e2"];
//        _calendar.headerHeight = CalendarHeadHeight;
        _calendar.weekdayHeight = 50;
        _calendar.firstWeekday = 2;
        //    self.calendar.appearance.eventDefaultColor = [UIColor lightGrayColor];
        //    self.calendar.appearance.eventSelectionColor = [UIColor lightGrayColor];
//        _calendar.appearance.headerTitleFont = [UIFont DW_PingFangWithTitleSize:14];
        _calendar.appearance.headerDateFormat = @"yyyy年MM月";
        
        //    self.calendar.appearance.selectionColor = [UIColor colorWithHexString:@"01a3e2"];
        
        
#pragma mark: -注意点-
        //注意点:需求设置当天的日期的边框颜色,背景为白色,字体颜色为黑色
        //解决方法有3个步骤:
        //1.self.calendar.appearance.todayColor = [UIColor whiteColor];
        //2.self.calendar.appearance.titleTodayColor = [UIColor blackColor];
        //3.
        _calendar.appearance.todayColor = [UIColor whiteColor];
        _calendar.appearance.titleTodayColor = [UIColor blackColor];
        //    [self.calendar.appearance setBorderDefaultColor:[UIColor colorWithHexString:@"01a3e2"]];
        //设置中文
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        //周的每一天显示红色
        _calendar.appearance.titleWeekendColor = [UIColor blackColor];
        //title 月份和年份显示黑色
        _calendar.appearance.headerTitleColor = [UIColor whiteColor];
        //周日到周六显示黑色
        _calendar.appearance.weekdayTextColor = [UIColor redColor];
        _calendar.clipsToBounds = YES;//隐藏底部的线
        
//        self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //    self.previousButton.backgroundColor = [UIColor whiteColor];
//        self.previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [self.previousButton setBackgroundImage:[UIImage imageNamed:@"icon_prev_ca"] forState:UIControlStateNormal];
//        [self.previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_calendar addSubview:self.previousButton];
//
//        CGFloat top = (CalendarHeadHeight-15)*0.5;
//        [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.mas_equalTo(self.calendar.mas_top).mas_offset(top);
//            make.leading.mas_equalTo(self.calendar).mas_offset(10);
//            make.width.mas_offset(15);
//            make.height.mas_offset(15);
//        }];
//
//        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //    self.nextButton.backgroundColor = [UIColor whiteColor];
//        self.nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [self.nextButton setBackgroundImage:[UIImage imageNamed:@"icon_next_ca"] forState:UIControlStateNormal];
//        [self.nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.calendar addSubview:self.nextButton];
//        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.mas_equalTo(self.calendar.mas_top).mas_offset(top);
//            make.trailing.mas_offset(-10);
//            make.width.mas_offset(15);
//            make.height.mas_offset(15);
//        }];
    }
    return _calendar;
}

@end
