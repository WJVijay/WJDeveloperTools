//
//  UIViewController+WJMethodSwizzling.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UIViewController+WJMethodSwizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (WJMethodSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        
        [obj swizzleMethod:@selector(viewDidLoad) withMethod:@selector(wj_viewDidLoad)];
        [obj swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(wj_viewWillAppear:)];
        [obj swizzleMethod:@selector(viewDidAppear:) withMethod:@selector(wj_viewDidAppear:)];
        [obj swizzleMethod:@selector(viewWillDisappear:) withMethod:@selector(wj_viewWillDisappear:)];
        [obj swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(wj_viewDidDisappear:)];
        [obj swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(wj_viewDidDisappear:)];
        [obj swizzleMethod:@selector(didReceiveMemoryWarning) withMethod:@selector(wj_didReceiveMemoryWarning)];
        
        Method m1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method m2 = class_getInstanceMethod([self class], @selector(wj_dealloc));
        
        method_exchangeImplementations(m1, m2);
        
    });
}

- (void)wj_dealloc
{
    NSLog(@"-----------控制器:%@销毁了------------",NSStringFromClass([self class]));
    [self wj_dealloc];
}

- (void)wj_viewDidLoad{
    
    WJLog(@"wj_viewDidLoad");
    [self wj_viewDidLoad];
}

- (void)wj_viewWillAppear:(BOOL)animated{
    
    WJLog(@"wj_viewWillAppear");
    
    [self wj_viewWillAppear:animated];
}

- (void)wj_viewDidAppear:(BOOL)animated{
    
    WJLog(@"wj_viewDidAppear");
    [self wj_viewDidAppear:animated];
}

- (void)wj_viewWillDisappear:(BOOL)animated{
    
    WJLog(@"wj_viewWillDisappear");
    [self wj_viewWillDisappear:animated];
}

- (void)wj_viewDidDisappear:(BOOL)animated{
    
    WJLog(@"wj_viewDidDisappear");
    [self wj_viewDidDisappear:animated];
}

- (void)wj_didReceiveMemoryWarning {
    
    WJLog(@"wj_didReceiveMemoryWarning");
    [self wj_didReceiveMemoryWarning];
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


@end
