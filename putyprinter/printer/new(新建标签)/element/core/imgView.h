//
//  qrView.h
//  printer
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"

@interface imgView : baseView


//图片灰度值
@property float grayValue;

//黑白显示
@property BOOL isBlack;

//图片路径
@property NSString *imgPath;

//图片缩放
@property BOOL isScale;

//原始图片
@property UIImage *sourceImage;

@end
