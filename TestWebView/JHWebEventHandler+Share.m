//
//  JHWebEventHandler+Share.m
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWebEventHandler+Share.h"

@implementation JHWebEventHandler (Share)

- (void)addShare {
    __weak id weakSelf = self;
    [self addAction:@"share" handler:^(NSArray *params) {
        [weakSelf handleShare:params];
    }];
}

- (void)handleShare:(NSArray *)params {
    NSLog(@"----share----");
    
    //回调
    NSString *jsStr = [NSString stringWithFormat:@"setShare('%@')", @"Share回调"];
    [[JSContext currentContext] evaluateScript:jsStr];
}

@end
