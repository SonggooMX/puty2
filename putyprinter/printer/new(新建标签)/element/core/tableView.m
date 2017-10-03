//
//  qrView.m
//  printer
//  二维码 矩形元素
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "tableView.h"
#import "scaleView.h"
#import "bottomRightScaleView.h"


@implementation tableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString *)content
{
    self.lineWidth=1.0;
    self.rows=2;
    self.cols=2;
    
    UIImage *bmp=[self createImage:frame.size.width with:frame.size.height];
    
    [super initView:frame withImage:bmp withNString:content];
    
    [self showScaleView];
    
}

//重新设置宽高
-(void) resetViewWH:(CGSize)size
{
    UIImage *bmp=[self createImage:size.width with:size.height];
    self.bmp=bmp;
    ((UIImageView*)self.containerView).image=bmp;
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    self.containerView.frame=CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, size.width, size.height);
    
    self.rightView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
    
    self.bottomView.frame=CGRectMake((self.frame.size.width-20)/2, self.frame.size.height-10, 20, 20);
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
    
    CGContextStrokeRect(context,CGRectMake(self.lineWidth, self.lineWidth, w-self.lineWidth*2, h-self.lineWidth*2));//画方框
    
    float rowHeight=h/self.rows;
    for(int i=0;i<self.rows-1;i++)
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, self.lineWidth, (rowHeight)*(i+1));  //起点坐标
        CGContextAddLineToPoint(context, w-self.lineWidth, (rowHeight)*(i+1));   //终点坐标
        CGContextStrokePath(context);
    }
    
    float colHeight=w/self.cols;
    for(int i=0;i<self.cols-1;i++)
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context,(colHeight)*(i+1),self.lineWidth);  //起点坐标
        CGContextAddLineToPoint(context,(colHeight)*(i+1),h-self.lineWidth);   //终点坐标
        CGContextStrokePath(context);
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
