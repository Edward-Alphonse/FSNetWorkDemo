//
//  SessionDataTaskDelegater.h
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/9/3.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^DownloadProgressBlock)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize);

@interface SessionDataTaskDelegater : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, copy)   DownloadProgressBlock progressBlock;
@property (nonatomic, strong) NSMutableData *resumeData;
@property (nonatomic, strong) NSProgress *downloadProgress;
@property (nonatomic, strong) NSDate *startTime; 

@end
