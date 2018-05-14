//
//  UIBarButtonItem+WDBarItem.h
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WDBarItem)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action;
@end
