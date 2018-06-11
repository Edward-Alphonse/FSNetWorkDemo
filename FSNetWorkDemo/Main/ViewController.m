//
//  ViewController.m
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/2.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "ViewController.h"
#import "SessionManager.h"
#import "SubViewController.h"
#import <objc/NSObjCRuntime.h>
#import <objc/runtime.h>

#define MARGIN_X 125
#define MARGIN_Y 100
#define MARGIN_BTN 20
#define BTN_WIDTH 100
#define BTN_HEIGHT 50
#define kCellIdentifier @"Identifier"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)SessionManager *sessionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"FSNetWork";
    _array = @[@"Post", @"Get", @"Download", @"Upload"];
    [self setupTableView];
    _sessionManager = [SessionManager manager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 44;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self.view addSubview:_tableView];
    
//    CGFloat startX = MARGIN_X;
//    CGFloat startY = MARGIN_Y;
//    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"POST", @"GET", @"DOWNLOAD", @"UPLOAD", nil];
//
//    for(int i = 0; i < array.count; i++)
//    {
//        NSString *text = [array objectAtIndex:i];
//        [self addBtnForView:self.view withText:text andFrame:CGRectMake(startX, startY, BTN_WIDTH, BTN_HEIGHT)];
//        startY += BTN_HEIGHT + MARGIN_BTN;
//    }
//
//    UISwitch *switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(startX, startY, BTN_WIDTH, BTN_HEIGHT)];
//    [self.view addSubview:switchBtn];
}

#pragma mark: UITableViewDelegate & UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *vcClassStr = [NSString stringWithFormat:@"FS%@ViewController", _array[indexPath.row]];
    NSString *newClassName = [NSString stringWithFormat:@"%@VC", _array[indexPath.row]];
    Class vcClass = NSClassFromString(vcClassStr);
    id viewController = [[vcClass alloc] init];
    if(viewController) {
        [self.navigationController pushViewController:viewController animated:true];
    }
}


- (void)addBtnForView:(UIView *) view withText:(NSString *)text andFrame:(CGRect)frame{
    NSString *selText = [NSString stringWithFormat:@"click%@Button:", text];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:frame];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:@"hzc" forState:UIControlStateSelected];
    [button addTarget:self action:NSSelectorFromString(selText) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    [view addSubview:button];
}

- (void)clickPOSTButton:(id)sender{
    //    [_sessionManager POST:@"http://120.25.226.186:32812/login"
    //               parameters:@"username=520it&pwd=520it&type=JSON"
    //                  success:^(NSData *data, NSURLResponse *response){
    //                      NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //                      NSLog(@"%@",string);
    //                  }failure:^(NSError *error){
    //                      NSLog(@"%@",error);
    //                  }];
    ////    [_sessionManager POST:@"http://120.25.226.186:32812/login" parameters:@"username=520it&pwd=520it&type=JSON"];
}

- (void)clickGETButton:(id)sender{
    //    [_sessionManager GET:@"http://api.jiefu.tv/app2/api/article/list.html?mediaType=2&deviceCode=6EE4FB649FAF4D0EB99754F1E3F49DF0&token=&pageNum=2&pageSize=20"
    //                 success:^(NSData *data, NSURLResponse *response){
    //                     NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //                     NSLog(@"%@",string);
    //                 }failure:^(NSError *error){
    //                     NSLog(@"%@",error);
    //                 }];
    //
    
    //    [_sessionManager GET:@"http://api.jiefu.tv/app2/api/article/list.html?mediaType=2&deviceCode=6EE4FB649FAF4D0EB99754F1E3F49DF0&token=&pageNum=2&pageSize=20"];
    
}

- (void)clickDOWNLOADButton:(id)sender{
    //    [_sessionManager DOWNLOAD:URL success: failure:];
    SubViewController *subVC = [[SubViewController alloc]initWithNibName:nil bundle:nil];
    [subVC.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:subVC animated:YES];
}

- (void)clickUPLOADButton:(id)sender{
    //    [_sessionManager UPLOAD:@"" parameters:];
}
@end

