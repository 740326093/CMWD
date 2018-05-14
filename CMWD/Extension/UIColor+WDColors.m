//
//  UIColor+WDColors.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "UIColor+WDColors.h"

@implementation UIColor (WDColors)
//给一个十六进制的值
+ (UIColor *)clmHex:(UInt32)hex {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}
//给一个十六进制的值 自定义透明度
+ (UIColor *)clmHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)clmR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B {
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

+ (UIColor *)WdMainColor{
    
    return [UIColor clmHex:0x038BFC];
    
}
+ (UIColor *)WdMainBackgroundColor{
    
    return [UIColor clmHex:0xefeff4];
    
}
+(UIColor *)WdRedClolor{
    
    return [UIColor clmHex:0xfb3c19];
}
+(UIColor *)WdGrayClolor{
    
    return [UIColor clmHex:0xcccccc];
}
@end
