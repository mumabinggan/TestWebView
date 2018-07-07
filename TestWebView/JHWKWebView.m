//
//  JHWKWebView.m
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWKWebView.h"
#import <WebKit/WebKit.h>
#import "JHWebEventDispatch.h"

@interface JHWKWebView ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JHWKWebView

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

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 15;
        configuration.preferences = preferences;
        _webView = [[WKWebView alloc] initWithFrame:self.frame configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        
    }
    return _webView;
}

- (void)requestWithURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)setInteractionType:(JHWKWebInteractionType)interactionType {
    _interactionType = interactionType;
    if (interactionType == JHWKWebInteractionTypeMessageHandler) {
        [JHWebEventDispatch addWebScriptMessageHandlers:self];
    }
}

- (void)evaluatingJavaScriptFromString:(NSString *)string {
    [self.webView evaluateJavaScript:string completionHandler:nil];
}

@end

@implementation JHWKWebView (WKWebViewDelegate)

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    BOOL canReply = [JHWebEventDispatch canReplyEventDispatch:navigationAction.request.URL];
    if (canReply) {
        [JHWebEventDispatch handleWebEvent:webView url:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if ([_delegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [_delegate webView:self decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (_interactionType == JHWKWebInteractionTypeMessageHandler) {
        [JHWebEventDispatch handleScriptMessageHandler:_webView name:message.name body:message.body];
    }
}

@end
