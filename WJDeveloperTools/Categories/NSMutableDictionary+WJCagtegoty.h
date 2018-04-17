//
//  NSMutableDictionary+WJCagtegoty.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (WJCagtegoty)

/**
 * 将给定键的对象设置为安全模式(如果不是nil)
 *
 *  @param anObject The object
 *  @param aKey     The key
 *
 *  @return Returns YES if has been setted, otherwise NO
 */
- (BOOL)safeSetObject:(id _Nonnull)anObject
               forKey:(id<NSCopying> _Nonnull)aKey;

@end
