//
//  NSMutableArray+WJMethodSwizzling.h
//  AfterDemo
//
//  Created by Yuan Wang on 2018/4/13.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (WJMethodSwizzling)

/**
 *  Move an object from an index to another
 *
 *  @param from The index to move from
 *  @param to   The index to move to
 */
- (void)moveObjectFromIndex:(NSUInteger)from
                    toIndex:(NSUInteger)to;

/**
 *  Create a reversed array from self
 *
 *  @return Returns the reversed array
 */
- (NSMutableArray * _Nonnull)reversedArray;

/**
 *  Sort an array by a given key with option for ascending or descending
 *
 *  @param key       The key to order the array
 *  @param array     The array to be ordered
 *  @param ascending A BOOL to choose if ascending or descending
 *
 *  @return Returns the given array ordered by the given key ascending or descending
 */
+ (NSMutableArray * _Nonnull)sortArrayByKey:(NSString * _Nonnull)key
                                      array:(NSMutableArray * _Nonnull)array
                                  ascending:(BOOL)ascending;


@end
