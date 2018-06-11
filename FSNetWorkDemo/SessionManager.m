//
//  SessionManager.m
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/8/31.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import "SessionManager.h"

//缓存主目录
#define CachesDirectory  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"Cache"]\
//获取文件名
#define FileName(url)    [[url componentsSeparatedByString:@"/"] lastObject]

//获取文件存放路径
#define FileFullpath(url)     [CacheDirectory stringAppendingPathComponent:FileName(url)]

@interface SessionManager()

@property (nonatomic, strong) NSMutableURLRequest *request;

@end

@implementation SessionManager


#pragma mark -初始化方法
+ (instancetype)manager{
    return [self managerWithSessionConfiguration:nil];
}

+ (instancetype)managerWithSessionConfiguration:(NSURLSessionConfiguration *)configuration{
    static SessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[self alloc]initWithSessionConfiguration:configuration];
    });
    return sessionManager;
}

- (instancetype)init{
    return [self initWithSessionConfiguration:nil];
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration{
    if(self = [super initWithSessionConfiguration:configuration]){
        self.baseURL = @"";
         _request = [[NSMutableURLRequest alloc]init];
    }
    return self;
}


#pragma mark -下载请求
- (NSURLSessionDownloadTask *)download:(NSString *)url resumeData:(NSData *)resumeData progress:( void(^)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize)) progress{
    
    if(resumeData == nil)
    {
        
        //4、创建一个下载任务
        NSURLSessionDownloadTask *task = [self downloadWithRequest:[self createRequest:url] progress:progress];
        return task;

    }
    else
    {
        NSURLSessionDownloadTask *task = [self downloadWithResumeData:resumeData progress:progress];
        return task;
    }
}

-(NSURLRequest *)createRequest:(NSString *)url
{
    if(!url)
        return nil;
    //1、获取文件存放路径
    //1.1 获取缓存主目录
    NSArray<NSString *> *strArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [strArray firstObject];
    
    //1.2 通过URL获取文件名
    NSArray<NSString *> *componentArray = [url componentsSeparatedByString:@"/"];
    NSString *fileName = [componentArray lastObject];
    
    //1.3 拼接文件存放路径
    NSString *fullPath = [cacheDirectory stringByAppendingPathComponent:fileName];
    
    //3、创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    //3.1 文件已下载长度
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *dic = [manager attributesOfItemAtPath:fullPath error:nil];
    [dic [NSFileSize] integerValue];
    
    //3.2设置请求头中相关的域
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",[dic [NSFileSize]integerValue]];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    NSString *userAgent = @"hzc_iOS";
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    return request;
}

@end
