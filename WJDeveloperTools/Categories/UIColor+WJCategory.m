//
//  UIColor+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UIColor+WJCategory.h"

@implementation UIColor (WJCategory)

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


+ (UIColor *)themColor
{
    return [UIColor colorWithHexString:@"#2f76e0"];
    //    return [UIColor orangeColor];
}

+ (UIColor *)middleBlue
{
    return [UIColor colorWithRed:53.0/255.0 green:164.0/255.0 blue:235.0/255.0 alpha:1.0];
}

+ (UIColor *)lighBlue
{
    return [UIColor colorWithRed:205.0/255.0 green:245.0/255.0 blue:250.0/255.0 alpha:1.0];
}

+ (UIColor *)lightPurple
{
    return [UIColor colorWithRed:252.0/255.0 green:227.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+ (UIColor *)lightYellow
{
    return [UIColor colorWithRed:250.0/255.0 green:248.0/255.0 blue:205.0/255.0 alpha:1.0];
}

+ (UIColor *)lightGreen
{
    return [UIColor colorWithRed:213.0/255.0 green:255.0/255.0 blue:232.0/255.0 alpha:1.0];
}
+ (UIColor *)lightGrayWords{
    
    return [UIColor colorWithHexString:@"#666666"];
}

@end
