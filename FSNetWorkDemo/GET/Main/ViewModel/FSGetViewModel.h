//
//  FSGetViewModel.h
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSGetCellModel.h"

@interface FSGetViewModel : NSObject

@property (nonatomic, assign) NSUInteger cellCount;

- (FSGetCellModel *)cellModelAtIndex:(NSUInteger)index;
- (void)updateModel:(NSDictionary *)dictionary;
- (id)getValue:(NSString *)key ofIndex:(NSUInteger)index;

@end
