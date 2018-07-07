//
//  JHWebEventHandler.h
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

@interface JHWebEventHandler : NSObject

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WKWebView *wkWebView;

+ (instancetype)shareInstance;

- (void)addAction:(NSString *)name handler:(void (^)(NSArray *params))handler;

- (void)evaluatingJavaScript:(NSString *)jsStr;

@end
