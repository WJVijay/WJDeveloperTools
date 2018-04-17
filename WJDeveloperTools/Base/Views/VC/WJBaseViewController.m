//
//  WJBaseViewController.m
//  AfterDemo
//
//  Created by Yuan Wang on 2018/4/13.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJBaseViewController.h"
//屏幕宽高
#define kSCREENWIDTH_WJBaseViewController [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT_WJBaseViewController [UIScreen mainScreen].bounds.size.height

@interface WJBaseViewController ()

@end

@implementation WJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.navigationTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 跳转
 
 @param classStr classStr description
 */
- (void)jumpToVCWithClassStr:(NSString *)classStr{
    
    if (classStr.length == 0)return;
    [self classFromString:classStr];
    
}

- (void)jumpToVCWithClassStrs:(NSArray <NSString *>*)classStrs withIndex:(NSInteger)index{
    
    if (classStrs.count == 0)return;
    NSString *className = classStrs[index];
    [self classFromString:className];
}

- (void)jumpToVCWithClassStr:(NSString *)classStr withInfo:(NSString *)info{
    
    if (classStr.length == 0)return;
    [self classFromString:classStr];
    if ([info isKindOfClass:[NSString class]]) {
        self.infoString = info;
    }else if ([info isKindOfClass:[NSDictionary class]]){
        self.infoDict = (NSDictionary *)info;
    }else if ([info isKindOfClass:[NSArray class]]){
        self.infoArray = (NSArray *)info;
    }else{
        NSLog(@"不支持该类型的数据");
    }
    
}

- (void)classFromString:classStr{
    
    Class class = NSClassFromString(classStr);
    if (class) {
        
        WJBaseViewController *vc = class.new;
//        self.currentVC = vc;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        NSLog(@"classStr is nil");
    }
}


- (id)superClass{
    
    NSArray *array = [self.navigationController viewControllers];
    if (array.count>=2) {
        
        const NSInteger index = array.count;
        return array[index-2];
        
    }else{
        NSLog(@"no superClass");
        return nil;
    }
    
}


-(void)screenShotAction{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kSCREENWIDTH_WJBaseViewController, kSCREENHEIGHT_WJBaseViewController), NO, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
}

@end
