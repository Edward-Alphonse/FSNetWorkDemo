//
//  URLSession.m
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/8/31.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import "URLSession.h"

@interface URLSession()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) SessionDataTaskDelegater *delegate;
@property (nonatomic, strong) dispatch_queue_t dispatchQueue;
@property (nonatomic, strong) NSMutableDictionary *downloadTaskDic;

@end

@implementation URLSession

#pragma mark -初始化方法
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    //1、初始化sessionConfiguration
    _sessionConfiguration = sessionConfiguration;
    if(_sessionConfiguration == nil)
    {
        _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    
    //2、初始化队列
    _operationQueue = [[NSOperationQueue alloc]init];
    _dispatchQueue = dispatch_queue_create("dispatch_queue", DISPATCH_QUEUE_CONCURRENT);
    
    //3、初始化session，在delegate中调用SessionDataTaskDelegater的方法，这样做确保session是唯一的，所有的task都由同一个session产生
    _session = [NSURLSession sessionWithConfiguration:_sessionConfiguration delegate:self delegateQueue:_operationQueue];
    
    
    //4、初始化dic
    _downloadTaskDic = [[NSMutableDictionary alloc]init];
    _downloaded = @[].mutableCopy;
    _downloading = @[].mutableCopy;
    
    return self;
}

#pragma mark -下载请求
- (NSURLSessionDownloadTask *)downloadWithRequest:(NSURLRequest *)request progress:( void(^)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize)) progress{
  
    NSURLSessionDownloadTask *task = [_session downloadTaskWithRequest:request];
    [self addDelegateForTask:task progress:progress];
    return task;
}

- (NSURLSessionDownloadTask *)downloadWithResumeData:(NSData *)resumeData progress:( void(^)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize)) progress{
    NSURLSessionDownloadTask *task = [_session downloadTaskWithResumeData:resumeData];
    [self addDelegateForTask:task progress:progress];
    
    return task;
}


#pragma mark - Delegate与task进行映射
- (void)addDelegateForTask:(NSURLSessionTask *)task progress:( void(^)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize)) progress
{
    SessionDataTaskDelegater *delegate = [[SessionDataTaskDelegater alloc]init];
    delegate.progressBlock = progress;
    NSString *key = [NSString stringWithFormat:@"%ld", task.taskIdentifier];
    [_downloadTaskDic setValue:delegate forKey:key];
    
}

- (SessionDataTaskDelegater *)getDelegate:(NSURLSessionTask *)task
{
     NSString *key = [NSString stringWithFormat:@"%ld", task.taskIdentifier];
    SessionDataTaskDelegater *delegate = [_downloadTaskDic objectForKey:key];
    return delegate;
}

- (void)removeDelegate:(NSURLSessionTask *)task{
    NSString *key = [NSString stringWithFormat:@"%ld", task.taskIdentifier];
    [_downloadTaskDic removeObjectForKey:key];
}

#pragma mark - NSURLSessionDownloadDelegate委托方法实现
//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
}

//重新进行下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
   
}

//下载进度处理
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //1. 取出对应的delegate
    SessionDataTaskDelegater *delegate = [self getDelegate:downloadTask];
    if(delegate)
    {
        [delegate URLSession:session downloadTask:downloadTask didWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
    }
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler
{
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error
{
    SessionDataTaskDelegater *delegate = [self getDelegate:task];
    if(delegate)
    {
        [delegate URLSession:session task:task didCompleteWithError:error];
        [self removeDelegate:task];
    }
}


@end
