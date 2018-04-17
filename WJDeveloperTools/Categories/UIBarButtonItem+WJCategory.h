//
//  UIBarButtonItem+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WJCategory)

/**
 导航控制器按钮(只显示图片)
 
 @param image 普通状态图片
 @param highImage 高亮图片
 @param target 监听者
 @param action  方法
 @return return value description
 */
+ (instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/**
 导航控制器按钮(只显示文字)
 
 @param title title description
 @param target target description
 @param action action description
 @return return value description
 */
+ (instancetype) itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 导航控制器按钮(只显示图片和文字)
 
 @param title title description
 @param target target description
 @param action action description
 @return return value description
 */
+ (instancetype) itemWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action;


@end
