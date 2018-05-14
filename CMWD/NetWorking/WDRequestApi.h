//
//  WDRequestApi.h
//  CMWD
//
//  Created by WangWei on 2018/4/21.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  请求成功的回调
 *
 *  @param responseObject 请求成功的数据
 */
typedef void (^SuccessRequestBlock)(id responseObject);

/**
 *  请求失败
 *
 *  @param error 请求失败的错误信息
 */
typedef void (^FailRequestBlock)(NSError *error);

@interface WDRequestApi : NSObject
CMSingletonH(WDRequestApi)






//监听网络
-(void)cheackNetWorking;
@end
