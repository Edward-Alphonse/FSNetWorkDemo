//
//  URLSession.h
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/8/31.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SessionDataTaskDelegater.h"

@interface URLSession : NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate,NSURLSessionDownloadDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, strong) NSMutableArray *downloading;
@property (nonatomic, strong) NSMutableArray *downloaded;


- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration;

- (NSURLSessionDownloadTask *)downloadWithRequest:(NSURLRequest *)request progress:( void(^)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize)) progress;

- (NSURLSessionDownloadTask *)downloadWithResumeData:(NSData *)resumeData progress:( void(^)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize)) progress;
@end
