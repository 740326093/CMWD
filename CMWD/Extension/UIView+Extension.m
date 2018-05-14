//
//  UIView+Extension.m
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    
}
- (CGFloat)x {
    return self.frame.origin.x;
    
}
- (CGFloat)y {
    return self.frame.origin.y;
    
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}
- (CGFloat)centerX {
    return self.center.x;
    
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}
- (CGFloat)centerY {
    return self.center.y;
    
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}
- (CGFloat)height {
    return self.frame.size.height;
    
}
- (CGFloat)width {
    return self.frame.size.width;
    
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
}
- (CGSize)size {
    return self.frame.size;
    
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
    
}
- (CGPoint)origin {
    return self.frame.origin;
    
}

//根据ib获得view
+ (instancetype)initByNibForClassName {
    NSString *nibName = NSStringFromClass([self class]);
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}

//获得屏幕的宽度
CGFloat CMScreen_width() {
    return [UIScreen mainScreen].bounds.size.width;
}
//获得屏幕的宽度
CGFloat CMScreen_height() {
    return [UIScreen mainScreen].bounds.size.height;
}

@end
