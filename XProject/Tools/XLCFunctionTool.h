//
//  ZFCFunctionTool.h
//  IntegrationDemo
//
//  Created by mao wangxin on 2018/3/6.
//  Copyright © 2018年 mao wangxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLCFunctionTool : NSObject

/**
 * 全局所有HTTP <.zaful.com> Cookie
 */
NSHTTPCookie * globaleZafulHTTPCookie(void);

/**
 *  添加cookie
 */
void addZafulCookie(void);

/**
 * 删除cookie
 */
void deleteZafulCookie(void);

/**
 * 仅供测试时使用:测试国家IP Cookie
 */
void addCountryIPCookie(void);

/**
 App统一获取图片方法, 既能简化代码,又能便于以后统一处理图片 (例如:添加水印等)
 
 @param name 图片名
 @return 获取的图片
 */
UIImage* ZFImageWithName(NSString *name);

/**
 获取bundle中的图片
 
 @param name 图片名字
 @return 图片
 */
UIImage* ZFImageFromBundleWithName(NSString *name);

NSString *getLaunchImageName(void);

/**
 *  产生随机颜色
 */
UIColor* ZFRandomColor(void);

/**
 *  获取应用版本号
 */
NSString* ZFCurrentAppVersion(void);

/**
 *  获取应用使用语音
 */
NSString* ZFUserLanguage(void);

/**
 * 设置应用使用语音
 */
void ZFSetUserlanguage(NSString *language);


#pragma mark -===========字符串、对象的一些安全操作===========

/**
 * 判断是否为NSString
 */
BOOL ZFJudgeNSString(id obj);

/**
 * 判断是否为NSDictionary
 */
BOOL ZFJudgeNSDictionary(id obj);

/**
 * 判断是否为NSArray
 */
BOOL ZFJudgeNSArray(id obj);

/**
 * 判断字符串是否为空
 */
BOOL ZFIsEmptyString(id obj);

/**
 *  转化为NSString来返回，如果为数组或字典转为json返回, 其他对象则返回@""
 *  适用于取一个值后赋值给文本显示时用
 */
NSString * ZFToString(id obj);

/**
 * 判断是否为自定义对象类
 */
BOOL ZFJudgeClass(id obj, NSString *classString);

/**
 * 从数组中获取对象
 */
id ZFGetObjFromArray(NSArray *array, NSInteger index);

/**
 * 从字典中获取NSString
 */
NSString * ZFGetStringFromDict(NSDictionary *dictionary, NSString *key);


@end

