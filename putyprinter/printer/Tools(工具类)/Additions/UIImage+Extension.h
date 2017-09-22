//
//  UIImage+Extension.h
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/// 根据当前图像，和指定的尺寸，生成圆角图像并且返回
- (void)cz_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

@end
