//
//  JHWebViewController.m
//  TestWebView
//
//  Created by zhongan on 2018/7/7.
//  Copyright © 2018年 sss. All rights reserved.
//

#import "JHWebViewController.h"
#import <YYModel/YYModel.h>
#import "JHWebView.h"
#import "JHWKWebView.h"

@interface JHWebViewController ()

@property (nonatomic, strong) JHWebView *webView;

@property (nonatomic, strong) JHWKWebView *wkWebView;

@property (nonatomic, strong) UIButton *button;

@end

@implementation JHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubView];
}

- (void)initSubView {
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.button];
}

- (JHWebView *)webView {
    if (!_webView) {
        _webView = [[JHWebView alloc] initWithFrame:self.view.frame];
        _webView.interactionType = JHUIWebInteractionTypeIFrame;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
        [_webView requestWithURL:url];
    }
    return _webView;
}

- (JHWKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[JHWKWebView alloc] initWithFrame:self.view.frame];
        _wkWebView.interactionType = JHWKWebInteractionTypeIFrame;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
        [_wkWebView requestWithURL:url];
    }
    return _wkWebView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(250, 500, 50, 40)];
        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"oc调用js" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)touchBtn:(UIButton *)btn {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [mDic setObject:@"测试212" forKey:@"title"];
    [mDic setObject:@"callbackvalue" forKey:@"callback"];
    NSString *jsonStr = [mDic yy_modelToJSONString];
    NSString *jsStr = [NSString stringWithFormat:@"ocToJs('%@')", jsonStr];
    if (self.webView) {
        [self.webView evaluatingJavaScriptFromString:jsStr];
    }
    else {
        [self.wkWebView evaluatingJavaScriptFromString:jsStr];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
