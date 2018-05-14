//
//  WDVenderManager.m
//  CMWD
//
//  Created by WangWei on 2018/4/19.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "WDVenderManager.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
//fc67bca17215a714aab44de4

#define PushKey @"fc67bca17215a714aab44de4"
static NSString *channel = @"Publish channel";
static BOOL isProduction =YES;

@interface WDVenderManager ()<JPUSHRegisterDelegate>
@end
@implementation WDVenderManager

CMSingletonM(WDVenderManager)


#pragma mark 分享配置
+(void)registerShare{
    
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 // 设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"376421421"
                                           appSecret:@"7ebaab095b6ec20e5fa8665f5b14219a"
                                         redirectUri:@"http://www.58cm.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx9e97b3dbdac46bfe"
                                       appSecret:@"4a03f22ec20c2c50e5e049118b6ffda9"];
                 break;
                 //QQ
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1104914591" appKey:@"pMNrwdG3DQruX2Bh" authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
    
    
}
#pragma mark 推送

- (void)                                                                                                         setupWithOptions:(NSDictionary *)launchOptions {
   /*
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) // iOS10
    {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = (UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound);
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
   */
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = (UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound);
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    

    [JPUSHService setupWithOption:launchOptions appKey:PushKey channel:channel apsForProduction:isProduction];
    
    // NSDictionary *message = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    
    //return message;

    [JPUSHService crashLogON];
    
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion {
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (completion) {
        completion(UIBackgroundFetchResultNewData);
    }
    
}
+(void)registerID:(void(^)(NSString * registerID))success{
    
    [JPUSHService  registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if (resCode==0) {
            success(registrationID);
        }
        
    }];
    
}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// 当程序在前台时, 收到推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        if ([_delegate respondsToSelector:@selector(receiveJPushMessage:)]) {
            [_delegate receiveJPushMessage:userInfo];
        }
    }
    
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound );
}

// 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        if ([_delegate respondsToSelector:@selector(receiveJPushMessage:)]) {
            [_delegate receiveJPushMessage:userInfo];
        }
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif
@end
