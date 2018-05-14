//
//  UIView+Extension.h
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

+ (instancetype)initByNibForClassName;
/**
 *  获取屏幕的宽度
 */
CGFloat CMScreen_width(void);

/**
 *  获得屏幕的高度
 */
CGFloat CMScreen_height(void);
@end
