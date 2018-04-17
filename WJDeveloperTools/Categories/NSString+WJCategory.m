//
//  NSString+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "NSString+WJCategory.h"
#import <CommonCrypto/CommonCrypto.h>

/**
 Ceil the size (for string drawing calculate)
 */
static inline CGSize CGSizeCeil(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}


@implementation NSString (WJCategory)


+ (NSString * _Nonnull)searchInString:(NSString *)string charStart:(char)charStart charEnd:(char)charEnd {
    int start = 0, end = 0;
    
    for (int i = 0; i < [string length]; i++) {
        if ([string characterAtIndex:i] == charStart && start == 0) {
            start = i+1;
            i += 1;
            continue;
        }
        if ([string characterAtIndex:i] == charEnd) {
            end = i;
            break;
        }
    }
    
    end -= start;
    
    if (end < 0) {
        end = 0;
    }
    
    return [[string substringFromIndex:start] substringToIndex:end];
}

- (NSString * _Nonnull)searchCharStart:(char)start charEnd:(char)end {
    return [NSString searchInString:self charStart:start charEnd:end];
}

- (NSInteger)indexOfCharacter:(char)character {
    for (NSUInteger i = 0; i < [self length]; i++) {
        if ([self characterAtIndex:i] == character) {
            return i;
        }
    }
    
    return -1;
}

- (NSString * _Nonnull)substringFromCharacter:(char)character {
    NSInteger index = [self indexOfCharacter:character];
    if (index != -1) {
        return [self substringFromIndex:index];
    } else {
        return @"";
    }
}

- (NSString * _Nonnull)substringToCharacter:(char)character {
    NSInteger index = [self indexOfCharacter:character];
    if (index != -1) {
        return [self substringToIndex:index];
    } else {
        return @"";
    }
}

- (BOOL)hasString:(NSString * _Nonnull)substring {
    return [self hasString:substring caseSensitive:YES];
}

- (BOOL)hasString:(NSString *)substring caseSensitive:(BOOL)caseSensitive {
    if (caseSensitive) {
        return [self rangeOfString:substring].location != NSNotFound;
    } else {
        return [self.lowercaseString rangeOfString:substring.lowercaseString].location != NSNotFound;
    }
}

+ (NSData * _Nonnull)convertToNSData:(NSString * _Nonnull)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData * _Nonnull)convertToNSData {
    return [NSString convertToNSData:self];
}

- (NSString * _Nonnull)sentenceCapitalizedString {
    if (![self length]) {
        return @"";
    }
    NSString *uppercase = [[self substringToIndex:1] uppercaseString];
    NSString *lowercase = [[self substringFromIndex:1] lowercaseString];
    
    return [uppercase stringByAppendingString:lowercase];
}

- (NSString * _Nonnull)dateFromTimestamp {
    NSString *year = [self substringToIndex:4];
    NSString *month = [[self substringFromIndex:5] substringToIndex:2];
    NSString *day = [[self substringFromIndex:8] substringToIndex:2];
    NSString *hours = [[self substringFromIndex:11] substringToIndex:2];
    NSString *minutes = [[self substringFromIndex:14] substringToIndex:2];
    
    return [NSString stringWithFormat:@"%@/%@/%@ %@:%@", day, month, year, hours, minutes];
}

- (NSString * _Nonnull)urlEncode {
    return [self URLEncode];
}

- (NSString * _Nonnull)URLEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString * _Nonnull)removeExtraSpaces {
    NSString *squashed = [self stringByReplacingOccurrencesOfString:@"[ ]+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    return [squashed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString * _Nonnull)stringByReplacingWithRegex:(NSString * _Nonnull)regexString withString:(NSString * _Nonnull)replacement {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
}

- (NSString * _Nonnull)HEXToString {
    NSMutableString *newString = [NSMutableString string];
    NSArray *components = [self componentsSeparatedByString:@" "];
    for (NSString * component in components) {
        int value = 0;
        sscanf([component cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
    }
    return newString;
}

- (NSString * _Nonnull)stringToHEX {
    NSUInteger len = [self length];
    unichar *chars = malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0; i < len; i++ ) {
        [hexString appendFormat:@"%02x", chars[i]];
    }
    free(chars);
    
    return hexString;
}

+ (NSString * _Nonnull)generateUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

- (BOOL)isUUID {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return matches == 1;
}

- (BOOL)isUUIDForAPNS {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9a-f]{32}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return matches == 1;
}

- (NSString * _Nonnull)convertToAPNSUUID {
    return [[[self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


- (NSString*) sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)md5 {
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)sha1_base64 {
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    base64 = [self base64Encode:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return output;
}

- (NSString *)md5_base64 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    base64 = [self base64Encode:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return output;
}

- (NSString *)base64 {
    NSData * data = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    data = [self base64Encode:data];
    NSString * output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}


- (NSData*)base64Encode:(NSData*)data {
    return [data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}




- (CGFloat)heightForString:(NSString *)str font:(UIFont *)font width:(CGFloat)width {
    CGFloat height;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{ NSFontAttributeName: font } context:nil];
        height = rect.size.height;
        height += 1;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        height = size.height;
    }
    return height;
}


- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width line:(NSInteger)line {
    NSMutableString *test = NSMutableString.new;
    for (int i=0; i<line; i++) {
        [test appendString:@"字"];
    }
    CGFloat maxHeight = [self heightForString:test font:font width:1];
    CGFloat height = [self heightForString:self font:font width:width];
    return height > maxHeight ? maxHeight : height;
}

- (CGFloat)lf_widthForFont:(UIFont *)font {
    CGSize size = [self lf_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self lf_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGSize)lf_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = @{}.mutableCopy;
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return CGSizeCeil(result);
}

- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self textSizeWithContentSize:size font:font].height;
}

- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithContentSize:size font:font].width;
}

@end
