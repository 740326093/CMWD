//
//  NSString+WDString.m
//  CMWD
//
//  Created by WangWei on 2018/4/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "NSString+WDString.h"

@implementation NSString (WDString)
// 检测是否为空字符串
- (BOOL)isBlankString {
    return !self.filtrateString.length;
}

// 删除空格和换行
- (NSString *)filtrateString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)checkPhoneNumInput {
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (isMatch )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma 正则匹配邮箱
+ (BOOL) checkUserEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}
- (BOOL)judgePassWordLegal:(NSString *)pass {
    [pass filtrateString];
    BOOL result = NO;
    if (pass.length>6) {
        NSString *firstStr = [pass substringToIndex:1];
        NSString *ZIMU = @"^[A-Za-z]+$";
        NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
        if ([regextestA evaluateWithObject:firstStr]) {
            // 判断长度大于8位后再接着判断是否同时包含数字和字符
            NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [pred evaluateWithObject:pass];
        } else {
            result = NO;
        }
        
    }
    return result;
}

@end
