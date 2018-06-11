//
//  UILabel+WJLabel.h
//  WJDemo
//
//  Created by vijay on 2018/6/9.
//  Copyright © 2018年 vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WJLabel)

//获取文字行数
- (NSArray *)getLinesArrayOfStringInLabel:(NSString *)string font:(UIFont *)font andLableWidth:(CGFloat)lableWidth;

@end
