//
//  UIColor+WDColors.h
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WDColors)

// 传入十六进制的颜色值 透明度为1
+ (UIColor *)clmHex:(UInt32)hex;

// 传入十六进制的颜色值 自定义透明度
+ (UIColor *)clmHex:(UInt32)hex alpha:(CGFloat)alpha;

// 传入rgb色值 透明度为1
+ (UIColor *)clmR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B;

#pragma mark - colors
/**
 *  主色调
 */
+ (UIColor *)WdMainColor;

/**
 *  主背景颜色
 */
+ (UIColor *)WdMainBackgroundColor;

+(UIColor *)WdRedClolor;
+(UIColor *)WdGrayClolor;
@end
