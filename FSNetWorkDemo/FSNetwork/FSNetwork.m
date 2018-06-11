//
//  FSNetwork.m
//  FSNetWorkDemo
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "FSNetwork.h"
#import "FSCommonDefine.h"

@interface FSNetwork() <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) AuthenticateCallBack authencate;

@end

@implementation FSNetwork

+ (instancetype)manager {
    static FSNetwork *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSNetwork alloc] init];
    });
    return manager;
}

- (void)sendRqeust:(NSURLRequest *)request {
    if(request == nil) {
        return;
    }
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
    NSURLSessionTask *task = [_session dataTaskWithRequest:request];
    [task resume];
}


- (void)sendRqeust:(NSURLRequest *)request callBack:(void (^)(BOOL isAuthenticated))callBack {
    [self sendRqeust:request];
    _authencate = callBack;
}

#pragma mark: NSURLSessionDelegate
//认证管理
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    if (completionHandler) {
        completionHandler(disposition, credential);
    }  
//    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
//    if(protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
//        if(![protectionSpace.host containsString:@"m.jiefu.tv"]) {
//            completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
//            return;
//        }
//    }
//    SecTrustRef serverTrust = protectionSpace.serverTrust;
//    if(serverTrust == NULL) {
//        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
//        return;
//    }
//    if(serverTrust) {
//        NSURLCredential *credential = [NSURLCredential credentialForTrust:serverTrust];
//        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//    } else {
//        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//    }
//
    
//    if(challenge.previousFailureCount == 0) {
//        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//        return;
//    }
    [challenge.sender cancelAuthenticationChallenge:challenge];
}

#pragma mark: NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    _authencate(YES);
}

@end
