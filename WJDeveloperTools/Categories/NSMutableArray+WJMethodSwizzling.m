//
//  NSMutableArray+WJMethodSwizzling.m
//  AfterDemo
//
//  Created by Yuan Wang on 2018/4/13.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "NSMutableArray+WJMethodSwizzling.h"
#import <objc/runtime.h>
#import "NSArray+WJCategory.h"

@implementation NSMutableArray (WJMethodSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(wj_safeAddObject:)];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(wj_safeObjectAtIndex:)];
        [obj swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(wj_safeInsertObject:atIndex:)];
        [obj swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(wj_safeRemoveObjectAtIndex:)];
        [obj swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(wj_safeReplaceObjectAtIndex:withObject:)];
    });
}

- (void)wj_safeAddObject:(id)anObject
{
    if (anObject) {
        [self wj_safeAddObject:anObject];
    }else{
        NSLog(@"obj is nil");
        
    }
}

- (id)wj_safeObjectAtIndex:(NSInteger)index
{
    if(index<[self count]){
        return [self wj_safeObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds ");
    }
    return nil;
}

- (void)wj_safeInsertObject:(id)anObject atIndex:(NSInteger)index
{
    if (index >= 0 || (index < [self count])) {
        
        [self wj_safeInsertObject:anObject atIndex:index];
        
    }else{
        
       NSLog(@"index is beyond bounds ");
        
    }
}

- (void)wj_safeRemoveObjectAtIndex:(NSInteger)index
{
    if (index >= 0 || (index < [self count])) {
        
        [self wj_safeRemoveObjectAtIndex:index];
        
    }else{
        
        NSLog(@"index is beyond bounds ");
        
    }
}

- (void)wj_safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)anObject
{
    
    if (anObject) {
        
        if (index >= 0 || (index < [self count])) {
            
            [self wj_safeReplaceObjectAtIndex:index withObject:anObject];
            
        }else{
            
            NSLog(@"index is beyond bounds ");
            
        }
        
    }else{
        NSLog(@"obj is nil");
        
    }
}

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    if (to != from) {
        id obj = [self safeObjectAtIndex:from];
        [self removeObjectAtIndex:from];
        
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
    }
}

- (NSMutableArray * _Nonnull)reversedArray {
    return (NSMutableArray *)[NSArray reversedArray:self];
}

+ (NSMutableArray * _Nonnull)sortArrayByKey:(NSString * _Nonnull)key array:(NSMutableArray * _Nonnull)array ascending:(BOOL)ascending {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    [tempArray addObjectsFromArray:array];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:@[descriptor]];
    
    [tempArray removeAllObjects];
    tempArray = (NSMutableArray *)sortedArray;
    
    [array removeAllObjects];
    [array addObjectsFromArray:tempArray];
    
    return array;
}

@end

