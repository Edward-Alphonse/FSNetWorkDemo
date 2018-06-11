//
//  DownloadProgressModel.m
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/9/22.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import "DownloadProgressModel.h"

@implementation DownloadProgressModel

- (instancetype)init{
    self = [super init];
    if(self)
    {
        _title = [[NSString alloc]init];
        _progress = [NSNumber numberWithFloat:0.f];
        _speed = [[NSString alloc]init];
        _remainingTime = [[NSString alloc]init];
        _writtenSize = [[NSString alloc]init];
        _totalSize = [[NSString alloc]init];
    }
    return self;
}

@end
