//
//  UIView+Extension.h
//  CGContextRefDemo
//
//  Created by zhichang.he. on 17/1/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FSExtension)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGSize size;


- (void)setWidth:(CGFloat)width;
- (CGFloat)width;

- (void)setHeight:(CGFloat)height;
- (CGFloat)height;

- (void)setX:(CGFloat)x;
- (CGFloat)x;

- (void)setY:(CGFloat)y;
- (CGFloat)y;

- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerX;

- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)centerY;

- (void)setTop:(CGFloat)top;
- (CGFloat)top;

- (void)setBottom:(CGFloat)bottom;
- (CGFloat)bottom;

- (void)setLeft:(CGFloat)left;
- (CGFloat)left;

- (void)setRight:(CGFloat)right;
- (CGFloat)right;

- (void)setSize:(CGSize)size;
- (CGSize)size;

- (void)addTarget:(id)target withAction:(SEL) sel;

//@property (nonatomic, strong) NSString *string;
//- (void)setString:(NSString *)string;
//- (NSString *)string;


@end
