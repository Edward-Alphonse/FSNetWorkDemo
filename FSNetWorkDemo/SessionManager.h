//
//  SessionManager.h
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/8/31.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLSession.h"


@interface SessionManager : URLSession

@property(nonatomic, strong)NSString *baseURL;

+ (instancetype)manager;
+ (instancetype)managerWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;

- (instancetype)init;
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;


- (NSURLSessionDownloadTask *)download:(NSString *)url resumeData:(NSData *)resumeData progress:( void(^)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize)) progress;
@end
