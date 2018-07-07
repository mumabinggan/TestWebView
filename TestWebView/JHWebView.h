//
//  JHWebView.h
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHWebView;

typedef NS_ENUM(NSInteger, JHUIWebInteractionType) {
    JHUIWebInteractionTypeIFrame,     //iFrame原理触发
    JHUIWebInteractionTypeContext,     //JSContext原理
};

@protocol JHWebViewDelegate <NSObject>
@optional

- (BOOL)webView:(JHWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(JHWebView *)webView;
- (void)webViewDidFinishLoad:(JHWebView *)webView;
- (void)webView:(JHWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface JHWebView : UIView

@property (nonatomic, assign) JHUIWebInteractionType interactionType;

@property (nonatomic, assign) id<JHWebViewDelegate> delegate;

- (void)requestWithURL:(NSURL *)url;

- (NSString *)evaluatingJavaScriptFromString:(NSString *)string;

@end
