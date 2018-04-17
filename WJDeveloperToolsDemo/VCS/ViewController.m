//
//  ViewController.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+WJMethodSwizzling.h"
#import "HUBDetailVC.h"
#import "ClickMenuVC.h"
#import "User.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listArray = @[@"加载弹窗",@"点击出现菜单"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.defaultCellIndentifier];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.defaultCellIndentifier];
        
    }
    cell.textLabel.text = self.listArray[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        HUBDetailVC *dVC = [[HUBDetailVC alloc]init];
        [self.navigationController pushViewController:dVC animated:YES];
        
    }else if (indexPath.row == 1){
        
        ClickMenuVC *mVC = [[ClickMenuVC alloc]init];
        [self.navigationController pushViewController:mVC animated:YES];
    }
   
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
