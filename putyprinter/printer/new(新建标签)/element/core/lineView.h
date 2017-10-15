//
//  qrView.h
//  printer   矩形元素
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"

@interface lineView : baseView

//线宽
@property float lineWidth;

//虚线间隔
@property int lineSpace;

//0 实线 1 虚线
@property int lineType;


@end
