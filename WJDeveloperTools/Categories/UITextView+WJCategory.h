//
//  UITextView+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (WJCategory)

/**
 占位文字
 */
@property (nonatomic,strong) NSString               *placeholder;

/**
 限制字数
 */
@property (copy, nonatomic) NSNumber                *limitLength;//字数限制

@end
