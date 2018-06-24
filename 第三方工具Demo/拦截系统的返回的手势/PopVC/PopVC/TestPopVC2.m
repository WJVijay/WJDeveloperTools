//
//  TestPopVC2.m
//  PopVC
//
//  Created by ymm_iMac on 2017/2/9.
//  Copyright © 2017年 HR_iMac. All rights reserved.
//

#import "TestPopVC2.h"
#import "TestPop1VC1.h"
@interface TestPopVC2 ()

@end

@implementation TestPopVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TestPopVC2";
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(method) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view.
}

- (void)method {
    [self.navigationController pushViewController:[[TestPop1VC1 alloc]init] animated:YES];
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
