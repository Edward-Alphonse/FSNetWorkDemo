//
//  FSVideoView.h
//  FSNetWorkDemo
//
//  Created by zhichang.he on 2018/6/9.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSVideoView : UIView

+ (instancetype)playWithImagePath:(NSString *)imagePath videoPath:(NSString *)videoPath;
- (void)playWithImagePath:(NSString *)imagePath videoPath:(NSString *)videoPath;

@end
