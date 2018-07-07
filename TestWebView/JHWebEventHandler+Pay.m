//
//  JHWebEventHandler+Pay.m
//  TestWebView
//
//  Created by zhongan on 2018/7/8.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWebEventHandler+Pay.h"

@implementation JHWebEventHandler (Pay)

- (void)pay:(NSDictionary *)data {
    NSLog(@"----pay----");
    
    //回调
    NSString *jsStr = [NSString stringWithFormat:@"payCallback('%@')", @"payCallback回调"];
    [self evaluatingJavaScript:jsStr];
}

@end
