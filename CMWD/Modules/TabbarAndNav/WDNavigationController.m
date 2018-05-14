//
//  WDNavigationController.m
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDNavigationController.h"
#import "WDNavigationBar.h"
@interface WDNavigationController ()

@end

@implementation WDNavigationController
/**
 *  初始化（每一个类只会调用一次）
 */
+ (void)initialize
{
    
//    UIColor *firstColor =[UIColor clmHex:0x00c6fb ];
//    UIColor *secondColor = [UIColor clmHex:0x038BFC];
//    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    WDNavigationBar *navBar = [WDNavigationBar appearance];
    [navBar setBarTintGradientColors:@[
                                       (__bridge id)[UIColor colorWithRed:78 / 255.0 green:143 / 255.0 blue:1.0 alpha:1.0].CGColor,
                                       (__bridge id)[UIColor colorWithRed:39 / 255.0 green:196 / 255.0 blue:254 / 255.0 alpha:1.0].CGColor,
                                       (__bridge id)[UIColor colorWithRed:60 / 255.0 green:143 / 255.0 blue:1.0 alpha:1.0].CGColor,
                                       ]];
    
    // 获得bar对象
    //UINavigationBar *navBar = [UINavigationBar appearance];
    // bg.png为自己ps出来的想要的背景颜色。可以去除导航底部黑线
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"bg.png"]
    //                       forBarPosition:UIBarPositionAny
    //                           barMetrics:UIBarMetricsDefault];
    
    //除去底部黑线
    [navBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    // navBar.barTintColor = RedButtonColor;
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 设置文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航栏按钮的主题
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    // 设置按钮的文字样式
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_left" higlightedImage:nil target:self action:@selector(backClick)];
    }
    // 解决导航栏左侧按钮自定义影响系统返回手势问题
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [viewController setNeedsStatusBarAppearanceUpdate];
    
    
    
    if (![[super topViewController] isKindOfClass:[viewController class]]) {
        [super pushViewController:viewController animated:animated];  //防止多次push
    }
    
    
    
    
}



- (void)backClick
{
    
    
    [self popViewControllerAnimated:YES];
    
}



@end
