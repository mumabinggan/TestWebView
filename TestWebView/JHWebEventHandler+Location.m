//
//  JHWebEventHandler+Location.m
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWebEventHandler+Location.h"

@implementation JHWebEventHandler (Location)

- (void)getLocation:(NSDictionary *)data {
    NSLog(@"----getLocation----");
    
    //回调
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')", @"getLocation回调"];
    [self evaluatingJavaScript:jsStr];
}

@end
