//
//  NSMutableDictionary+WJCagtegoty.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "NSMutableDictionary+WJCagtegoty.h"

@implementation NSMutableDictionary (WJCagtegoty)

- (BOOL)safeSetObject:(id _Nonnull)anObject forKey:(id<NSCopying> _Nonnull)aKey {
    if (anObject == nil) {
        return NO;
    }
    
    [self setObject:anObject forKey:aKey];
    
    return YES;
}

@end
