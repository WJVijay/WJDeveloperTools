//
//  WJLabel.h
//  WJDemo
//
//  Created by vijay on 2018/6/9.
//  Copyright © 2018年 vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJLabel : UILabel


//所有属性赋值之后才调用
- (void)settedPropertiesUpdate;

//settedPropertiesUpdate之后才有值
@property (assign ,nonatomic)CGFloat  strHeight;

@property (assign ,nonatomic)CGFloat  strWidth;

@property (assign ,nonatomic)NSUInteger  strRows;

@property (assign ,nonatomic)NSUInteger  limitRows;

@end
