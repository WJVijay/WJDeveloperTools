//
//  NSArray+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WJCategory)

/**
 *  在安全模式下获取给定索引中的对象(如果self为空或超出范围)
 *
 *  @param index The index
 *
 *  @return Returns the object at a given index in safe mode (nil if self is empty or out of range)
 */
- (id _Nullable)safeObjectAtIndex:(NSUInteger)index;

/**
 *  数组倒叙
 *
 *  @return Returns the reversed array
 */
- (NSArray * _Nonnull)reversedArray;

/**
 *  转json字符
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString * _Nonnull)arrayToJson;

/**
 *  将数组模拟成一个圆。当它超出范围时，重新开始。
 *
 *  @param index The index
 *
 *  @return Returns the object at a given index
 */
- (id _Nullable)objectAtCircleIndex:(NSInteger)index;

/**
 *  数组倒叙
 *
 *  @param array The array to be converted
 *
 *  @return Returns the reversed array
 */
+ (NSArray * _Nonnull)reversedArray:(NSArray * _Nonnull)array;

/**
 *  转json字符
 *
 *  @param array The array to be reversed
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString * _Nonnull)arrayToJson:(NSArray * _Nonnull)array;

@end
