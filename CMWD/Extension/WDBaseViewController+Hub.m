//
//  WDBaseViewController+Hub.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDBaseViewController+Hub.h"

@implementation WDBaseViewController (Hub)
// 显示默认加载框
- (void)showDefaultProgressHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = nil;
}

// 隐藏最新加入的加载框
- (void)hiddenProgressHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

// 隐藏所有的加载框
- (void)hiddenAllProgressHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

// 弹出一个1秒后自动隐藏的HUD
- (void)showAutoHiddenHUDWithMessage:(NSString *)message {
    [self showHUDWithMessage:message hiddenDelayTime:1.0];
}

// 弹出一个`delayTime`秒后自动隐藏的HUD
- (void)showHUDWithMessage:(NSString *)message hiddenDelayTime:(NSTimeInterval)delayTime {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    
    [hud hideAnimated:YES afterDelay:delayTime];
}

@end
