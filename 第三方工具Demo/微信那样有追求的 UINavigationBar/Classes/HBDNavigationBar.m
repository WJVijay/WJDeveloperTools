//
//  HBDNavigationBar.m
//  HBDNavigationBar
//
//  Created by Listen on 2018/3/23.
//

#import "HBDNavigationBar.h"

@interface HBDNavigationBar()

@property (nonatomic, strong, readwrite) UIImageView *shadowImageView;
@property (nonatomic, strong, readwrite) UIVisualEffectView *fakeView;

@end

@implementation HBDNavigationBar

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    
    UIView *view = [super hitTest:point withEvent:event];
    NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
    
    if (view && [viewName isEqualToString:@"HBDNavigationBar"]) {
        for (UIView *subview in self.subviews) {
            NSString *viewName = [[[subview classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
            NSArray *array = @[ @"UINavigationItemButtonView" ];
            if ([array containsObject:viewName]) {
                CGPoint convertedPoint = [self convertPoint:point toView:subview];
                CGRect bounds = subview.bounds;
                if (bounds.size.width < 80) {
                    bounds = CGRectInset(bounds, bounds.size.width - 80, 0);
                }
                if (CGRectContainsPoint(bounds, convertedPoint)) {
                    return view;
                }
            }
        }
    }
    
    NSArray *array = @[ @"UINavigationBarContentView", @"HBDNavigationBar" ];
    if ([array containsObject:viewName]) {
        if (self.fakeView.alpha < 0.01) {
            return nil;
        }
    }
    
    if (CGRectEqualToRect(view.bounds, CGRectZero)) {
        return nil;
    }
    
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.fakeView.frame = self.fakeView.superview.bounds;
    self.shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.shadowImageView.superview.bounds), CGRectGetWidth(self.shadowImageView.superview.bounds), 0.5);
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    [super setBarTintColor:barTintColor];
    self.fakeView.subviews[1].backgroundColor =  barTintColor;
}

- (UIView *)fakeView {
    if (!_fakeView) {
        [super setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        _fakeView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _fakeView.userInteractionEnabled = NO;
        _fakeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
       [[self.subviews firstObject] insertSubview:_fakeView atIndex:0];
    }
    return _fakeView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    
}

- (void)setShadowImage:(UIImage *)shadowImage {
    self.shadowImageView.image = shadowImage;
    if (shadowImage) {
        self.shadowImageView.backgroundColor = nil;
    } else {
        self.shadowImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:77.0/255];
    }
}

- (UIImageView *)shadowImageView {
    if (!_shadowImageView) {
        [super setShadowImage:[UIImage new]];
        _shadowImageView = [[UIImageView alloc] init];
        _shadowImageView.userInteractionEnabled = NO;
        _shadowImageView.contentScaleFactor = 1;
        [[self.subviews firstObject] insertSubview:_shadowImageView aboveSubview:self.fakeView];
    }
    return _shadowImageView;
}

@end

