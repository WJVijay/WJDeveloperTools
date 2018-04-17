//
//  ClickMenuVC.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "ClickMenuVC.h"
#import "PopoverView.h"

@interface ClickMenuVC ()

@property ( strong, nonatomic) UIButton                      *btn1;

@property ( strong, nonatomic) UIButton                      *btn2;

@property ( strong, nonatomic) UIButton                      *btn3;

@property ( strong, nonatomic) UIButton                      *btn4;

@property ( strong, nonatomic) UIButton                      *btn5;

@property ( strong, nonatomic) UILabel                       *noticeLabel;

@end

@implementation ClickMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectZero;
    
    self.btn1.frame = CGRectMake(100, 100, 80, 44);
    self.btn2.frame = CGRectMake(100, 160, 80, 44);
    self.btn3.frame = CGRectMake(100, 220, 80, 44);
    self.btn4.frame = CGRectMake(300, 280, 80, 44);
    self.btn5.frame = CGRectMake(0, 340, 80, 44);
    self.noticeLabel.frame = CGRectMake(100, 400, 80, 44);
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, 460, 100, 150);
    textView.center = self.view.center;
    textView.placeholder = @"请填写详细地址,不多于120个字";
    textView.limitLength = @10;
    [self.view addSubview:textView];
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    [self.view addSubview:self.btn5];
    [self.view addSubview:self.noticeLabel];
}

- (NSArray<PopoverAction *> *)QQActions {
    // 发起多人聊天 action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_multichat"] title:@"发起多人聊天" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        self.noticeLabel.text = action.title;
    }];
    // 加好友 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"加好友" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"扫一扫" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    // 面对面快传 action
    PopoverAction *facetofaceAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_facetoface"] title:@"面对面快传" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    // 付款 action
    PopoverAction *payMoneyAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"付款" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    
    return @[multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction];
}

- (void)show1:(UIButton *)sender {
    // 不带图片
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"加好友" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"扫一扫" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    PopoverAction *action3 = [PopoverAction actionWithTitle:@"发起聊天" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    PopoverAction *action4 = [PopoverAction actionWithTitle:@"发起群聊" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    PopoverAction *action5 = [PopoverAction actionWithTitle:@"查找群聊" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    PopoverAction *action6 = [PopoverAction actionWithTitle:@"我的群聊" handler:^(PopoverAction *action) {
        self.noticeLabel.text = action.title;
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    [popoverView showToView:sender withActions:@[action1, action2, action3, action4, action5, action6]];
}

- (void)click:(UIButton *)sender{
    
    if (sender.tag == 1) {
        
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
        [popoverView showToView:sender withActions:[self QQActions]];
        
    }else if (sender.tag == 2){
        
        PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_newmessage"] title:@"发起群聊" handler:^(PopoverAction *action) {
            self.noticeLabel.text = action.title;
        }];
        PopoverAction *action2 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_friend"] title:@"添加朋友" handler:^(PopoverAction *action) {
            self.noticeLabel.text = action.title;
        }];
        PopoverAction *action3 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_scan"] title:@"扫一扫" handler:^(PopoverAction *action) {
            self.noticeLabel.text = action.title;
        }];
        PopoverAction *action4 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_money"] title:@"收付款" handler:^(PopoverAction *action) {
            self.noticeLabel.text = action.title;
        }];
        
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.style = PopoverViewStyleDark;
        // 在没有系统控件的情况下调用可以使用显示在指定的点坐标的方法弹出菜单控件.
        [popoverView showToPoint:CGPointMake(20, 64) withActions:@[action1, action2, action3, action4]];

        
    }else if (sender.tag == 3){
        
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.showShade = YES; // 显示阴影背景
        [popoverView showToView:sender withActions:[self QQActions]];
        
    }else if (sender.tag == 4){
        
        [self show1:sender];
        
    }else if (sender.tag == 5){
        
        [self show1:sender];
        
    }
    
}

- (UILabel *)noticeLabel{
    
    if (_noticeLabel == nil) {
        
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.textColor = [UIColor redColor];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _noticeLabel;
}

- (UIButton *)btn1{
    
    if (_btn1 == nil) {
        
        _btn1 = [[UIButton alloc]init];
        [_btn1 setTitle:@"1" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn1.tag = 1;
        [_btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _btn1;
}

- (UIButton *)btn2{
    
    if (_btn2 == nil) {
        
        _btn2 = [[UIButton alloc]init];
        [_btn2 setTitle:@"1" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn2.tag = 2;
        [_btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _btn2;
}

- (UIButton *)btn3{
    
    if (_btn3 == nil) {
        
        _btn3 = [[UIButton alloc]init];
        [_btn3 setTitle:@"1" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btn3.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn3.tag = 3;
        [_btn3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _btn3;
}

- (UIButton *)btn4{
    
    if (_btn4 == nil) {
        
        _btn4 = [[UIButton alloc]init];
        [_btn4 setTitle:@"1" forState:UIControlStateNormal];
        [_btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btn4.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn4.tag = 4;
        [_btn4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _btn4;
}

- (UIButton *)btn5{
    
    if (_btn5 == nil) {
        
        _btn5 = [[UIButton alloc]init];
        [_btn5 setTitle:@"1" forState:UIControlStateNormal];
        [_btn5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn5 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btn5.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn5.tag = 5;
        [_btn5 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _btn5;
}

@end
