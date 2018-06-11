//
//  FSWKWebViewController.m
//  FSNetWorkDemo
//
//  Created by zhichang.he on 2018/6/9.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "FSWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface FSWKWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation FSWKWebViewController

- (instancetype)initWithURL:(NSString *)urlString {
    if(self = [super init]) {
        NSURL *url = [NSURL URLWithString:urlString];
        _request = [NSURLRequest requestWithURL:url];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.mediaTypesRequiringUserActionForPlayback =  WKAudiovisualMediaTypeVideo;
//        config setURLSchemeHandler:<#(nullable id<WKURLSchemeHandler>)#> forURLScheme:<#(nonnull NSString *)#>
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
//        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView.frame = self.view.bounds;
    [_webView loadRequest:_request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark: WKNavigationDelegate

@end
