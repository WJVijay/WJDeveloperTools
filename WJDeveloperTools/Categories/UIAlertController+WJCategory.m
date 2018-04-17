//
//  UIAlertController+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UIAlertController+WJCategory.h"

static NSInteger const UIAlertControllerBlocksCancelButtonIndex = 0;
static NSInteger const UIAlertControllerBlocksDestructiveButtonIndex = 1;
static NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex = 2;

@implementation UIAlertController (WJCategory)



+ (instancetype)wj_showInViewController:(UIViewController *)viewController
                              withTitle:(NSString *)title
                                message:(NSString *)message
                         preferredStyle:(UIAlertControllerStyle)preferredStyle
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
     popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
                               tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    UIAlertController *strongController = [self alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:preferredStyle];
    
    __weak UIAlertController *controller = strongController;
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action){
                                                                 if (tapBlock) {
                                                                     tapBlock(controller, action, UIAlertControllerBlocksCancelButtonIndex);
                                                                 }
                                                             }];
        [controller addAction:cancelAction];
    }
    
    if (destructiveButtonTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                                    style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction *action){
                                                                      if (tapBlock) {
                                                                          tapBlock(controller, action, UIAlertControllerBlocksDestructiveButtonIndex);
                                                                      }
                                                                  }];
        [controller addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {
        NSString *otherButtonTitle = otherButtonTitles[i];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action){
                                                                if (tapBlock) {
                                                                    tapBlock(controller, action, UIAlertControllerBlocksFirstOtherButtonIndex + i);
                                                                }
                                                            }];
        [controller addAction:otherAction];
    }
    
    if (popoverPresentationControllerBlock) {
        popoverPresentationControllerBlock(controller.popoverPresentationController);
    }
    
    [viewController presentViewController:controller animated:YES completion:nil];
    
    return controller;
}

+ (instancetype)wj_showAlertInViewController:(UIViewController *)viewController
                                   withTitle:(NSString *)title
                                     message:(NSString *)message
                           cancelButtonTitle:(NSString *)cancelButtonTitle
                      destructiveButtonTitle:(NSString *)destructiveButtonTitle
                           otherButtonTitles:(NSArray *)otherButtonTitles
                                    tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self wj_showInViewController:viewController
                               withTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert
                       cancelButtonTitle:cancelButtonTitle
                  destructiveButtonTitle:destructiveButtonTitle
                       otherButtonTitles:otherButtonTitles
      popoverPresentationControllerBlock:nil
                                tapBlock:tapBlock];
}

+ (instancetype)wj_showActionSheetInViewController:(UIViewController *)viewController
                                         withTitle:(NSString *)title
                                           message:(NSString *)message
                                 cancelButtonTitle:(NSString *)cancelButtonTitle
                            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                 otherButtonTitles:(NSArray *)otherButtonTitles
                                          tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self wj_showActionSheetInViewController:viewController
                                          withTitle:title
                                            message:message
                                  cancelButtonTitle:cancelButtonTitle
                             destructiveButtonTitle:destructiveButtonTitle
                                  otherButtonTitles:otherButtonTitles
                 popoverPresentationControllerBlock:nil
                                           tapBlock:tapBlock];
}

+ (instancetype)wj_showActionSheetInViewController:(UIViewController *)viewController
                                         withTitle:(NSString *)title
                                           message:(NSString *)message
                                 cancelButtonTitle:(NSString *)cancelButtonTitle
                            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                 otherButtonTitles:(NSArray *)otherButtonTitles
                popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
                                          tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self wj_showInViewController:viewController
                               withTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleActionSheet
                       cancelButtonTitle:cancelButtonTitle
                  destructiveButtonTitle:destructiveButtonTitle
                       otherButtonTitles:otherButtonTitles
      popoverPresentationControllerBlock:popoverPresentationControllerBlock
                                tapBlock:tapBlock];
}

#pragma mark -

- (BOOL)wj_visible
{
    return self.view.superview != nil;
}

- (NSInteger)wj_cancelButtonIndex
{
    return UIAlertControllerBlocksCancelButtonIndex;
}

- (NSInteger)wj_firstOtherButtonIndex
{
    return UIAlertControllerBlocksFirstOtherButtonIndex;
}

- (NSInteger)wj_destructiveButtonIndex
{
    return UIAlertControllerBlocksDestructiveButtonIndex;
}

@end
