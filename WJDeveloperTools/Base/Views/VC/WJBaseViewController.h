//
//  WJBaseViewController.h
//  AfterDemo
//
//  Created by Yuan Wang on 2018/4/13.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJBaseVCProtocol.h"

@interface WJBaseViewController : UIViewController

@property ( copy, nonatomic) NSString                      *navigationTitle;

@property ( weak, nonatomic) id    <WJBaseVCProtocol>      delegate;

@property ( strong, nonatomic) id                          superClass;

/**
 跳转携带的信息
 */
@property ( copy, nonatomic) NSString                      *infoString;
@property ( strong, nonatomic) NSDictionary                *infoDict;
@property ( strong, nonatomic) NSArray                     *infoArray;

/**
 跳转
 
 @param classStr classStr description
 */
- (void)jumpToVCWithClassStr:(NSString *)classStr;
- (void)jumpToVCWithClassStr:(NSString *)classStr withInfo:(id)info; //跳转附带信息
- (void)jumpToVCWithClassStrs:(NSArray <NSString *>*)classStrs withIndex:(NSInteger)index;

/**
 截屏功能
 */
-(void)screenShotAction;

@end
