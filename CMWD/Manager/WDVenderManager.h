//
//  WDVenderManager.h
//  CMWD
//
//  Created by WangWei on 2018/4/19.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMSingleton.h"
@interface WDVenderManager : NSObject
CMSingletonH(WDVenderManager)
#pragma mark 分享配置
+(void)registerShare;
#pragma mark 推送

// 在应用启动的时候调用
-(void)setupWithOptions:(NSDictionary *)launchOptions;

// 在appdelegate注册设备处调用
+(void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;

+(void)registerID:(void(^)(NSString * registerID))success;

@property(nonatomic,weak)id delegate;
@end
@protocol WDVenderManagerDelegate <NSObject>

-(void)receiveJPushMessage:(NSDictionary*)userInfo;

@end
