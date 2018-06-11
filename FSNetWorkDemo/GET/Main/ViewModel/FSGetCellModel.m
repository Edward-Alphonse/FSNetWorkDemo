//
//  FSCellModel.m
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "FSGetCellModel.h"

@interface FSGetCellModel()

@property (nonatomic, strong) NSDictionary *model;

@end


@implementation FSGetCellModel
@dynamic logoTitle;
@dynamic logoURL;
@dynamic topicTitle;
@dynamic videoImageURL;
@dynamic videoPath;

- (id)initWithModel:(NSDictionary *)model {
    if(self = [super init]) {
        _model = model;
    }
    return self;
}

#pragma mark: 存取方法
- (NSString *)logoTitle {
    NSDictionary *userView = [_model objectForKey:@"userView"];
    return [userView objectForKey:@"nickName"];
}

- (NSString *)logoURL {
    NSDictionary *userView = [_model objectForKey:@"userView"];
    return [userView objectForKey:@"headImg"];
}

- (NSString *)topicTitle {
    return [_model objectForKey:@"title"];
}

- (NSString *)videoImageURL {
    return [_model objectForKey:@"mainPicPath"];
}

- (NSString *)videoPath {
    NSDictionary *itemView = [_model objectForKey:@"itemView"];
    return [itemView objectForKey:@"gifPath"];
}

- (id)getValueForKey:(NSString *)key {
    return [_model objectForKey:key];
}

@end
