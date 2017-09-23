//
//  qrView.m
//  printer
//  二维码 矩形元素
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "lineView.h"
#import "scaleView.h"
#import "bottomRightScaleView.h"


@implementation lineView

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
    CGContextSetLineWidth(context, 2.0);//线的宽度
    
    // 先画矩形框
    if (self.lineType == 0)
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, (h)/2);  //起点坐标
        CGContextAddLineToPoint(context, w, (h)/2);   //终点坐标
        CGContextStrokePath(context);
    }
    else
    {
        //设置虚线绘制起点
        CGContextMoveToPoint(context, 0, (h)/2);
        //设置虚线绘制终点
        CGContextAddLineToPoint(context, w, (h)/2);
        //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
        CGFloat arr[] = {3,3};
        //下面最后一个参数“2”代表排列的个数。
        CGContextSetLineDash(context, 0, arr, 1);
        CGContextDrawPath(context, kCGPathStroke);
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
