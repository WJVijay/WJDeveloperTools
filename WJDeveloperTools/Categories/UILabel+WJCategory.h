//
//  UILabel+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WJCategory)

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView;

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView afterDelay:(NSTimeInterval )time;

@end
