//
//  FSGetViewController.m
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/2.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "FSGetViewController.h"
#import "FSTableViewCell.h"
#import "FSGetViewModel.h"
#import "FSWebViewController.h"
#import "FSWKWebViewController.h"

#define kGetDataURL @"https://api.jiefu.tv/app2/api/article/list.html?mediaType=2&deviceCode=6EE4FB649FAF4D0EB99754F1E3F49DF0&token=&pageNum=2&pageSize=20"
#define kCellIdeitifier @"FSTableViewCell"

@interface FSGetViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FSGetViewModel *viewModel;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FSGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"GetData";
    self.view.backgroundColor = [UIColor whiteColor];
    _viewModel = [[FSGetViewModel alloc] init];
    [self sendRequest];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:kCellIdeitifier bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:kCellIdeitifier];
    [self.view addSubview:_tableView];
}

- (void)sendRequest {
    NSURL *url = [NSURL URLWithString:kGetDataURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self dataToDictionary:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
    [task resume];
}

- (void)dataToDictionary:(NSData *)data {
    if(data == nil) {
        return ;
    }
    NSError *jsonError;
    NSDictionary *dicitonary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
    [_viewModel updateModel:dicitonary];
}

#pragma mark: UITableVeiwDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdeitifier forIndexPath:indexPath];
    [cell setupWithModel:[_viewModel cellModelAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *urlString = [_viewModel getValue:@"url" ofIndex:indexPath.row];
    //TODO:更换成https就有问题，需要处理请求https的情况
//    if([urlString containsString:@"http"]) {
//        urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
//    }
    FSWebViewController *detailVC = [[FSWebViewController alloc] initWithURL:urlString];
    [self.navigationController pushViewController:detailVC animated:false];
    // TODO:暂时不处理WKWebView
//    FSWKWebViewController *detailVC = [[FSWKWebViewController alloc] initWithURL:urlString];
}

@end
