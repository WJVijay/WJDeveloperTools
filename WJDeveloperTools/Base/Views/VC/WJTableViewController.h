//
//  WJTableViewController.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJBaseViewController.h"

@interface WJTableViewController : WJBaseViewController <UITableViewDelegate,UITableViewDataSource>

/**
 tableiView
 */
@property ( strong, nonatomic) UITableView                      *tableView;

/**
 数据源
 */
@property ( strong, nonatomic) NSArray                          *listArray;

/**
 系统cell标识
 */
@property ( copy, nonatomic) NSString                           *defaultCellIndentifier;

/**
 注册单个cell的标识
 */
@property(copy,nonatomic)NSString                           *cellIdentifier;

/**
 注册多个cell的标识
 */
@property(strong,nonatomic)NSArray                          *cellIdentifiers;

/**
 赋值注册cell
 
 @param cellName cell
 @param selfClass 控制器
 */
- (void)registCellWithCellName:(NSString *)cellName WithSelf:(Class)selfClass;

/**
 注册多个cell
 
 @param cellName cell数组
 @param selfClass 控制器
 */
- (void)registCellWithcellNameArr:(NSArray <NSString *>*)cellName WithSelf:(Class)selfClass;


@end
