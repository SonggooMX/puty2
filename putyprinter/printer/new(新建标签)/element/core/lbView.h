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

-(void) setWarp:(int)autoWarp;

//行间距
@property float rowSpaceHeight;
//行距模式 0 默认 1 自定义
@property int rowSpaceMode;

//字符间距
@property float charSpaceWidth;

-(void) initView:(CGRect)frame withContent:(NSString*)content;
-(void) initView:(CGRect)frame withImage:(UIImage*)image withNString:(NSString *)content;

-(void) setLineSpace:(float)height withMode:(int)mode;

-(CGRect) getLineSpace:(UILabel *)lb withW:(float)width;

-(CGRect) getContentRect:(UILabel *)lb withW:(float)width;

@end
