//
//  UIBarButtonItem+WDBarItem.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "UIBarButtonItem+WDBarItem.h"

@implementation UIBarButtonItem (WDBarItem)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置按钮背景图片
    UIImage *normal = [UIImage imageNamed:image];
   // [btn setBackgroundImage:normal forState:UIControlStateNormal];
    [btn setImage:normal forState:UIControlStateNormal];
    // 3.设置按钮的尺寸
    btn.bounds = CGRectMake(0, 0, 30, 40);
    
    // 4.监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 5.返回创建好的item
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
