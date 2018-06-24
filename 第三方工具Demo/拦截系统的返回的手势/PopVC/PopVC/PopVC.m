//
//  PopVC.m
//  PopVC
//
//  Created by ymm_iMac on 2017/2/9.
//  Copyright © 2017年 HR_iMac. All rights reserved.
//

#import "PopVC.h"

@interface PopVC ()
@property (nonatomic, strong) UIView *navPopView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@end

@implementation PopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIGestureRecognizer *gesture = self.navigationController.interactivePopGestureRecognizer;
//    NSLog(@"gesture: %@", gesture);
    UIView *navPopView = gesture.view;
    self.navPopView = navPopView;
    
    id targets = [gesture valueForKey:@"_targets"];
//    NSLog(@"targets: %@", targets);
    //获取手势
    id targetObjc = [targets firstObject];
//    NSLog(@"targetObjc: %@", targetObjc);
    //获取手势的target
    id target = [targetObjc valueForKey:@"target"];
//    NSLog(@"target: %@", target);
//直接崩溃
    {
//    id action = [targetObjc valueForKey:@"action"];
//    NSLog(@"action: %@", action);
    }
    //获取手势绑定的方法SEL
    SEL sel = NSSelectorFromString(@"handleNavigationTransition:");
//    NSLog(@"sel: %p", &sel);
    //将系统手势返回的target和SEL绑定到自定义的pan手势上
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:sel];
    self.pan = pan;
//    [navPopView addGestureRecognizer:pan];
    NSLog(@"---%s----%@", __PRETTY_FUNCTION__, [navPopView valueForKey:@"gestureRecognizers"]);
    
    // Do any additional setup after loading the view.
}
//pan手势会重复添加,需要在viewDidDisappear的时候移除
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_navPopView removeGestureRecognizer:_pan];
    NSLog(@"viewDidDisappear--%s--%@", __PRETTY_FUNCTION__,[_navPopView valueForKey:@"gestureRecognizers"]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_navPopView addGestureRecognizer:_pan];
    NSLog(@"viewDidDisappear--%s--%@", __PRETTY_FUNCTION__,[_navPopView valueForKey:@"gestureRecognizers"]);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
