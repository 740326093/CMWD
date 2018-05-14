//
//  CMCommon.h
//  CMWD
//
//  Created by WangWei on 2018/4/10.
//  Copyright © 2018年 MAC. All rights reserved.
//

#ifndef CMCommon_h
#define CMCommon_h


#ifdef DEBUG
#define DLog(fmt,...) printf("[%s] %s %s\n", __TIME__, __FUNCTION__,[[NSString stringWithFormat:fmt, ## __VA_ARGS__] UTF8String]);
#else
#define DLog(...)
#endif


////屏幕尺寸
//#define CMScreenW [UIScreen mainScreen].bounds.size.width
//#define CMScreenH [UIScreen mainScreen].bounds.size.height
//

#define NSNotice [NSNotificationCenter defaultCenter]
#define kWeakSelf(type)__weak typeof(type)weak##type = type;
#define kStrongSelf(type)__strong typeof(type)type = weak##type;
#define f_i5real(f) (((int)((CMScreen_width() * ((f)/320.f))*2))/2.f)


#endif /* CMCommon_h */
