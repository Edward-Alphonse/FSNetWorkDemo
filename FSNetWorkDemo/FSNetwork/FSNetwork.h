//
//  FSNetwork.h
//  FSNetWorkDemo
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AuthenticateCallBack)(BOOL isAuthenticated);

@interface FSNetwork : NSObject

+ (instancetype)manager;
- (void)sendRqeust:(NSURLRequest *)request;
- (void)sendRqeust:(NSURLRequest *)request callBack:(void (^)(BOOL isAuthenticated))callBack;

@end
