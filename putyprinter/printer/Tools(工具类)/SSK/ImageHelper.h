//
//  ImageHelper.h
//  printer
//
//  Created by songgoo on 2017/9/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
