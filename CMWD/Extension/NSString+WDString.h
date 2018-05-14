//
//  NSString+WDString.h
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WDString)
/**
 *  检测是否为空字符串
 */
- (BOOL)isBlankString;

/**
 *   删除空格和换行
 */
- (NSString *)filtrateString;

/**
 *  验证手机号码格式
 */
-(BOOL)checkPhoneNumInput;


/**
 *  判断长度是否大于6位，是否包含文字和字母
 *
 *  @param pass 要判断的文字
 *
 * 
 */
- (BOOL)judgePassWordLegal:(NSString *)pass;






+ (BOOL) checkUserEmail:(NSString *)email;
@end
