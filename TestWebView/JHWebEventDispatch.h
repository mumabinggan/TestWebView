//
//  JHWebEventDispatch.h
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "JHWKWebView.h"

@interface JHWebEventDispatch : NSObject

@end

@interface JHWebEventDispatch (IFrame)

+ (BOOL)canReplyEventDispatch:(NSURL *)url;

+ (void)handleWebEvent:(UIView *)webView url:(NSURL *)url;

@end

@interface JHWebEventDispatch (Context)

+ (void)addWebEventActions:(UIWebView *)webView;

@end

@interface JHWebEventDispatch (MessageHandler)

+ (void)addWebScriptMessageHandlers:(JHWKWebView *)webView;

+ (void)handleScriptMessageHandler:(WKWebView *)webView name:(NSString *)name body:(NSDictionary *)body;

@end
