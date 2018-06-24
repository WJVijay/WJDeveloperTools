//
//  PickerGroupViewController.h
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPickerViewController.h"

@interface ZLPickerGroupViewController : UIViewController

@property (nonatomic , weak) id<ZLPickerViewControllerDelegate> delegate;
@property (nonatomic , assign) PickerViewShowStatus status;
@property (nonatomic , assign) NSInteger minCount;


@end
