//
//  UIAlertController+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertControllerPopoverPresentationControllerBlock) (UIPopoverPresentationController * __nonnull popover);
typedef void (^UIAlertControllerCompletionBlock) (UIAlertController * __nonnull controller, UIAlertAction * __nonnull action, NSInteger buttonIndex);

@interface UIAlertController (WJCategory)


+ (nonnull instancetype)wj_showInViewController:(nonnull UIViewController *)viewController
                                      withTitle:(nullable NSString *)title
                                        message:(nullable NSString *)message
                                 preferredStyle:(UIAlertControllerStyle)preferredStyle
                              cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                         destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                              otherButtonTitles:(nullable NSArray *)otherButtonTitles
             popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                                       tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nonnull instancetype)wj_showAlertInViewController:(nonnull UIViewController *)viewController
                                           withTitle:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                   cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                              destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                   otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                            tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nonnull instancetype)wj_showActionSheetInViewController:(nonnull UIViewController *)viewController
                                                 withTitle:(nullable NSString *)title
                                                   message:(nullable NSString *)message
                                         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                    destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                         otherButtonTitles:(nullable NSArray *)otherButtonTitles
                        popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                                                  tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

@property (readonly, nonatomic) BOOL wj_visible;
@property (readonly, nonatomic) NSInteger wj_cancelButtonIndex;
@property (readonly, nonatomic) NSInteger wj_firstOtherButtonIndex;
@property (readonly, nonatomic) NSInteger wj_destructiveButtonIndex;

@end
