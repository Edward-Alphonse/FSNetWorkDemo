//
//  DownloadProgressModel.h
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/9/22.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadProgressModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *progress;
@property (nonatomic, strong) NSString *speed;
@property (nonatomic, strong) NSString *remainingTime;
@property (nonatomic, strong) NSString *writtenSize;
@property (nonatomic, strong) NSString *totalSize;
@property (nonatomic, strong) NSData   *resumeData;

@end
