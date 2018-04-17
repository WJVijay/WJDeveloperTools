//
//  WJTableViewController.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJTableViewController.h"
#import "WJDefineHeader.h"

@interface WJTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)NSMutableArray                *rCellIdentifers;

@end

static NSString *defaultCellIndentifier = @"UITableViewCell";

@implementation WJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kSCREENWIDTH, kSCREENHEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIndentifier];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellIndentifier];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)registCellWithcellNameArr:(NSArray <NSString *>*)cellName WithSelf:(Class)selfClass{
    
    if (cellName.count != 0 && selfClass) {
        
        for (int i = 0; i < cellName.count; i ++) {
            
            NSString *identifier = NSStringFromClass(selfClass);
            NSString *identifierStr = [NSString stringWithFormat:@"%@%d",identifier,0x10+i];
            [self.rCellIdentifers addObject:identifierStr];
            NSString *className = cellName[i];
            Class class = NSClassFromString(className);
            if (class) {
                [self.tableView registerClass:class forCellReuseIdentifier:identifierStr];
            }
        }
        
        self.cellIdentifiers = self.rCellIdentifers.copy;
    }
}

- (void)registCellWithCellName:(NSString *)cellName WithSelf:(Class)selfClass{
    
    if (cellName.length != 0 && selfClass) {
        
        NSString *identifierStr = NSStringFromClass(selfClass);
        self.cellIdentifier = identifierStr;
        Class class = NSClassFromString(cellName);
        if (class) {
            [self.tableView registerClass:class forCellReuseIdentifier:identifierStr];
        }
        
    }
}

- (NSString *)defaultCellIndentifier{
    
    return defaultCellIndentifier;
}

- (NSMutableArray *)rCellIdentifers{
    
    if (_rCellIdentifers == nil) {
        _rCellIdentifers = [NSMutableArray array];
    }
    return _rCellIdentifers;
}

@end
