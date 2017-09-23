//
//  qrView.m
//  printer
//  二维码 矩形元素
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "rectView.h"
#import "scaleView.h"
#import "bottomRightScaleView.h"


@implementation rectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image
{
    UIImage *bmp=[self createImage:frame.size.width with:frame.size.height];
    [super initView:frame withImage:bmp];
    
    //右小角放一个缩放图标
    UIImageView *imageV=[[UIImageView alloc] init];
    imageV.image=[UIImage imageNamed:@"Diagonal_expansion_button"];
    imageV.frame=CGRectMake(0, 0, 20, 20);
    
    self.sview=[[bottomRightScaleView alloc] init];
    self.sview.frame=CGRectMake(self.frame.size.width-13, self.frame.size.height-13, 20, 20);
    self.sview.pparent=self.parent;
    self.sview.parent=self;
    self.sview.hidden=YES;
    [self.sview addSubview:imageV];
    [self addSubview:self.sview];
    
}

//创建框图片
-(UIImage*) createImage:(float)w with:(float)h
{
    //生成一张图片
    //false 透明 true 黑底色
    CGSize size=CGSizeMake(w, h);
    UIGraphicsBeginImageContextWithOptions(size,false,0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true); //抗锯齿设置
    
    CGContextSetRGBStrokeColor(context,0,0,0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    
    // 先画矩形框
    if (self.rectType == 3) {
        if(self.fillRect==0)
        {
            /*画圆*/
            //边框圆
            CGContextSetLineWidth(context, self.lineWidth);//线的宽度
            // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
            CGContextAddArc(context, w/2, h/2, w/2, 0, 2*180, 0); //添加一个圆
            CGContextDrawPath(context, kCGPathStroke);
        }
        else
        {
            /*画圆*/
            //边框圆
            //填充圆，无边框
            CGContextAddArc(context, w/2, h/2, w/2, 0, 2*180, 0); //添加一个圆
            CGContextDrawPath(context, kCGPathFill);//绘制填充
        }
    } else if (self.rectType == 2) {
        if(self.fillRect==0)
        {
            // 画椭圆
            CGContextAddEllipseInRect(context, CGRectMake(0, 0, w, h));
            //椭圆
            CGContextDrawPath(context, kCGPathStroke);
        }
        else
        {
            // 画椭圆
            CGContextAddEllipseInRect(context, CGRectMake(0, 0, w, h));
            //椭圆
            CGContextDrawPath(context, kCGPathFill);
        }
    } else if (self.rectType == 1) {
        // 圆角矩形
        /*画圆角矩形*/
        
        CGContextMoveToPoint(context, w, h-10);  // 开始坐标右边开始
        CGContextAddArcToPoint(context, w, h, w-20, h, 10);  // 右下角角度
        CGContextAddArcToPoint(context, 0, h, 0, h-20, 10); // 左下角角度
        CGContextAddArcToPoint(context, 0, 0, w-20, 0, 10); // 左上角
        CGContextAddArcToPoint(context, w, 0, w, h-10, 10); // 右上角
        CGContextClosePath(context);
        
        if(self.fillRect==0)
        {
            CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
        }
        else
        {
            CGContextDrawPath(context, kCGPathFill); //根据坐标绘制路径
        }
    } else {
        /*画矩形*/
        if(self.fillRect==0){
            CGContextStrokeRect(context,CGRectMake(0, 0, w, h));//画方框
        }
        else{
            CGContextFillRect(context,CGRectMake(0, 0, w, h));//填充框
        }
        
    }
    
    //把当前context的内容输出成一个UIImage图片
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    return img;
}

-(void) rotate
{
    [super rotate];
    
    
}

//刷新
-(void) refresh
{
    [super refresh];
    if(self.isslected==1)
    {
        self.sview.hidden=NO;
    }
    else
    {
        self.sview.hidden=YES;
    }
}

@end
