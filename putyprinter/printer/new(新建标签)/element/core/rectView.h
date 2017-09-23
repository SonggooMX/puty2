//
//  qrView.h
//  printer   矩形元素
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"

@interface rectView : baseView
@property const NSString *content;

//内部填充
@property int fillRect;
//线宽
@property float lineWidth;

//0 直角矩形 1 圆角矩形
//2 椭圆 3 圆
@property int rectType;

//圆角半径
@property float rWidth;

@end
