//
//  HUBDetailVC.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "HUBDetailVC.h"


@interface HUBDetailVC ()

@property (nonatomic, assign) CGFloat percent;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HUBDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listArray = @[@"type11111",@"type22222",@"type333333",@"type444444",@"type555555",@"type666666"];
    
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
    
    
    NSString *currentTitle = self.listArray[indexPath.row];
    if (indexPath.row == 0) {
        
        [self showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });
    }else if (indexPath.row == 1){
        
        
        [self showText:currentTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });
        
    }else if (indexPath.row == 2){
        
        [self showErrorText:currentTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });
        
    }else if (indexPath.row == 3){
        
        [self showSuccessText:currentTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });
        
    }else if (indexPath.row == 4){
        
        self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(showPercent) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        
    }else if (indexPath.row == 5){
        
        [self showImage:[UIImage imageNamed:@"emj"] text:currentTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });
        
    }else{
        
        
    }
    
}


- (void)showPercent
{
    self.percent += 5;
    [self showProgress:self.percent];
    
    if (self.percent == 100) {
        [self.timer invalidate];
        self.timer = nil;
        [self dismissLoading];
    }
}

@end
