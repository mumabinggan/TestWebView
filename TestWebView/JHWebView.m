//
//  JHWebView.m
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWebView.h"
#import "JHWebEventDispatch.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JHBaseWebEventParam.h"
#import <YYModel/YYModel.h>

@interface JHWebView ()

@property (nonatomic, strong) UIWebView *webView;

@end

@interface JHWebView (WebViewDelegate) <UIWebViewDelegate>

@end

@implementation JHWebView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    [self addSubview:self.webView];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.frame];
        _webView.delegate = self;
        self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    return _webView;
}

- (void)requestWithURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (NSString *)evaluatingJavaScriptFromString:(NSString *)string {
    return [self.webView stringByEvaluatingJavaScriptFromString:string];
}

@end

@implementation JHWebView (WebViewDelegate)

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL canReply = NO;
    if (_interactionType == JHUIWebInteractionTypeIFrame) {
        canReply = [JHWebEventDispatch canReplyEventDispatch:request.URL];
        if (canReply) {
            [JHWebEventDispatch handleWebEvent:webView url:request.URL];
        }
    }
    BOOL subDeal = YES;
    if ([_delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        subDeal = [_delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return !canReply && subDeal;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([_delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        return [_delegate webViewDidStartLoad:self];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (_interactionType == JHUIWebInteractionTypeContext) {
        [JHWebEventDispatch addWebEventActions:webView];
    }
    if ([_delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        return [_delegate webViewDidFinishLoad:self];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([_delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        return [_delegate webView:self didFailLoadWithError:error];
    }
}

@end
