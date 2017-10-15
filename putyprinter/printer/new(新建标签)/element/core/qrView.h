//
//  qrView.h
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

@interface qrView : baseView

//二维码类型
@property int codeType;

//编码方式
@property int encodeMode;
//纠错级别
@property int errorLevel;

@end
