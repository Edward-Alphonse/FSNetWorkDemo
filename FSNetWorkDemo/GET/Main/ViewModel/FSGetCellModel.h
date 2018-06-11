//
//  FSCellModel.h
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSGetCellModel : NSObject

@property (nonatomic, strong, readonly) NSString *logoTitle;
@property (nonatomic, strong, readonly) NSString *logoURL;
@property (nonatomic, strong, readonly) NSString *topicTitle;
@property (nonatomic, strong, readonly) NSString *videoImageURL;
@property (nonatomic, strong, readonly) NSString *videoPath;

- (id)initWithModel:(NSDictionary *)model;
- (id)getValueForKey:(NSString *)key;

@end
