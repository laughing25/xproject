//
//  CMHKLanguagesManager.m
//  CMHKXYYD
//
//  Created by 7爷 on 2017/10/18.
//  Copyright © 2017年 CMHK. All rights reserved.
//

#import "CMHKLanguagesManager.h"
#import <objc/runtime.h>

///<用户默认语言
static NSString *CMHKUserDefaultLanguagesKey = @"CMHKUserDefaultLanguagesKey";

@interface CMHKLanguagesManager()
@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation CMHKLanguagesManager

+(instancetype)shareManager
{
    static CMHKLanguagesManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CMHKLanguagesManager alloc] init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

-(void)changeLanguage:(NSString *)languageKey
{
    if (![[self currentLanguage] isEqualToString:languageKey]) {
    
        [self saveLanguage:languageKey];
        
        [self changeBundle:languageKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CMHKLanguagesManagerDidChange object:languageKey];
    }
}

-(void)saveLanguage:(NSString *)languageKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:languageKey forKey:CMHKUserDefaultLanguagesKey];
    NSLog(@"CMHKUserDefaultLanguagesKey ---%@", languageKey);
}

-(void)changeBundle:(NSString *)languageKey
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:languageKey] ofType:@"lproj"];
    if (!path) {
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
    self.bundle = [NSBundle bundleWithPath:path];
}

- (NSString *)languageFormat:(NSString*)language {
    if([language rangeOfString:@"zh-Hans"].location != NSNotFound){
        return @"si";
    }else if([language rangeOfString:@"zh-Hant"].location != NSNotFound){
        return @"tr";
    }else{
        //字符串查找
        if([language rangeOfString:@"-"].location != NSNotFound) {
            //除了中文以外的其他语言统一处理@"ru_RU" @"ko_KR"取前面一部分
            NSArray *ary = [language componentsSeparatedByString:@"-"];
            if (ary.count > 1) {
                NSString *str = ary[0];
                return str;
            }
        }
    }
    return language;
}

-(NSString *)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *language = [defaults objectForKey:CMHKUserDefaultLanguagesKey];
    NSLog(@"%@", language);
    return language;
}

//获取当前语种下的内容
-(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value {
    if (!_bundle) {
        [self initUserLanguage];
    }
    
    if (key.length > 0) {
        if (_bundle) {
            NSString *str = NSLocalizedStringFromTableInBundle(key, @"Localizable", _bundle, value);
            if (str.length > 0) {
                return str;
            }
        }
    }
    return @"";
}

- (void)initUserLanguage {
    
    NSString *currentLanguage = [self currentLanguage];
    
    if(currentLanguage.length == 0){
        
        //获取系统偏好语言数组
        NSArray *languages = [NSLocale preferredLanguages];
        //第一个为当前语言
        currentLanguage = [languages objectAtIndex:0];
        
        [self saveLanguage:currentLanguage];
    }

    [self changeBundle:currentLanguage];
}

-(NSArray *)localizedLanguageList
{
    return @[@"en", @"si"];
}

@end

#pragma mark - CMHKLanguagesModel

@interface CMHKLanguagesModel ()
@property (nonatomic, copy) LanguageChangeBlock changeBlock;
@property (nonatomic, copy) LocailLanguageSelectorAndValuesList selectorAndValuesList;
@property (nonatomic, strong) NSMutableDictionary *languageSelectorAndValuesParams;
@end

@implementation CMHKLanguagesModel

-(LocailLanguageChangeBlock)locailBlock
{
    __weak CMHKLanguagesModel *weakSelf = self;
    
    return ^(LanguageChangeBlock block){
        
        if (block) {
            weakSelf.changeBlock = block;
        }
        return weakSelf;
    };
}

-(LocailLanguageSelectorAndValues)locailAddSelector
{
    __weak typeof(self) weakSelf = self;
    
    return ^(id target, SEL selector, ...){
        
        if (!selector) {
            return weakSelf;
        }
        
        NSMutableArray *argList = [NSMutableArray array];
        
        va_list list;
        
        va_start(list, selector);
        
        id arg;
        
        while ((arg = va_arg(list, id))) {
            [argList addObject:arg];
        }
        
        va_end(list);
        
        return weakSelf.selectorAndValuesList(target, selector, argList);
    };
}

-(LocailLanguageSelectorAndValuesList)selectorAndValuesList
{
    __weak typeof(self) weakSelf = self;
    
    return ^(id target, SEL sel, NSArray *argList){
        
        if (!sel) {
            return weakSelf;
        }
        
        if (!argList) {
            return weakSelf;
        }
        
        NSString *key = NSStringFromSelector(sel);
        
        NSMutableArray *values = weakSelf.languageSelectorAndValuesParams[key];
        
        if (!values) {
            values = [[NSMutableArray alloc] init];
        }
        
        ///至多设置一个本地语言相应方法
        if ([values count] > 0) {
            [values removeAllObjects];
        }
        
        if (argList && [argList count] > 0) {
            [values addObject:argList];
        }
        
        [weakSelf invocation:target select:sel arglist:argList];
        
        [weakSelf.languageSelectorAndValuesParams setObject:values forKey:key];
        
        return weakSelf;
    };
}

-(NSMutableDictionary *)languageSelectorAndValuesParams
{
    if (!_languageSelectorAndValuesParams) {
        _languageSelectorAndValuesParams = [NSMutableDictionary dictionary];
    }
    return _languageSelectorAndValuesParams;
}

//-(void)dealloc
//{
//    NSLog(@"CMHKLanguagesModel dealloc");
//}

@end

#pragma mark - NSObject Language Category

@implementation NSObject (Language)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"dealloc"];

        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {

            NSString *leeSelString = @"language_dealloc";//[@"language_test_" stringByAppendingString:selString];

            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));

            Method leeMethod = class_getInstanceMethod(self, NSSelectorFromString(leeSelString));

            BOOL isAddedMethod = class_addMethod(self, NSSelectorFromString(selString), method_getImplementation(leeMethod), method_getTypeEncoding(leeMethod));

            if (isAddedMethod) {
                class_replaceMethod(self, NSSelectorFromString(leeSelString), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, leeMethod);
            }
        }];
    });
}

-(void)language_dealloc
{
    if ([self isLocail]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:CMHKLanguagesManagerDidChange object:nil];
        objc_removeAssociatedObjects(self);
    }
    [self language_dealloc];
}

-(void)LanguageDidChangeNotification:(NSNotification *)sender
{
    if (![self.locailModel.changeBlock isKindOfClass:NSNull.class]) {
        if (self.locailModel.changeBlock) {
            self.locailModel.changeBlock(kLocalizedString(self.locailModel.locailKey, nil));
        } 
    }
    
    for (NSString *selector in self.locailModel.languageSelectorAndValuesParams) {
        NSArray *values = self.locailModel.languageSelectorAndValuesParams[selector];
        
        SEL sel = NSSelectorFromString(selector);
        
        for (NSArray *valueList in values) {
            [self invocation:self select:sel arglist:valueList];
        }
    }
}

-(void)invocation:(id)target select:(SEL)select arglist:(NSArray *)arglist
{
    NSMethodSignature *sig = [target methodSignatureForSelector:select];
    
    if (!sig) {
        [target doesNotRecognizeSelector:select];
    }
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    
    if (!inv) {
        [target doesNotRecognizeSelector:select];
    }
    
    [inv setTarget:target];
    
    [inv setSelector:select];
    
    if (sig.numberOfArguments == arglist.count + 2) {
        ///配置方法参数
        [arglist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //转化locailModel
            if ([obj isKindOfClass:[NSString class]]) {
                obj = kLocalizedString(obj, nil);
            }
            NSInteger index = idx + 2;
            [self setInv:inv Sig:sig Obj:obj Index:index];
        }];
        [inv invoke];
    }else{
        NSAssert(YES, @"参数个数与方法参数个数不匹配");
    }
}

-(void)setLocailModel:(CMHKLanguagesModel *)locailModel
{
    if (self) {
        objc_setAssociatedObject(self, @selector(locailModel), locailModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(CMHKLanguagesModel *)locailModel
{
    CMHKLanguagesModel *model = objc_getAssociatedObject(self, _cmd);
    
    if (!model) {
        model = [CMHKLanguagesModel new];
        
        objc_setAssociatedObject(self, _cmd, model , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setIsLocail:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LanguageDidChangeNotification:) name:CMHKLanguagesManagerDidChange object:nil];
    }
    return model;
}

-(BOOL)isLocail
{
    return self ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

-(void)setIsLocail:(BOOL)isLocail
{
    if (self) {
        objc_setAssociatedObject(self, @selector(isLocail), [NSNumber numberWithBool:isLocail], OBJC_ASSOCIATION_ASSIGN);
    }
}

- (void)setInv:(NSInvocation *)inv Sig:(NSMethodSignature *)sig Obj:(id)obj Index:(NSInteger)index{
    
    if (sig.numberOfArguments <= index) return;
    
    char *type = (char *)[sig getArgumentTypeAtIndex:index];
    
    while (*type == 'r' || // const
           *type == 'n' || // in
           *type == 'N' || // inout
           *type == 'o' || // out
           *type == 'O' || // bycopy
           *type == 'R' || // byref
           *type == 'V') { // oneway
        type++; // cutoff useless prefix
    }
    
    BOOL unsupportedType = NO;
    
    switch (*type) {
        case 'v': // 1: void
        case 'B': // 1: bool
        case 'c': // 1: char / BOOL
        case 'C': // 1: unsigned char
        case 's': // 2: short
        case 'S': // 2: unsigned short
        case 'i': // 4: int / NSInteger(32bit)
        case 'I': // 4: unsigned int / NSUInteger(32bit)
        case 'l': // 4: long(32bit)
        case 'L': // 4: unsigned long(32bit)
        { // 'char' and 'short' will be promoted to 'int'.
            int value = [obj intValue];
            [inv setArgument:&value atIndex:index];
        } break;
            
        case 'q': // 8: long long / long(64bit) / NSInteger(64bit)
        case 'Q': // 8: unsigned long long / unsigned long(64bit) / NSUInteger(64bit)
        {
        long long value = [obj longLongValue];
        [inv setArgument:&value atIndex:index];
        } break;
            
        case 'f': // 4: float / CGFloat(32bit)
        { // 'float' will be promoted to 'double'.
            double value = [obj doubleValue];
            float valuef = value;
            [inv setArgument:&valuef atIndex:index];
        } break;
            
        case 'd': // 8: double / CGFloat(64bit)
        {
        double value = [obj doubleValue];
        [inv setArgument:&value atIndex:index];
        } break;
            
        case '*': // char *
        case '^': // pointer
        {
        if ([obj isKindOfClass:UIColor.class]) obj = (id)[obj CGColor]; //CGColor转换
        if ([obj isKindOfClass:UIImage.class]) obj = (id)[obj CGImage]; //CGImage转换
        void *value = (__bridge void *)obj;
        [inv setArgument:&value atIndex:index];
        } break;
            
        case '@': // id
        {
        id value = obj;
        [inv setArgument:&value atIndex:index];
        } break;
            
        case '{': // struct
        {
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint value = [obj CGPointValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(CGSize)) == 0) {
            CGSize value = [obj CGSizeValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(CGRect)) == 0) {
            CGRect value = [obj CGRectValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(CGVector)) == 0) {
            CGVector value = [obj CGVectorValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(CGAffineTransform)) == 0) {
            CGAffineTransform value = [obj CGAffineTransformValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(CATransform3D)) == 0) {
            CATransform3D value = [obj CATransform3DValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(NSRange)) == 0) {
            NSRange value = [obj rangeValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(UIOffset)) == 0) {
            UIOffset value = [obj UIOffsetValue];
            [inv setArgument:&value atIndex:index];
        } else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
            UIEdgeInsets value = [obj UIEdgeInsetsValue];
            [inv setArgument:&value atIndex:index];
        } else {
            unsupportedType = YES;
        }
        } break;
            
        case '(': // union
        {
        unsupportedType = YES;
        } break;
            
        case '[': // array
        {
        unsupportedType = YES;
        } break;
            
        default: // what?!
        {
        unsupportedType = YES;
        } break;
    }
    
    NSAssert(unsupportedType == NO, @"方法的参数类型暂不支持");
}

@end

