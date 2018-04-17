//
//  NSDictionary+WJCategoty.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WJCategoty)


/**
    生成所需要的属性代码
 */
- (void)propertyCode;

/**
 *  转json字符
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString * _Nonnull)dictionaryToJson DEPRECATED_MSG_ATTRIBUTE("Use -dictionaryToJSON");

/**
 *  转字符字符
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
- (NSString * _Nonnull)dictionaryToJSON;

/**
 *  转json字符
 *
 *  @param dictionary The dictionary to be converted
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString * _Nonnull)dictionaryToJson:(NSDictionary * _Nonnull)dictionary DEPRECATED_MSG_ATTRIBUTE("Use +dictionaryToJSON:");

/**
 *  转json字符
 *
 *  @param dictionary The dictionary to be converted
 *
 *  @return Returns the JSON as NSString or nil if error while parsing
 */
+ (NSString * _Nonnull)dictionaryToJSON:(NSDictionary * _Nonnull)dictionary;

/**
 *  如果键存在，则返回一个对象，否则为nil。
 *
 *  @param key Key to get value of
 *
 *  @return Value for the key Or nil
 */
- (id _Nullable)safeObjectForKey:(NSString * _Nonnull)key;

@end
