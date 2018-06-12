//
//  FSDetailViewController.m
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "FSWebViewController.h"
#import "FSNetwork.h"

@interface FSWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, assign) BOOL authenticated;

@end

@implementation FSWebViewController

- (instancetype)initWithURL:(NSString *)urlString {
    if(self = [super init]) {
        NSURL *url = [NSURL URLWithString:urlString];
        _request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5];
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView.frame = self.view.bounds;
    [_webView loadRequest: _request];
    [self.view addSubview:_webView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)close:(id)sender {
    if([_webView canGoBack]) {
        [_webView goBack];
    }
    else {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark: UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
//    if(!_authenticated) {
//        _authenticated = NO;
//        [[FSNetwork manager] sendRqeust:request callBack:^(BOOL isAuthenticated) {
//            self.authenticated = isAuthenticated;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.webView loadRequest:_request];
//            });
//        }];
//        return NO;
//    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if(error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self close:action];
        }]];
        [self presentViewController:alert animated:NO completion:nil];
    }
}

@end
