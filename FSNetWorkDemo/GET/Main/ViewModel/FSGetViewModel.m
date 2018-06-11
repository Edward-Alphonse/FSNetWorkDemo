//
//  FSGetViewModel.m
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "FSGetViewModel.h"

@interface FSGetViewModel()

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSMutableArray *cellModelArray;

@end

@implementation FSGetViewModel

@dynamic cellCount;

- (instancetype)init {
    if(self = [super init]) {
        _cellModelArray = [NSMutableArray array];
    }
    return self;
}

- (void)updateModel:(NSDictionary *)dictionary {
    if(dictionary == nil) {
        return ;
    }
    _dictionary = dictionary;
    NSArray *data = [_dictionary objectForKey:@"data"];
    for(NSDictionary *dictionary in data) {
        FSGetCellModel *cellModel = [[FSGetCellModel alloc] initWithModel:dictionary];
        [_cellModelArray addObject:cellModel];
    }
}

#pragma mark: 存取方法
- (NSUInteger)cellCount {
    return _cellModelArray.count;
}

- (FSGetCellModel *)cellModelAtIndex:(NSUInteger)index {
    if(index > _cellModelArray.count) {
        return nil;
    }
    return _cellModelArray[index];
}

- (id)getValue:(NSString *)key ofIndex:(NSUInteger)index {
    if(index > _cellModelArray.count) {
        return nil;
    }
    FSGetCellModel *cellModel = _cellModelArray[index];
    return [cellModel getValueForKey:key];
}

@end
