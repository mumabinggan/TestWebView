//
//  JHWebEventHandler.m
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWebEventHandler.h"
#import "JHWebEventHandler+Location.h"

@implementation JHWebEventHandler

+ (instancetype)shareInstance {
    static JHWebEventHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JHWebEventHandler alloc] init];
    });
    return instance;
}

// for context
- (void)addAction:(NSString *)name handler:(void (^)(NSArray *params))handler {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[name] = ^() {
        if (handler) {
            handler([JSContext currentArguments]);
        }
    };
}

- (void)evaluatingJavaScript:(NSString *)jsStr {
    if (self.webView) {
        [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
    }
    else {
        [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"run js error:%@",error);
            }
            
        }];
    }
}

@end
