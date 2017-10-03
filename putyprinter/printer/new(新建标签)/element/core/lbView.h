//
//  lbView.h
//  printer
//
//  Created by songgoo on 2017/7/26.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"

@interface lbView : baseView

//自动换行
@property int autoWarp;
//行间距
@property float rowSpaceHeight;
//字符间距
@property float charSpaceWidth;
//字体名称
@property NSString *fontName;
//字体大小
@property int fontSizeIndex;
//对齐模式 
@property int alignMode;

-(void) initView:(CGRect)frame withContent:(NSString*)content;
-(void) initView:(CGRect)frame withImage:(UIImage*)image withNString:(NSString *)content;

@end
