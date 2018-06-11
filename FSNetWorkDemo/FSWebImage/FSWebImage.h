//
//  FSWebImage.h
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSWebImage : NSObject

+ (instancetype)manager;
- (void)getImageOfHttpsURL:(NSString *)urlStr completionHandler:(void (^)(UIImage *image))completionHandler;

@end
