//
//  ViewController.m
//  PPHTMLImagePreviewDemo
//
//  Created by StarNet on 7/22/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+WebCache.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    self.imagePreviewButton.alpha = 0.0f;
    
    [self onLoadButtonPressed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onImagePreviewButtonPressed:(id)sender {
    [UIView animateWithDuration:0.2f animations:^{
        self.imagePreviewButton.alpha = 0.0f;
    }];
}

- (IBAction)onLoadButtonPressed:(id)sender {
    NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlTextField.text]];
    [self.webView reload];
    [self.webView loadRequest:req];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSLog(@"scheme = %@",request.URL.scheme);
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [self.imagePreviewButton sd_setImageWithURL:[NSURL URLWithString:path] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
        
        [UIView animateWithDuration:0.2f animations:^{
            self.imagePreviewButton.alpha = 1.0f;
        }];
        
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView stringByEvaluatingJavaScriptFromString:@"function assignImageClickAction(){var imgs=document.getElementsByTagName('img');var length=imgs.length;for(var i=0;i<length;i++){img=imgs[i];img.onclick=function(){window.location.href='image-preview:'+this.src}}}"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"assignImageClickAction();"];
}

@end
