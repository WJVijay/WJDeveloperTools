//
//  ViewController.m
//  倒计时
//
//  Created by lanou3g on 16/1/5.
//  Copyright © 2016年 syx. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+CountDown.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * countDownBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 150, 120, 40)];
    [countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownBtn.backgroundColor = [UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f];
    [countDownBtn addTarget:self action:@selector(countDownBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countDownBtn];
    
}

- (void)countDownBtnAction:(UIButton *)button{

    [button startWithTime:5 title:@"点击重新获取" countDownTitle:@"s" mainColor:[UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f] countColor:[UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
