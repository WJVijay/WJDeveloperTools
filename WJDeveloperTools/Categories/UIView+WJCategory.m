//
//  UIView+WJSetOriginExtension.m
//  WJBS
//
//  Created by vijay on 2017/4/2.
//  Copyright © 2017年 vijay. All rights reserved.
//

#import "UIView+WJCategory.h"
#import <objc/runtime.h>


@implementation UIView (WJCategory)
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)setWj_x:(CGFloat)wj_x{
    CGRect frame = self.frame;
    frame.origin.x = wj_x;
    self.frame = frame;
}
- (CGFloat)wj_x{
    
    return self.frame.origin.x;

}

- (void)setWj_y:(CGFloat)wj_y{
    
    CGRect frame = self.frame;
    frame.origin.y = wj_y;
    self.frame = frame;
    
}

-(CGFloat)wj_y{
    
    return self.frame.origin.y;
}

-(void)setWj_width:(CGFloat)wj_width{
    
    CGRect frame = self.frame;
    frame.size.width = wj_width;
    self.frame = frame;
}
- (CGFloat)wj_width{
    
    return self.frame.size.width;
}

- (void)setWj_height:(CGFloat)wj_height{
    
    CGRect frame = self.frame;
    frame.size.height = wj_height;
    self.frame = frame;

}

- (CGFloat)wj_height{
    
    return self.frame.size.height;
}

- (void)setWj_centerX:(CGFloat)wj_centerX{
    
    CGPoint center = self.center;
    center.x = wj_centerX;
    self.center = center;

}

- (CGFloat)wj_centerX{
    
    return self.center.x;
}

- (void)setWj_centerY:(CGFloat)wj_centerY{
    
    CGPoint center = self.center;
    center.y = wj_centerY;
    self.center = center;
}

- (CGFloat)wj_centerY{
    
    return self.center.y;
}


- (void)setWj_size:(CGSize)wj_size{
    
    CGRect frame = self.frame;
    frame.size = wj_size;
    self.frame = frame;
}

- (CGSize)wj_size{
    
    return self.frame.size;
    
}

- (void)setWj_origin:(CGPoint)wj_origin{
    
    CGRect frame = self.frame;
    frame.origin = wj_origin;
    self.frame = frame;
}

- (CGPoint)wj_origin{
    
    return self.frame.origin;
}

- (void)setWj_top:(CGFloat)wj_top{
    
    CGRect frame = self.frame;
    frame.origin.y = wj_top;
    self.frame = frame;
}

- (CGFloat)wj_top{
    
    return self.frame.origin.y;
}

- (void)setWj_left:(CGFloat)wj_left{
    
    CGRect frame = self.frame;
    frame.origin.x = wj_left;
    self.frame = frame;
    
}

- (CGFloat)wj_left{
    
    return self.frame.origin.x;
    
}


- (void)setWj_bottom:(CGFloat)wj_bottom{
    
    CGRect frame = self.frame;
    frame.origin.y = wj_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)wj_bottom{
    
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setWj_right:(CGFloat)wj_right{
    
    CGRect frame = self.frame;
    frame.origin.x = wj_right - frame.size.width;
    self.frame = frame;

}

- (CGFloat)wj_right{
    
    return self.frame.size.width + self.frame.origin.x;
}

#pragma mark - layer
- (void)rounded:(CGFloat)cornerRadius {
    [self rounded:cornerRadius width:0 color:nil];
}

- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor {
    [self rounded:0 width:borderWidth color:borderColor];
}

- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}


-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    //给Cell设置阴影效果
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}


#pragma mark - base
- (UIViewController *)viewController {
    
    id nextResponder = [self nextResponder];
    while (nextResponder != nil) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)nextResponder;
            return vc;
        }
        nextResponder = [nextResponder nextResponder];
    }
    return nil;
}

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)frameSet:(NSString *)key value:(CGFloat)value
{
    CGRect rect = self.frame;
    
    if ([@"x" isEqualToString:key]) {
        rect.origin.x = value;
        
    } else if ([@"y" isEqualToString:key]) {
        rect.origin.y = value;
        
    } else if ([@"w" isEqualToString:key]) {
        rect.size.width = value;
        
    } else if ([@"h" isEqualToString:key]) {
        rect.size.height = value;
    }
    
    self.frame = rect;
}

- (void)frameSet:(NSString *)key1 value1:(CGFloat)value1 key2:(NSString *)key2 value2:(CGFloat)value2
{
    [self frameSet:key1 value:value1];
    [self frameSet:key2 value:value2];
}

/**
 *  从 bundle 加载一个 view
 *
 *  @param name 名字
 *
 *  @return 返回一个 view
 */
+ (instancetype)viewFromBundle
{
    NSString *className = NSStringFromClass([self class]);
    id object = [[[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil]lastObject];
    if ([object isKindOfClass:[self class]]) {
        return object;
    }
    return  nil;
}




@end
