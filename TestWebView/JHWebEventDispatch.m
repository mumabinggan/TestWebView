//
//  JHWebEventDispatch.m
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWebEventDispatch.h"
#import <YYModel/YYModel.h>
#import "JHWebEventHandlerHeader.h"

#define kWebToOcScheme  @"mumabinggan"

@implementation JHWebEventDispatch

@end

@implementation JHWebEventDispatch (IFrame)

+ (BOOL)canReplyEventDispatch:(NSURL *)url {
    return [[url scheme] isEqualToString:kWebToOcScheme];
}

+ (void)handleWebEvent:(UIView *)webView url:(NSURL *)url {
    NSDictionary *paramsDic = [self params:url];
    NSString *host = [url host];
    NSString *selectorString = [NSString stringWithFormat:@"%@:", host];
    SEL selector = NSSelectorFromString(selectorString);
    JHWebEventHandler *instance = [JHWebEventHandler shareInstance];
    if ([webView isKindOfClass:[UIWebView class]]) {
        instance.webView = (UIWebView *)webView;
    }
    else if ([webView isKindOfClass:[WKWebView class]]) {
        instance.wkWebView = (WKWebView *)webView;
    }
    ((void (*)(id, SEL, id))[instance methodForSelector:selector])(instance, selector, paramsDic);
}

+ (NSDictionary *)params:(NSURL *)url {
    NSString *query = url.query;
    NSArray *array = [query componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    if (array.count % 2 != 0) {
        return nil;
    }
    for (int num = 0; num < array.count/2; ++num) {
        NSString *key = array[2 * num];
        NSString *value = array[2 * num + 1];
        [mDic setObject:value forKey:key];
    }
    return mDic;
}

@end

@implementation JHWebEventDispatch (Context)

+ (void)addWebEventActions:(UIWebView *)webView {
    JHWebEventHandler *instance = [JHWebEventHandler shareInstance];
    instance.webView = webView;
    //添加分享
    [instance addShare];
}

@end

@implementation JHWebEventDispatch (MessageHandler)

+ (void)addWebScriptMessageHandlers:(JHWKWebView *)webView {
    JHWebEventHandler *instance = [JHWebEventHandler shareInstance];
    instance.wkWebView = webView.webView;
    //添加分享
    [webView.webView.configuration.userContentController addScriptMessageHandler:webView name:@"pay"];
}

+ (void)handleScriptMessageHandler:(WKWebView *)webView name:(NSString *)name body:(NSDictionary *)body {
    NSString *selectorString = [NSString stringWithFormat:@"%@:", name];
    SEL selector = NSSelectorFromString(selectorString);
    JHWebEventHandler *instance = [JHWebEventHandler shareInstance];
    ((void (*)(id, SEL, id))[instance methodForSelector:selector])(instance, selector, body);
}

@end
