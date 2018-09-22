//
//  NSStringUtils.m
//  Yoshop
//
//  Created by zhaowei on 16/5/31.
//  Copyright © 2016年 yoshop. All rights reserved.
//

#import "NSStringUtils.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSStringUtils

+ (BOOL)isEmptyString:(id)string {
    return string==nil || string==[NSNull null] || ![string isKindOfClass:[NSString class]] || [(NSString *)string length] == 0;
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)isEmptyString:(id)string withReplaceString:(NSString *)replaceString {
    if ([self isEmptyString:string]) {
        return [self isEmptyString:replaceString] ? @"" : replaceString;
    } else {
        return string;
    }
}

+ (BOOL)isValidEmailString:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isIncludeSpecialCharacterString:(NSString *)string {
    
    NSRange validRange = [string rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (validRange.location == NSNotFound) {
        return NO;
    }
    return YES;
}


/**
 至少8位数字和字母组成
 */
+(BOOL)checkPassWord:(NSString *)password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,100}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)isAllNumberCharacterString:(NSString *)string {
    
    NSString *stringRegex = @"^[0-9]*$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:string];
}

+ (BOOL)isAllLetterCharacterString:(NSString *)string {
    
    NSString *stringRegex = @"^[A-Za-z]+$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:string];
}

+ (BOOL)isAllNumberAndLetterCharacterString:(NSString *)string {
    
    NSString *stringRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:string];
}

/**
 * 限制只能输入指定的字符串
 */
+(BOOL)validateParamter:(NSString *)paramter AdCodeString:(NSString *)codeString {
    if (!paramter.length ||!codeString.length) return YES;
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:codeString];
    int i = 0;
    while (i < paramter.length) {
        NSString * string = [paramter substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


+ (NSString *)breakUpTheString:(NSString *)string point:(NSInteger)point {
    NSString *realyString = string;
    NSRange range = [string rangeOfString:@"."];
    if (range.location != NSNotFound) {
        if (point < (string.length - range.location - 1)) {
            realyString = [string substringToIndex:range.location + point + 1];
        };
    }
    return realyString;
}

+ (NSString *)emptyStringReplaceNSNull:(id)string {
    if ([self isEmptyString:string]) {
        return @"";
    }else{
        return string;
    }
}

+ (NSString *)uniqueUUID {
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *str = [[uuid UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return str;
}

/**
 *  获取当前时间的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getCurrentTimestamp {
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    // 转为字符型
    return timeString;
}
/**
 *  获取当前时间的时间戳（毫秒级别)
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getCurrentMSimestamp {
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    // 转为字符型
    return timeString;
}

// ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

+ (NSString *)ZFNSStringMD5:(NSString *)string {
    if (!string) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],  result[3],
            result[4],  result[5],  result[6],  result[7],
            result[8],  result[9],  result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString *)sortAndCompress:(NSString *)string{
    //const char *p = [string UTF8String];
    
    //首先把不可变字符串转化为可变字符串，因为可变字符串有替换操作
    NSMutableString *muString = [NSMutableString stringWithString:string];
    //进行排序，冒泡，升序
    //NSLog(@"%lu",string.length);
    for (int i = 0; i < muString.length - 1; i++) {
        for (int j = 0 ; j < muString.length - i - 1; j++) {
            
            //取出第j个字符
            unichar p1 = [muString characterAtIndex:j] ;
            
            if ([muString characterAtIndex:j ] > [muString characterAtIndex:j+1 ]) {
                //第j为被j+1位替换掉
                [muString replaceCharactersInRange:NSMakeRange(j, 1) withString:[NSString stringWithFormat:@"%c",[muString characterAtIndex:j+1] ]];
                //第j+1位的值被存储第j位值的p1替换掉
                [muString replaceCharactersInRange:NSMakeRange(j+1, 1) withString:[NSString stringWithFormat:@"%c",p1]];
            }
        }
    }
//    //定义一个新的可变字符串，用来存压塑后的字符串
//    NSMutableString *ns = [[NSMutableString alloc]init];
//    //定义一个记录出现次数的变量赋值为一
//    NSInteger count = 1;
//    //第一层循环是以第i个数为主，往下开始比较
//    for (int i = 0; i < muString.length; i+=count) {
//        count = 1;
//        //第二层循环用于记录在下面的字符串中有多少个字符和第i个相等
//        for (int j = i+1; j < muString.length; j++) {
//            if ([muString characterAtIndex:i]== [muString characterAtIndex:j]) {//如果相等则count加1
//                count ++;
//            }
//        }
//        //第二层循环结束后来判断count的大小，如果大于1则把第i个字符和count都放在新的字符串中
//        if (count > 1) {
//            [ns appendFormat :@"%c",[muString characterAtIndex:i]];
//            [ns appendFormat:@"%lu",count];
//
//        }else{
//            //如果不大于1证明没有和它相等的，只把字符添加到字符串中
//            [ns appendFormat :@"%c",[muString characterAtIndex:i]];
//        }
//    }
//    //NSLog(@"muString=%@",muString);
    return [muString copy];
}

@end
