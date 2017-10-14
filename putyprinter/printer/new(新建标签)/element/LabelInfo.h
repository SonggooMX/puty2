//
//  LabelInfo.h
//  printer
//
//  Created by songgoo on 2017/10/12.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelInfo : NSObject

@property NSString *labelName;
@property int printSpeed;
@property int printDes;
@property float labelWidth;
@property float labelHeight;
@property int printDirect;
@property float scale;
@property int pagetType;

//打印水平 垂直方向偏移量
@property float printHpadding;
@property float printVpadding;

//标签锁定
@property BOOL isLock;

@end
