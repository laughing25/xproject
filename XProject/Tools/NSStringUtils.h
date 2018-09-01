//
//  NSStringUtils.h
//  Yoshop
//
//  Created by zhaowei on 16/5/31.
//  Copyright © 2016年 yoshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringUtils : NSObject
/**
 *  NSNULL类型转换为@""
 *
 *  @param string
 *
 *  @return 入参为NSULL类型时返回@“”，否则返回原字符串
 */
+ (NSString *)emptyStringReplaceNSNull:(id)string;

/**
 *  判断参数是否为空
 *
 *  @param string 需要判断的参数
 *
 *  @return YES表示参数为空,NO表示参数不为空
 */
+ (BOOL)isEmptyString:(id)string;

/**
 *  判断参数是否为空
 *
 *  @param string 需要判断的参数
 *
 *  @return YES表示参数为空,NO表示参数不为空
 */
+ (BOOL) isBlankString:(NSString *)string;

+ (NSString *)isEmptyString:(id)string withReplaceString:(NSString *)replaceString;
/**
 *  判断字符串是否为合法邮箱
 *
 *  @param eamil 需要判断的参数
 *
 *  @return YES表示参数为合法邮箱,NO表示参数为不合法邮箱
 */
+ (BOOL)isValidEmailString:(NSString *)email;
/**
 *  判断是否包含特殊字符（^%&',;=?$\”）
 *
 *  @param string 需要判断的参数
 *
 *  @return YES表示里面包含该字符，否则没有包含
 */
+ (BOOL)isIncludeSpecialCharacterString:(NSString *)string;

/**
 至少8位数字和字母组成
 */
+(BOOL)checkPassWord:(NSString *)string;

/**
 *  判断是否全是数字
 *
 *  @param string 需要判断的参数
 *
 *  @return YES表示全是数字，否则含有别的
 */
+ (BOOL)isAllNumberCharacterString:(NSString *)string;
/**
 *  判断是否全是字母（26个英文字母）
 *
 *  @param string 需要判断的参数
 *
 *  @return YES表示全是字母，否则含有别的
 */
+ (BOOL)isAllLetterCharacterString:(NSString *)string;
/**
 *  判断字符串是否全是（26个英文字母 或 0-9 的数字）组成
 *
 *  @param string 需要判断的参数
 *
 *  @return YES 表示是只有字母和数字，否则没有
 */
+ (BOOL)isAllNumberAndLetterCharacterString:(NSString *)string;

/**
 * 限制只能输入指定的字符串
 */
+(BOOL)validateParamter:(NSString *)paramter AdCodeString:(NSString *)codeString;

/**
 *  获取字符串的小数点后几位
 *
 *  @param string 所需要改变的字符串---举例：23.545
 *  @param point  字符串保留几位---举例：2
 *
 *  @return 表示获取到的字符串--举例按上： 23.54
 */
+ (NSString *)breakUpTheString:(NSString *)string point:(NSInteger)point;

/**
 *  获取当前时间的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getCurrentTimestamp;

+ (NSString *)getCurrentMSimestamp;

+ (NSString *)uniqueUUID;

+ (NSString *)buildRequestPath:(NSString *)path;

+ (NSString *)buildCommparam;

+ (NSString *)encryptWithDict:(NSDictionary *)dict;

+ (NSString *)encryptWithStr:(NSString *)string;

+ (id)desEncryptWithString:(NSString *)str;
// 社区时间格式
+ (NSString*)timeLapse:(NSInteger)time;

//appflyer
+ (NSString *)getMediaSource;

+ (NSString *)getCampaign;

+ (NSString *)getLkid;

+ (NSString *)getAdId;

//推送催付参数
+ (NSString *)getPid;
+ (NSString *)getC;
+ (NSString *)getIsRetargeting;

+ (NSString *)ZFNSStringMD5:(NSString *)string;

@end
