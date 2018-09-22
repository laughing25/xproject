//
//  ZFColorDefiner.h
//  Zaful
//
//  Created by maowangxin on 2018/3/30.
//  Copyright © 2018年 Y001. All rights reserved.
//

#ifndef ZFColorDefiner_h
#define ZFColorDefiner_h

#pragma mark -==============================RGB/十六进制颜色===============================
// 主背景颜色
#define BADGE_BACKGROUNDCOLOR           ZFCOLOR(255, 168, 0, 1.0)

// 黄色 (个人页面主色)
#define ZFYELLOWColor                   ZFCOLOR(255, 168, 0, 1.f)

// 白颜色
#define ZFCOLOR_WHITE                   [UIColor whiteColor]
//黑色
#define ZFCOLOR_BLACK                   [UIColor blackColor]
// RGB颜色
#define ZFCOLOR(r,g,b,a)                [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 十六进制颜色
#define ColorHex_Alpha(hexValue, al)    [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:al]
// 随机颜色
#define ZFCOLOR_RANDOM                  ZFCOLOR((arc4random()%255), (arc4random()%255), (arc4random()%255), 1.0)


#endif /* ZFColorDefiner_h */
