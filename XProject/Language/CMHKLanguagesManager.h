//
//  CMHKLanguagesManager.h
//  CMHKXYYD
//
//  Created by 7爷 on 2017/10/18.
//  Copyright © 2017年 CMHK. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - CMHKLanguagesManager

static NSString *CMHKLanguagesManagerDidChange = @"CMHKLanguagesManagerDidChange";

@interface CMHKLanguagesManager : NSObject

+(instancetype)shareManager;

///初始化语言
-(void)initUserLanguage;

///更改语言
-(void)changeLanguage:(NSString *)languageKey;

///获取当前语种下的内容
-(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

///获取当前语种
-(NSString *)currentLanguage;

///获取支持语种列表
-(NSArray *)localizedLanguageList;

@property (nonatomic, copy) NSString *langugeKey;

@end

#pragma mark - NSObject Language Category

@class CMHKLanguagesModel;
typedef void(^LanguageChangeBlock)(NSString *locailKey);
typedef CMHKLanguagesModel *(^LocailLanguageChangeBlock)(LanguageChangeBlock);
typedef CMHKLanguagesModel *(^LocailLanguageSelectorAndValues)(id target, SEL sel, ...);
typedef CMHKLanguagesModel *(^LocailLanguageSelectorAndValuesList)(id target, SEL sel, NSArray *argList);

@interface CMHKLanguagesModel : NSObject

@property (nonatomic, copy) NSString *locailKey;
///更换完毕后的回调
@property (nonatomic, copy) LocailLanguageChangeBlock locailBlock;
///目标，方法，和参数
@property (nonatomic, copy) LocailLanguageSelectorAndValues locailAddSelector;

@end

#pragma mark - NSObject+Language

@interface NSObject (Language)

@property (nonatomic, strong) CMHKLanguagesModel *locailModel;
@property (nonatomic, assign) BOOL isLocail;

///执行一个方法
-(void)invocation:(id)target select:(SEL)select arglist:(NSArray *)arglist;

@end

#define kLocalizedString(key, comment) [[CMHKLanguagesManager shareManager] localizedStringForKey:key value:comment]
