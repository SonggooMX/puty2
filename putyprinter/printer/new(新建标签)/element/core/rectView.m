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

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    self.lineWidth=1;
    UIImage *bmp=[self createImage:frame.size.width with:frame.size.height];
    [super initView:frame withImage:bmp withNString:content];
    [self resetViewWH:frame.size];
    
    //右小角放一个缩放图标
    [self showScaleView];
    
}

//重新设置宽高
-(void) resetViewWH:(CGSize)size
{
    [super resetViewWH:size];
    
    if(self.direction==1||self.direction==3)
    {
        ((UIImageView*)self.containerView).image=[self createImage:size.height with:size.width];
    }
    else
    {
        ((UIImageView*)self.containerView).image=[self createImage:size.width with:size.height];
    }

    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    if(self.direction==0||self.direction==2){
        self.containerView.frame=CGRectMake(self.containerView.frame.origin.y, self.containerView.frame.origin.x, size.width, size.height);
        self.rightView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
        
        self.bottomView.frame=CGRectMake((self.frame.size.width-20)/2, self.frame.size.height-10, 20, 20);
    }
    else
    {
        self.containerView.frame=CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, size.height, size.width);
        self.rightView.frame=CGRectMake(self.frame.size.height-10, (self.frame.size.width-20)/2, 20, 20);
        
        self.bottomView.frame=CGRectMake((self.frame.size.height-20)/2, self.frame.size.width-10, 20, 20);
    }
}

-(void) showScaleView
{
    [super showScaleView];
    
    self.rightView=[[leftScaleView alloc] init];
    self.rightView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
    self.rightView.hidden=YES;
    self.rightView.pparent=self.parent;
    self.rightView.parent=self;
    
    //右小角放一个缩放图标
    UIImageView *rightImage=[[UIImageView alloc] init];
    rightImage.image=[UIImage imageNamed:@"Left_and_right_expansion_button"];
    rightImage.frame=CGRectMake(0, 0, 20, 20);
    [self.rightView addSubview:rightImage];
    [self addSubview:self.rightView];
    
    
    self.bottomView=[[BottomScaleView alloc] init];
    self.bottomView.frame=CGRectMake((self.frame.size.width-20)/2, self.frame.size.height-10, 20, 20);
    self.bottomView.hidden=YES;
    self.bottomView.pparent=self.parent;
    self.bottomView.parent=self;
    
    UIImageView *bottomImage=[[UIImageView alloc] init];
    bottomImage.image=[UIImage imageNamed:@"Up_and_down_expansion_button"];
    bottomImage.frame=CGRectMake(0, 0, 20, 20);
    [self.bottomView addSubview:bottomImage];
    [self addSubview:self.bottomView];
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
    CGContextSetLineWidth(context, self.lineWidth);//线的宽度
    
    // 先画矩形框
    if (self.rectType == 3) {
        
        float lw=w>h?h:w;
        
        if(self.fillRect==0)
        {
            /*画圆*/
            //边框圆
            CGContextSetLineWidth(context, self.lineWidth);//线的宽度
            // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
            CGContextAddArc(context, w/2, h/2, lw/2-self.lineWidth, 0, 2*180, 0); //添加一个圆
            CGContextDrawPath(context, kCGPathStroke);
        }
        else
        {
            /*画圆*/
            //边框圆
            //填充圆，无边框
            CGContextAddArc(context, w/2, h/2, lw/2-self.lineWidth, 0, 2*180, 0); //添加一个圆
            CGContextDrawPath(context, kCGPathFill);//绘制填充
        }
    } else if (self.rectType == 2) {
        if(self.fillRect==0)
        {
            // 画椭圆
            CGContextAddEllipseInRect(context, CGRectMake(self.lineWidth, self.lineWidth, w-self.lineWidth*2, h-self.lineWidth*2));
            //椭圆
            CGContextDrawPath(context, kCGPathStroke);
        }
        else
        {
            // 画椭圆
            CGContextAddEllipseInRect(context, CGRectMake(self.lineWidth, self.lineWidth, w-self.lineWidth*2, h-self.lineWidth*2));
            //椭圆
            CGContextDrawPath(context, kCGPathFill);
        }
    } else if (self.rectType == 1) {
        // 圆角矩形
        /*画圆角矩形*/
        
        CGContextMoveToPoint(context, w-self.lineWidth, h-10-self.lineWidth);  // 开始坐标右边开始
        CGContextAddArcToPoint(context, w-self.lineWidth, h-self.lineWidth,
                               w-20-self.lineWidth, h-self.lineWidth, 10);  // 右下角角度
        CGContextAddArcToPoint(context, self.lineWidth, h-self.lineWidth, self.lineWidth, h-20-self.lineWidth, 10); // 左下角角度
        CGContextAddArcToPoint(context, self.lineWidth, self.lineWidth,w-20-self.lineWidth, self.lineWidth, 10); // 左上角
        CGContextAddArcToPoint(context, w-self.lineWidth, self.lineWidth,w-self.lineWidth, h-10-self.lineWidth, 10); // 右上角
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
            CGContextStrokeRect(context,CGRectMake(self.lineWidth, self.lineWidth, w-self.lineWidth*2, h-self.lineWidth*2));//画方框
        }
        else{
            CGContextFillRect(context,CGRectMake(self.lineWidth, self.lineWidth, w-self.lineWidth*2, h-self.lineWidth*2));//填充框
        }
        
    }
    
    //把当前context的内容输出成一个UIImage图片
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    return img;
}

-(void) rotate:(int)angle
{
    [super rotate:angle];
    
    
}

//刷新
-(void) refresh
{
    [super refresh];
    if(self.isslected==1&&self.isLock==0)
    {
        self.rightView.hidden=NO;
        self.bottomView.hidden=NO;
    }
    else
    {
        self.rightView.hidden=YES;
        self.bottomView.hidden=YES;
    }
}

@end
