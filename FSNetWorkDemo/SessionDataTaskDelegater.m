//
//  SessionDataTaskDelegater.m
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/9/3.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import "SessionDataTaskDelegater.h"

@interface SessionDataTaskDelegater()


@end

@implementation SessionDataTaskDelegater

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _resumeData = [NSMutableData data];
        _downloadProgress = [[NSProgress alloc]initWithParent:nil userInfo:nil];
        _downloadProgress.totalUnitCount = NSURLSessionTransferSizeUnknown;
        _startTime = [NSDate date];
    }
    return self;
}

#pragma mark - NSURLSessionDownloadDelegate

//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
}

//下载重新开始
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

//下载进度处理
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    //1、计算下载进度
    CGFloat progress = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
    
    //2、计算下载速度 ＝ 已下载大小／时间
    NSTimeInterval time = -1 * [self.startTime timeIntervalSinceNow];
    CGFloat speed = (CGFloat)totalBytesWritten/time;
    if(speed == 0)
        return;
    CGFloat speedDesc = [self calculateSize:speed];
    NSString *unit = [self unitConversion:speed];
    NSString *speedStr = [NSString stringWithFormat:@"%.2f%@/s",speedDesc,unit];
    
    //3、计算剩余时间 ＝ 剩余文件大小／速度
    NSMutableString *remainingTimeStr = [[NSMutableString alloc]init];
    NSInteger remainingSize =(NSInteger)totalBytesExpectedToWrite - totalBytesWritten;
    NSInteger remainingTime = (CGFloat)(remainingSize/speed);
    NSInteger hours = remainingTime / 3600;
    NSInteger minutes = (remainingTime - hours * 3600) / 60;
    NSInteger secondes = remainingTime - hours *3600 - minutes * 60;
    if(hours)
    {
        [remainingTimeStr appendFormat:@"%ld小时",hours];
    }
    if(minutes)
    {
        [remainingTimeStr appendFormat:@"%ld分", minutes];
    }
    if(secondes)
    {
        [remainingTimeStr appendFormat:@"%ld秒", secondes];
    }
    
    NSString *writtenSize = [NSString stringWithFormat:@"%.2f%@", [self calculateSize:totalBytesWritten], [self unitConversion:totalBytesWritten]];
    NSString *totalSize = [NSString stringWithFormat:@"%.2f%@", [self calculateSize:totalBytesExpectedToWrite], [self unitConversion:totalBytesExpectedToWrite]];
    
    NSLog(@"%f\n%@\n%@\n%@%@\n",progress, speedStr, remainingTimeStr, writtenSize, totalSize);
    self.progressBlock(progress, speedStr, remainingTimeStr, writtenSize, totalSize);

}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{

}

#pragma mark - 处理方法
- (BOOL)copyFileFromURL:(NSURL *)location toURL:(NSURL *)destination{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    [manager copyItemAtURL:location toURL:destination error:&error];
    if(error)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSURL *)createDestinationFile:(NSURL *)location {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = urls[0];
    [url URLByAppendingPathComponent:location.lastPathComponent];
    return url;
}

- (BOOL)copyFileFromLocation:(NSURL *)location ToDestination:(NSURL *)destination {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if(!error)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 单位转换
- (CGFloat)calculateSize:(long long)size
{
    if(size >= pow(1024, 3))
    {
        return size/pow(1024,3);
    }
    else if(size >= pow(1024, 2))
    {
        return size/pow(1024, 2);
    }
    else
    {
        return size/1024;
    }
}

- (NSString *)unitConversion:(long long)size
{
    if(size >= pow(1024, 3))
    {
        return @"GB";
    }
    else if(size >= pow(1024, 2))
    {
        return @"MB";
    }
    else
    {
        return @"KB";
    }
}

@end
