//
//  LabelShowVC.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/6/11.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "LabelShowVC.h"
#import "WJLabel.h"

@interface LabelShowVC ()

@property (strong, nonatomic)WJLabel *label;

@property (strong, nonatomic)UIButton *showBtn;

@end

@implementation LabelShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label = [[WJLabel alloc]init];
    _label.backgroundColor = [UIColor redColor];
    _label.frame = CGRectMake(15, 200, 375-30, 0);
    _label.textAlignment = NSTextAlignmentJustified;
    _label.limitRows=3;
    _label.text = @"ASJDLFSJDKLFJDLSKJFKLASajskldfjdkaslfjklasdjfklasdjfklsdjaklfjdsklfjkASJDLFSJDKLFJDLSKJFKLASajskldfjdkaslfjklasdjfklasdjfklsdjaklfjdsklfjklsdj1111111111111111ASJDLFSJDKLFJDLSKJFKLASajskldfjdkaslfjklasdjfklasdjfklsdjaklfjdsklfjklsdj";
    
    [_label settedPropertiesUpdate];
    [self.view addSubview:_label];
    self.showBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.showBtn.backgroundColor = [UIColor redColor];
    if (_label.strRows >3) {
        self.showBtn.hidden = NO;
        _label.numberOfLines = 3;
    }else{
        self.showBtn.hidden = YES;
        _label.numberOfLines = 0;
    }
    self.showBtn.frame = CGRectMake(CGRectGetMaxX(_label.frame)-80,CGRectGetMaxY(_label.frame), 80, 17);
    [self.showBtn addTarget:self action:@selector(showClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.showBtn setTitle:@"展开" forState:UIControlStateNormal];
    [self.showBtn setTitle:@"收起" forState:UIControlStateSelected];
    [self.view addSubview:self.showBtn];
    
}

- (void)showClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        _label.numberOfLines = 0;
        NSLog(@"0");
    }else{
        
        NSLog(@"3");
        _label.numberOfLines = 3;
    }
    self.showBtn.frame = CGRectMake(CGRectGetMaxX(_label.frame)-80,CGRectGetMaxY(_label.frame), 80, 17);
    [self.view setNeedsLayout];
}

@end
