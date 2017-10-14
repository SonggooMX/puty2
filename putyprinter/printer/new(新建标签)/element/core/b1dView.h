//
//  b1dView.h
//  printer
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"
#import "ZXingObjC/ZXWriter.h"
#import "ZXingObjC/ZXImage.h"
#import "ZXingObjC/ZXEncodeHints.h"
#import "ZXingObjC/ZXMultiFormatWriter.h"

@interface b1dView : baseView

-(void) resetViewWH:(CGSize)size;

//编码模式
@property int encodeMode;
//文本显示模式
@property int showTextMode;

@end
