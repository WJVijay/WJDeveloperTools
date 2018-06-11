//
//  WJLabel.m
//  WJDemo
//
//  Created by vijay on 2018/6/9.
//  Copyright © 2018年 vijay. All rights reserved.
//

#import "WJLabel.h"
#import "UILabel+WJLabel.h"

@interface WJLabel(){
    
    CGRect rect ;
}

@property ( strong, nonatomic) NSArray *rowsWords;

@end

@implementation WJLabel

- (void)setText:(NSString *)text{
    
    [super setText:text];
    
}


- (void)settedPropertiesUpdate{
    
    rect = [self calculateHeight];
    self.strHeight = rect.size.height;
    self.strWidth = self.frame.size.width;
    self.rowsWords = [self getLinesArrayOfStringInLabel:self.text font:self.font andLableWidth:self.strWidth];
    self.strRows = self.rowsWords.count;
    NSLog(@"fdafafa--%ld",self.strRows);//行数
    CGRect labelFrame = self.frame;
    labelFrame.size.height = rect.size.height;
    self.frame = labelFrame;
    
}


- (CGRect)calculateHeight{
    
    CGRect cRect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil];
    return cRect;
}

- (void)setLimitRows:(NSUInteger)limitRows{
    
    _limitRows = limitRows;
    
}

- (void)setNumberOfLines:(NSInteger)numberOfLines{
    
    [super setNumberOfLines:numberOfLines];
    
    //方式一:改变label 高度
    CGRect labelFrame = self.frame;
    if (numberOfLines == 0) {
        
        labelFrame.size.height = rect.size.height;

    }else{
        
        CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
        labelFrame.size.height = textSize.height*self.limitRows;
        
        
    }
    self.frame = labelFrame;
    
    
    //方式二:截取字符串
    /*
     if (numberOfLines == 0) {
     
     NSMutableString *mulStr = [NSMutableString string];
     [self.rowsWords enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     [mulStr appendString:obj];
     }];
     self.text = mulStr;
     }else{
     NSMutableString *mulStr = [NSMutableString string];
     for (int i = 0; i <3; i++) {
     [mulStr appendString:self.rowsWords[i]];
     }
     self.text = mulStr;
     }
     [self sizeToFit];
     */
    
}

/*
 CGRect rect = [self calculateHeight];
 CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
 CGRect labelFrame = self.frame;
 if (self.strRows>self.limitRows) {
 NSLog(@">>>>>");
 labelFrame.size.height = textSize.height*self.limitRows;
 }else{
 NSLog(@"<<<===");
 labelFrame.size.height = rect.size.height;
 }
 */

@end
