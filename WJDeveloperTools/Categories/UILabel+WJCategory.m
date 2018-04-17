//
//  UILabel+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UILabel+WJCategory.h"

#define kLabSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define kLabSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

// 屏幕适配
#define kLabScreen(value) ((value) * [UIScreen mainScreen].bounds.size.width/375)
#define hLabScreen(value) ((value) * ([UIScreen mainScreen].bounds.size.height)/(667))

@implementation UILabel (WJCategory)

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kLabSCREENWIDTH / 2 - kLabScreen(150), kLabSCREENHEIGHT - kLabScreen(200), kLabScreen(300), hLabScreen(35))];
    [subView addSubview:lable];
    lable.text = reason;
    // lable.alpha = 0.8;
    lable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    lable.font = [UIFont systemFontOfSize:16];
    lable.layer.cornerRadius = 5;
    lable.textAlignment = NSTextAlignmentCenter;
    if (kLabSCREENHEIGHT > 1000) {
        lable.font = [UIFont systemFontOfSize:18];
    }
    
    [lable performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView afterDelay:(NSTimeInterval )time
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kLabSCREENWIDTH / 2 - kLabScreen(150), kLabSCREENHEIGHT - hLabScreen(200), kLabScreen(300), hLabScreen(35))];
    [subView addSubview:lable];
    lable.text = reason;
    // lable.alpha = 0.8;
    lable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    lable.font = [UIFont systemFontOfSize:13];
    lable.layer.cornerRadius = 5;
    lable.textAlignment = NSTextAlignmentCenter;
    if (kLabSCREENHEIGHT > 1000) {
        lable.font = [UIFont systemFontOfSize:18];
    }
    
    [lable performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:time];
}


@end
