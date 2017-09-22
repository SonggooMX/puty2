//
//  TianJinDLConfig.h
//  TianJinDL
//  Copyright © 2017年 troilamac. All rights reserved.
//


#define TianJinDLConfig_h


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define tabH  self.tabBar.frame.size.height
#define DLColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Color(hex)  [UIColor colorWithHexString:hex]

//红色 蓝色
#define RED  [UIColor colorWithHexString:@"#1080cc"]
//#define RED  [UIColor colorWithHexString:@"#EF2D36"]
#define BLUE [UIColor colorWithHexString:@"#EF2D36"]
//线的颜色浅灰
#define LineColor [UIColor colorWithHexString:@"#EEEEEE"]
//灰字
#define grayTint [UIColor colorWithHexString:@"#999999"]
#define liuliuliu [UIColor colorWithHexString:@"#666666"]
#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//字体PingFang
#define PF @"PingFang SC"
//APP版本号
#define APPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//iOS系统
#define iOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]
//release版本禁止日志输出
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif
#define NETERROR  @"联网失败，请检查网络"
#define Success [[[responseObject objectForKey:@"header"] objectForKey:@"code"] isEqualToString:@"1"]
#define Failure [[[responseObject objectForKey:@"header"] objectForKey:@"code"] isEqualToString:@"0"]
#define LoginOut [[[responseObject objectForKey:@"header"] objectForKey:@"code"] isEqualToString:@"99"]
#define Header [responseObject objectForKey:@"header"]
#define Data   [responseObject objectForKey:@"data"]
#define UserID  [MeLoginTool getUserId]
#define UserToken  [MeLoginTool getUserToken]

#define EmptyTitle iOS_Version >= 7.0 ? @"" : @" "

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif
