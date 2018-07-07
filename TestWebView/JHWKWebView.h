//
//  JHWKWebView.h
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class JHWKWebView;

typedef NS_ENUM(NSInteger, JHWKWebInteractionType) {
    JHWKWebInteractionTypeIFrame,     //iFrame原理触发
    JHWKWebInteractionTypeMessageHandler,     //MessageHandler原理
};

@protocol JHWKWebViewDelegate <NSObject>
@optional
- (void)webView:(JHWKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

- (void)webView:(JHWKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

- (void)webView:(JHWKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

- (void)webView:(JHWKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

- (void)webView:(JHWKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

- (void)webView:(JHWKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;

- (void)webView:(JHWKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;

- (void)webView:(JHWKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

- (void)webView:(JHWKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;

- (void)webViewWebContentProcessDidTerminate:(JHWKWebView *)webView;


- (nullable WKWebView *)webView:(JHWKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

- (void)webViewDidClose:(JHWKWebView *)webView;

- (void)webView:(JHWKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;

- (void)webView:(JHWKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;

- (void)webView:(JHWKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler;

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface JHWKWebView : UIView

@property (nonatomic, strong, readonly) WKWebView *webView;

@property (nonatomic, assign) JHWKWebInteractionType interactionType;

@property (nonatomic, assign) id<JHWKWebViewDelegate> delegate;

- (void)requestWithURL:(NSURL *)url;

- (void)evaluatingJavaScriptFromString:(NSString *)string;

@end

@interface JHWKWebView (WKWebViewDelegate) <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@end
