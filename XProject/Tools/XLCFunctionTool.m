//
//  ZFCFunctionTool.m
//  IntegrationDemo
//
//  Created by mao wangxin on 2018/3/6.
//  Copyright © 2018年 mao wangxin. All rights reserved.
//

#import "XLCFunctionTool.h"

@implementation XLCFunctionTool

NSHTTPCookie * globaleZafulHTTPCookie(void) {
    NSHTTPCookie *zaful_cookie = [[NSHTTPCookie alloc] initWithProperties:@{
                                                                     NSHTTPCookieName:@"staging",
                                                                     NSHTTPCookieValue:@"true",
                                                                     NSHTTPCookieDomain:@".zaful.com",
                                                                     NSHTTPCookiePath:@"/",
                                                                     }];
    return zaful_cookie;
}

NSHTTPCookie *communityZafulHTTPCookie(void) {
    NSHTTPCookie *community_cookie = [[NSHTTPCookie alloc] initWithProperties:@{
                                                                            NSHTTPCookieName:@"staging",
                                                                            NSHTTPCookieValue:@"true",
                                                                            NSHTTPCookieDomain:@".gloapi.com",
                                                                            NSHTTPCookiePath:@"/",
                                                                            }];
    return community_cookie;
}

/**
 *  添加cookie
 */
void addZafulCookie(void) {
    
    // 网站的cookie
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [storage setCookie:globaleZafulHTTPCookie()];
    
    // 社区的cookie
    [storage setCookie:communityZafulHTTPCookie()];
}

/**
 * 删除cookie
 */
void deleteZafulCookie(void) {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

/**
 App统一获取图片方法, 既能简化代码,又能便于以后统一处理图片 (例如:添加水印等)

 @param name 图片名
 @return 获取的图片
 */
UIImage* ZFImageWithName(NSString *name){
    UIImage *getImage = nil;
    if (ZFJudgeNSString(name)) {
        getImage = [UIImage imageNamed:name];
        
        //不存在再则去.bundle取图片
//        if(!getImage) {
//            getImage = ZFImageFromBundleWithName(name);
//        }
    }
    return getImage;
}

/**
 获取bundle中的图片
 
 @param name 图片名字
 @return 图片
 */
UIImage* ZFImageFromBundleWithName(NSString *name)
{
    if (![name isKindOfClass:[NSString class]] || name.length==0) return nil;
    
    UIImage *getImage = [UIImage imageNamed:name];
    if (getImage) {
        return getImage;
    }
    
    //获取 mainBundle 所有的 bundle 文件夹
    NSArray *bundleArr = [[NSBundle mainBundle] pathsForResourcesOfType:@"bundle" inDirectory:nil];
    
    //排除第三方的bundle目录
    NSMutableArray *allBundleArr = [NSMutableArray arrayWithArray:bundleArr];
    if (allBundleArr.count>0) {
        NSString *bundlePrefix = [allBundleArr[0] lastPathComponent];
        
        NSArray *bundleNameArr = @[@"IQKeyboardManager.bundle", @"XLForm.bundle", @"PYSearch.bundle",
                                    @"MJRefresh.bundle", @"FacebookSDKStrings.bundle", @"GoogleMaps.bundle",
                                    @"GoogleSignIn.bundle", @"TZImagePickerController.bundle"];
        for (NSString *bundleName in bundleNameArr) {
            NSString *removerPath = [NSString stringWithFormat:@"%@/%@",bundlePrefix,bundleName];
            [allBundleArr removeObject:removerPath];
        }
    }
    
    //去自己的bundle下取图片
    for (NSString *bundlePath in allBundleArr) {
        getImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",bundlePath,name] inBundle:[NSBundle bundleForClass:NSClassFromString(@"ZFCFunctionTool")] compatibleWithTraitCollection:nil];
        if (getImage) {
            return getImage;
        }
        
        //遍历目录文件夹
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *folderArray = [fileManager contentsOfDirectoryAtPath:bundlePath error:nil];
        BOOL isDir = NO;
        
        for (NSString *subFolder in folderArray) {
            NSString *fullPath = [bundlePath stringByAppendingPathComponent:subFolder];
            [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
            
            //文件夹
            if (isDir) {
                getImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/%@",bundlePath,subFolder,name] inBundle:[NSBundle bundleForClass:NSClassFromString(@"ZFCFunctionTool")] compatibleWithTraitCollection:nil];
                if (getImage) {
                    return getImage;
                }
            }
        }
    }
    return getImage;
}

NSString *getLaunchImageName(void) {
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    UIWindow *currentWindow = [[UIApplication sharedApplication].windows firstObject];
    CGSize viewSize = currentWindow.bounds.size;
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

/**
 *  产生随机颜色
 */
UIColor* ZFRandomColor(void)
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/**
 *  获取应用版本号
 */
NSString* ZFCurrentAppVersion(void)
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    if (!version) {
        version = @"IOS_X";
    }
    return version;
}

/**
 *  获取应用使用语音
 */
NSString* ZFUserLanguage(void)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:@"userLanguage"];
    return language;
}

/**
 * 设置应用使用语音
 */
void ZFSetUserlanguage(NSString *language)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    [def synchronize];
}

#pragma mark -===========字符串、对象的一些安全操作===========

/**
 * 判断是否为NSString
 */
BOOL ZFJudgeNSString(id obj) {
    if ([obj isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

/**
 * 判断是否为NSDictionary
 */
BOOL ZFJudgeNSDictionary(id obj) {
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

/**
 * 判断是否为NSArray
 */
BOOL ZFJudgeNSArray(id obj) {
    if ([obj isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

/**
 * 判断字符串是否为空
 */
BOOL ZFIsEmptyString(id obj) {
    
    if (![obj isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (obj == nil || obj == NULL) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

/**
 *  转化为NSString来返回，如果为数组或字典转为String返回, 其他对象则返回@""
 *  适用于取一个值后赋值给文本显示时用
 */
NSString * ZFToString(id obj) {
    if (!obj) return @"";
    
    if (ZFJudgeNSString(obj)) {
        return obj;
    }
    
    if (ZFJudgeNSDictionary(obj) || ZFJudgeNSArray(obj)) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];        
        if (jsonData) {
            return [[NSString alloc] initWithData:jsonData encoding:(NSUTF8StringEncoding)];
        }
    }
    
    if (![obj isKindOfClass:[NSNull class]] &&
        ![obj isEqual:nil] &&
        ![obj isEqual:[NSNull null]]) {
        NSString *result = [NSString stringWithFormat:@"%@",obj];
        if (result && result.length > 0) {
            return result;
        }
    }
    return @"";
}


/**
 * 判断是否为自定义对象类
 */
BOOL ZFJudgeClass(id obj, NSString *classString) {
    if (ZFJudgeNSString(classString)) {
        Class myClass = NSClassFromString(classString);
        if (myClass) {
            return [obj isKindOfClass:myClass] ? YES : NO;
        }
    }
    return NO;
}

/**
 * 从数组中获取对象
 */
id ZFGetObjFromArray(NSArray *array, NSInteger index) {
    if (ZFJudgeNSArray(array)) {
        if (array.count > index) {
            return array[index];
        }
    }
    return nil;
}

/**
 * 从字典中获取NSString
 */
NSString * ZFGetStringFromDict(NSDictionary *dictionary, NSString *key) {
    if (ZFJudgeNSDictionary(dictionary) && ZFJudgeNSString(key)) {
        id obj = dictionary[key];
        return ZFToString(obj);
    }
    return @"";
}


@end

