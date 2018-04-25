
//
//  WJDefineHeader.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#ifndef WJDefineHeader_h
#define WJDefineHeader_h

//***********外部使用***********
//屏幕宽高
#define kSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

// 屏幕适配
#define kScreen(value) ((value) * [UIScreen mainScreen].bounds.size.width/375)
#define hScreen(value) ((value) * ([UIScreen mainScreen].bounds.size.height)/(667))

#define NavgationMaxY CGRectGetMaxY(self.navigationController.navigationBar.frame)

//打印
#ifdef DEBUG
#define WJLog(...) NSLog(__VA_ARGS__)
#else
#define WJLog(...)
#endif

#endif /* WJDefineHeader_h */
