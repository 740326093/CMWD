//
//  AppDelegate.m
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "AppDelegate.h"
#import "WDTabBarController.h"
#import "WDRequestApi.h"
@interface AppDelegate ()<WDVenderManagerDelegate>
@property(nonatomic,strong)WDTabBarController *WDTab;
@property (strong, nonatomic)  NSDictionary *PushDict;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
     [WDVenderManager registerShare];
    [[WDVenderManager sharedWDVenderManager]setupWithOptions:launchOptions];
    [WDVenderManager sharedWDVenderManager].delegate=self;
    self.window.rootViewController=self.WDTab;
    [self configureBoardManager];
  [WDVenderManager  registerID:^(NSString *registerID) {
      DLog(@"+++%@",registerID);
    }];
    
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
   
    return YES;
}

#pragma mark  Lazy
-(WDTabBarController*)WDTab{
    if (!_WDTab) {
        _WDTab=[[WDTabBarController alloc]init];
    }
    return _WDTab;
}


#pragma mark 键盘收回管理
-(void)configureBoardManager{
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    application.applicationIconBadgeNumber = 0;
    self.PushDict=nil;
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    DLog(@"applicationWillEnterForeground");
    [[WDRequestApi sharedWDRequestApi]cheackNetWorking];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    for (UIView *vc in self.window.subviews) {
        if ([vc isKindOfClass:[CMShareTextView class]]) {
            [vc removeFromSuperview];
        }
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    DLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
    [WDVenderManager registerDeviceToken:deviceToken];

}

// 接收到远程推送通知调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    DLog(@"didReceiveRemoteNotification");
    
    [WDVenderManager handleRemoteNotification:userinfo completion:nil];
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    self.PushDict=userInfo;
  
        
        
DLog(@"didReceiveRemoteNotificationuseinfo==%@",userInfo);
       
    [WDVenderManager handleRemoteNotification:userInfo completion:completionHandler];
    
    
}
-(void)applicationDidBecomeActive:(UIApplication *)application{
    DLog(@"applicationDidBecomeActive");
    
    
    
  
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    DLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
-(void)dealyShow{
    //   DLog(@"self.window.rootViewController+++++++++%@",self.window.rootViewController);
    if([self.window.rootViewController isMemberOfClass:[WDTabBarController class]]){
        WDTabBarController  *mainTab=(WDTabBarController*)self.window.rootViewController;
        WDNavigationController * nav = (WDNavigationController *)mainTab.selectedViewController;
        UIViewController * baseVC = (UIViewController *)nav.visibleViewController;
       
        self.PushDict=nil;
    }
}
-(void)receiveJPushMessage:(NSDictionary *)userInfo{
    DLog(@"userInfo===%@",userInfo);
    self.PushDict=userInfo;
    
    
    
}


@end
