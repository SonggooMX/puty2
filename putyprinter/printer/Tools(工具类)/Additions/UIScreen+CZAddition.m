//
//  UIScreen+CZAddition.m
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "UIScreen+CZAddition.h"

@implementation UIScreen (CZAddition)

+ (CGFloat)cz_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)cz_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)cz_scale {
    return [UIScreen mainScreen].scale;
}

@end
