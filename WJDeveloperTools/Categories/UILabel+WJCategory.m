//
//  UILabel+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UILabel+WJCategory.h"

@implementation UILabel (WJCategory)

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kSCREENWIDTH / 2 - kScreen(150), kSCREENHEIGHT - hScreen(200), kScreen(300), hScreen(35))];
    [subView addSubview:lable];
    lable.text = reason;
    // lable.alpha = 0.8;
    lable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    lable.font = [UIFont systemFontOfSize:16];
    lable.layer.cornerRadius = 5;
    lable.textAlignment = NSTextAlignmentCenter;
    if (kSCREENHEIGHT > 1000) {
        lable.font = [UIFont systemFontOfSize:18];
    }
    
    [lable performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView afterDelay:(NSTimeInterval )time
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kSCREENWIDTH / 2 - kScreen(150), kSCREENHEIGHT - hScreen(200), kScreen(300), hScreen(35))];
    [subView addSubview:lable];
    lable.text = reason;
    // lable.alpha = 0.8;
    lable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    lable.font = [UIFont systemFontOfSize:13];
    lable.layer.cornerRadius = 5;
    lable.textAlignment = NSTextAlignmentCenter;
    if (kSCREENHEIGHT > 1000) {
        lable.font = [UIFont systemFontOfSize:18];
    }
    
    [lable performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:time];
}


@end
