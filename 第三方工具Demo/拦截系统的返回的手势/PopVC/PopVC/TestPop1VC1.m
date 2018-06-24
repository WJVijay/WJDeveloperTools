//
//  TestPop1VC1.m
//  PopVC
//
//  Created by ymm_iMac on 2017/2/9.
//  Copyright © 2017年 HR_iMac. All rights reserved.
//

#import "TestPop1VC1.h"
#import "TestPopVC2.h"
@interface TestPop1VC1 ()

@end

@implementation TestPop1VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TestPop1VC1";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(method) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

- (void)method {
     [self.navigationController pushViewController:[[TestPopVC2 alloc]init] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
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
