//
//  UITextField+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UITextField+WJCategory.h"

@implementation UITextField (WJCategory)

/** 通过这个属性名，就可以修改textField内部的占位文字颜色 */
static NSString * const WJPlaceholderColorKeyPath = @"placeholderLabel.textColor";

/**
 *  设置占位文字颜色
 */

- (void)setWj_placeholderColor:(UIColor *)wj_placeholderColor{
    
    // 这3行代码的作用：1> 保证创建出placeholderLabel，2> 保留曾经设置过的占位文字
    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    
    // 处理xmg_placeholderColor为nil的情况：如果是nil，恢复成默认的占位文字颜色
    if (wj_placeholderColor == nil) {
        wj_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:wj_placeholderColor forKeyPath:WJPlaceholderColorKeyPath];
    
}

/**
 *  获得占位文字颜色
 */
- (UIColor *)wj_placeholderColor
{
    return [self valueForKeyPath:WJPlaceholderColorKeyPath];
}


@end
