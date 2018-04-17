

#ifndef Single_h
#define Single_h

#ifdef __OBJC__

#pragma mark - 单例模式 .h文件内容
#define WJSingleInterface(name) +(instancetype)share##name;


#pragma mark - 单例模式 .m文件内容
#if __has_feature(objc_arc)
#define WJSingleImplementation(name) +(instancetype)share##name {return [[self alloc]init];} \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static id instance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone{return self;} \
- (id)mutableCopyWithZone:(NSZone *)zone {return self;}

#else

#define WJSingleImplementation(name) +(instancetype)share##name {return [[self alloc]init];} \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static id instance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone{return self;} \
- (id)mutableCopyWithZone:(NSZone *)zone {return self;} \
- (instancetype)retain {return self;} \
- (instancetype)autorelease {return self;} \
- (oneway void)release {} \
- (NSUInteger)retainCount {return MAXFLOAT;} \

#endif

#endif

#endif /* Single_h */
