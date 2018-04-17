//
//  NSString+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (WJCategory)


/**
 *  在给定的字符串中搜索从开始字符到结束字符(不包括最终字符串)的子字符串
 *  例如: "This is a test" with start char 'h' and end char 't' will return "is is a "
 *
 *  @param string The string to search in
 *  @param start  start char
 *  @param end    end char
 *
 *  @return Returns the substring
 */
+ (NSString * _Nonnull)searchInString:(NSString *_Nonnull)string
                            charStart:(char)start
                              charEnd:(char)end;

/**
 *  在给定的字符串中搜索从开始字符到结束字符(不包括最终字符串)的子字符串。
 *  例如: "This is a test" with start char 'h' and end char 't' will return "is is a "
 *
 *  @param start  start char
 *  @param end    end char
 *
 *  @return Returns the substring
 */
- (NSString * _Nonnull)searchCharStart:(char)start
                               charEnd:(char)end;

/**
 *  返回给定字符的索引。
 *
 *  @param character The character to search
 *
 *  @return Returns the index of the given character, -1 if not found
 */
- (NSInteger)indexOfCharacter:(char)character;

/**
 *  Creates a substring from the given character
 *
 *  @param character The character
 *
 *  @return Returns the substring from character
 */
- (NSString * _Nonnull)substringFromCharacter:(char)character;

/**
 *  从给定的字符创建一个子字符串。
 *
 *  @param character The character
 *
 *  @return Returns the substring to character
 */
- (NSString * _Nonnull)substringToCharacter:(char)character;

/**
 *  Check if self has the given substring in case-sensitive
 *
 *  @param substring The substring to be searched
 *
 *  @return Returns YES if founded, NO if not
 */
- (BOOL)hasString:(NSString * _Nonnull)substring;

/**
 *  检查self是否具有区分大小写的子字符串。
 *
 *  @param substring     The substring to be searched
 *  @param caseSensitive If the search has to be case-sensitive or not
 *
 *  @return Returns YES if founded, NO if not
 */
- (BOOL)hasString:(NSString * _Nonnull)substring
    caseSensitive:(BOOL)caseSensitive;

/**
 *  将给定的NSString转换为NSData。
 *
 *  @param string The NSString to be converted
 *
 *  @return Returns the converted NSString as NSData
 */
+ (NSData * _Nonnull)convertToNSData:(NSString * _Nonnull)string;

/**
 *  Convert self to a NSData
 *
 *  @return Returns self as NSData
 */
- (NSData * _Nonnull)convertToNSData;

/**
 *  把自己变成一个大写的字符串。
 *  Example: "This is a Test" will return "This is a test" and "this is a test" will return "This is a test"
 *
 *  @return Returns the capitalized sentence string
 */
- (NSString * _Nonnull)sentenceCapitalizedString;

/**
 * 从时间戳中返回一个人字迹清晰的字符串。
 *
 *  @return Returns a human legible string from a timestamp
 */
- (NSString * _Nonnull)dateFromTimestamp;

/**
 *  将self编码为编码的url字符串。
 *
 *  @return Returns the encoded NSString
 */
- (NSString * _Nonnull)urlEncode DEPRECATED_MSG_ATTRIBUTE("Use -URLEncode");

/**
 *  将self编码为编码的url字符串。
 *
 *  @return Returns the encoded NSString
 */
- (NSString * _Nonnull)URLEncode;

/**
 *  删除重复或更多的重复空格。
 *
 *  @return String without additional spaces
 */
- (NSString * _Nonnull)removeExtraSpaces;

/**
 *  返回包含匹配正则表达式的新字符串，替换为模板字符串。
 *
 *  @param regexString The regex string
 *  @param replacement The replacement string
 *
 *  @return Returns a new string containing matching regular expressions replaced with the template string
 */
- (NSString * _Nonnull)stringByReplacingWithRegex:(NSString * _Nonnull)regexString
                                       withString:(NSString * _Nonnull)replacement;

/**
 *  将十六进制字符串(按空格分隔)转换为“常用”字符串。
 *    Example: "68 65 6c 6c 6f" -> "hello"
 *
 *  @return Readable string
 */
- (NSString * _Nonnull)HEXToString;

/**
 *  将字符串转换为十六进制字符串。
 *    Example: "hello" -> "68656c6c6f"
 *
 *  @return HEX string
 */
- (NSString * _Nonnull)stringToHEX;

/**
 *  用于创建一个UUID作为NSString。
 *
 *  @return Returns the created UUID string
 */
+ (NSString * _Nonnull)generateUUID;

/**
 *  返回如果self是一个有效的UUID。
 *
 *  @return Returns if self is a valid UUID or not
 */
- (BOOL)isUUID;

/**
 *  如果self是APNS (Apple Push Notification System)的有效UUID，则返回。
 *
 *  @return Returns if self is a valid UUID for APNS (Apple Push Notification System) or not
 */
- (BOOL)isUUIDForAPNS;

/**
 *  将self转换为UUID APNS有效(不“<>”或“-”或空格)
 *
 *  @return Converts self to an UUID APNS valid (No "<>" or "-" or spaces)
 */
- (NSString * _Nonnull)convertToAPNSUUID;


#pragma mark - 加密-
- (NSString *)md5;

- (NSString *)sha1;

- (NSString *)sha1_base64;

- (NSString *)md5_base64;

- (NSString *)base64;
#pragma mark: -end-


#pragma mark - 绘制-
///=============================================================================
/// @name 绘制
///=============================================================================


/// 计算字符串的绘制大小
- (CGSize)lf_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/// 计算字符串的绘制宽度 (单行)
- (CGFloat)lf_widthForFont:(UIFont *)font;

/// 计算字符串的绘制高度 (定宽)
- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width;

/// 计算字符串的绘制高度
/// @param width 最大宽度
/// @param maxLine 最大行数 (比如传入3，则字超过3行时，会截取3行的高度返回)
- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width line:(NSInteger)maxLine;
#pragma mark: -end-

#pragma mark: -计算文本高度-
/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;

#pragma mark: -end-

@end
