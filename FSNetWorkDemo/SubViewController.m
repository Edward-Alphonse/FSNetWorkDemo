//
//  SubViewController.m
//  NSURLSessionDemo
//
//  Created by QITMAC000242 on 16/9/3.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import "SubViewController.h"
#import "SessionManager.h"
#import "ListTableViewCell.h"
#import "DownloadProgressModel.h"


#define PROGRESSBARWIDTH  330
#define PROGRESSBARHEIGHT 10
#define PROGRESSBARNUM    3

#define BTNWIDTH    65
#define BTNHEIGHT   35
#define BTNMARGIN   15

#define TABBARHEIGHT 50
#define TABBARWIDTH [UIScreen mainScreen].bounds.size.width


#define URL @"http://p1.pichost.me/i/40/1639665.png"

@interface SubViewController()

@property (nonatomic, strong) SessionManager *sessionManager;

@property (nonatomic, strong) NSMutableArray<DownloadProgressModel *> *listData;
@property (nonatomic, strong) NSMutableArray<NSURLSessionDownloadTask *> *taskList;
@property (nonatomic, strong) NSMutableArray *downloading;
@property (nonatomic, strong) NSMutableArray *downloaded;

@end

@implementation SubViewController

- (void)viewDidLoad{
    [self createView];
    _sessionManager = [SessionManager managerWithSessionConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"download"]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"listURL" ofType:@".plist"];
    NSArray *urlArray = [NSMutableArray arrayWithContentsOfFile:path];
    _listData = [NSMutableArray array];
    _taskList = [NSMutableArray array];
    
    for (NSString *tmp in urlArray) {
        DownloadProgressModel *model = [[DownloadProgressModel alloc]init];
        model.title = tmp;
        [_listData addObject:model];
        
        NSURLSessionDownloadTask *task = [[NSURLSessionDownloadTask alloc]init];
        [_taskList addObject:task];
    }
}


- (void)createView{

    CGFloat spaceYStart = 0;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - spaceYStart - TABBARHEIGHT;
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, spaceYStart, TABBARWIDTH, height) style:UITableViewStylePlain];
    _myTableView.tag = 0;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identify = @"cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell)
    {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    DownloadProgressModel *model = [_listData objectAtIndex:indexPath.row];
    NSArray *textArray = [model.title componentsSeparatedByString:@"/"];
    cell.titleLbl.text = [textArray lastObject];
    [cell.titleLbl setFrame:CGRectMake(10.f, 0.f, [UIScreen mainScreen].bounds.size.width - 75, 30)];
    
    cell.downloadProgressView.progress = [model.progress floatValue];
    [cell.downloadProgressView setFrame:CGRectMake(10.f, 30.f, [UIScreen mainScreen].bounds.size.width - 75, 10)];
    
    [cell.progressLbl setFrame:CGRectMake(10.f, 40.f, [UIScreen mainScreen].bounds.size.width - 175, 15)];
    if(![model.totalSize isEqualToString:@""])
        cell.progressLbl.text = [NSString stringWithFormat:@"%@/%@", model.writtenSize, model.totalSize];
    
    [cell.speedLbl setFrame:CGRectMake(10.f + [UIScreen mainScreen].bounds.size.width - 175, 40.f , 100, 15)];
    cell.speedLbl.text = model.speed;
    
    [cell.downloadBtn setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 75, 0.f, 65, 60)];
    
    
    __block NSIndexPath *blockIndexPath = indexPath;
    __block typeof(self) bself = self;
    cell.downloadCallBack = ^(UIButton *btn){
        
        //1. 获取被选项的模型
        __block DownloadProgressModel *model = [bself.listData objectAtIndex:blockIndexPath.row];
        
        //2. 初次点击下载按钮
        if([btn isSelected] == NO)
        {
            NSURLSessionDownloadTask *task = [_sessionManager download:model.title resumeData:model.resumeData progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize){
                dispatch_async(dispatch_get_main_queue(), ^{
                    //刷新主页面
                    model.progress = [NSNumber numberWithFloat:progress];
                    model.speed = speed;
                    model.remainingTime = remainingTime;
                    model.writtenSize = writtenSize;
                    model.totalSize = totalSize;
                    [bself.listData replaceObjectAtIndex:blockIndexPath.row withObject:model];
                    [bself.myTableView reloadData];
                });
            }];
            [bself.taskList replaceObjectAtIndex:blockIndexPath.row withObject:task];
            [task resume];
            [btn setSelected:YES];
        }
            
        /*URLSession中使用task的标识符来与delegate进行映射，当暂停下载任务时task取消，但是字典中的delegate不会被删除
            而且每次重新从断点处下载都会重新创建一个task，这个task与delegate进行映射，会不会加大了字典所需要的储存空间          取消的task的delegate在URLSession:task:didCompleteWithError:中会被移除
         */
        else
        //4. 开始暂停
        {
            NSURLSessionDownloadTask *task = [bself.taskList objectAtIndex:blockIndexPath.row];
            [task cancelByProducingResumeData:^(NSData* __nullable resumeData){
                model.resumeData = resumeData;
                [bself.listData replaceObjectAtIndex:blockIndexPath.row withObject:model];
            }];
//            [task suspend];
            [btn setSelected:NO];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
