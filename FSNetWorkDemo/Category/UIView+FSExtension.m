//
//  UIView+Extension.m
//  CGContextRefDemo
//
//  Created by zhichang.he. on 17/1/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "UIView+FSExtension.h"

@implementation UIView (FSExtension)

@dynamic width;
@dynamic height;
@dynamic x;
@dynamic y;
@dynamic centerX;
@dynamic centerY;

@dynamic top;
@dynamic bottom;
@dynamic left;
@dynamic right;
@dynamic size;

//@dynamic string;

- (void)setWidth:(CGFloat)width {
    [self setFrame:CGRectMake(self.x, self.y, width, self.height)];
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    [self setFrame:CGRectMake(self.x, self.y, self.width, height)];
}
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
    [self setFrame:CGRectMake(x, self.y, self.width, self.height)];
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    [self setFrame:CGRectMake(self.x, y, self.width, self.height)];
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setTop:(CGFloat)top {
    self.y = top;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    CGFloat height = self.height;
    self.y = bottom - height;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSize:(CGSize)size {
    CGPoint origin = self.frame.origin;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)addTarget:(id)target withAction:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = true;
}

@end
