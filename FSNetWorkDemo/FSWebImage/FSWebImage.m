//
//  FSWebImage.m
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSWebImage.h"
#import "FSCommonDefine.h"

@interface FSWebImage()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation FSWebImage

+ (instancetype)manager {
    static FSWebImage *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSWebImage alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if(self = [super init]) {
        _dictionary = [NSMutableDictionary dictionary];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (void)getImageOfHttpsURL:(NSString *)urlStr completionHandler:(void (^)(UIImage *image))completionHandler {
    if(isStringEmpey(urlStr)) {
        return;
    }
    if([urlStr containsString:@"http"]) {
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    }
    UIImage *image = [_dictionary objectForKey:urlStr];
    if(image) {
        completionHandler(image);
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            NSLog(@"Error: %@", error.description);
        } else {
            UIImage *image = [UIImage imageWithData:data];
            [_dictionary setObject:image forKey:urlStr];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(image);
            });
        }
    }];
    [task resume];
}



@end
