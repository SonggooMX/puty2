//
//  UIScreen+CZAddition.h
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (CZAddition)

/// 屏幕宽度
+ (CGFloat)cz_screenWidth;
/// 屏幕高度
+ (CGFloat)cz_screenHeight;
/// 分辨率
+ (CGFloat)cz_scale;

@end
