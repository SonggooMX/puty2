//
//  barcode1d.m
//  printer
//
//  Created by songgoo on 2017/7/22.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"
#import "NewLabelViewController.h"

@implementation baseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    self.frame=frame;
    self.content=content;
    UIImageView *view=[[UIImageView alloc] initWithImage:image];
    view.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self addSubview:view];
    self.containerView=view;
    [self refresh];
}

-(void) rotate
{
    self.direction++;
    self.direction=self.direction>3?0:self.direction;
    UIView *first=self;
    first.transform=CGAffineTransformRotate(first.transform, M_PI_2);
    
    [self refresh];
}

-(UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void) refresh
{
    if(self.isslected==1)
    {
        self.layer.borderWidth=1;
        self.layer.borderColor=[UIColor colorWithRed:1.0/255 green:124.0/255 blue:226.0/255 alpha:1.000].CGColor;
    }
    else
    {
        self.layer.borderWidth=0;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //取消所有元素选中
    int len=(int)self.parent.subviews.count;
    for(int i=1;i<len;i++)
    {
        baseView *bs=(baseView*)self.parent.subviews[i];
        bs.isslected=0;
        [bs refresh];
    }
    
    //将当期元素置于顶端
    [self.parent bringSubviewToFront:self];
    self.isslected=1;
    [self refresh];
    
    UITouch *touch = [touches anyObject];
    self.beginpoint = [touch locationInView:self.parent];
    //[super touchesBegan:touches withEvent:event];
    
    //设置选中元素的属性
    [self.parentController setElementPropety:self.elementType withSelect:true withElement:self];
}

//元素的移动 核心代码
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.isLock==1) return;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.parent];
    CGRect frame = self.frame;
    
    //NSLog(@"sx:%f,sy:%f",self.beginpoint.x,self.beginpoint.y);
    //NSLog(@"x:%f,y:%f",currentLocation.x,currentLocation.y);

    int directX=currentLocation.x-self.beginpoint.x;
    int directY=currentLocation.y - self.beginpoint.y;
    
    //NSLog(@"dx:%d,dy:%d",directX,directY);
    
   frame.origin.x+=directX;
    
    frame.origin.y+=directY;
    
    //检查是否超出边界
    frame.origin.x=frame.origin.x<=5?5:frame.origin.x;
    frame.origin.y=frame.origin.y<=5?5:frame.origin.y;
    if(frame.origin.x+frame.size.width+5>=self.parent.frame.size.width)
    {
        frame.origin.x=self.parent.frame.size.width-frame.size.width-5;
    }
    if(frame.origin.y+frame.size.height+5>=self.parent.frame.size.height)
    {
        frame.origin.y=self.parent.frame.size.height-frame.size.height-5;
    }
    
    self.beginpoint=currentLocation;
    
    self.frame = frame;
    
    [self refreshMsg];
}

-(void) refreshMsg
{
    //刷新位置
    NewLabelViewController *nlc=(NewLabelViewController*)self.parentController;
    float scale=nlc.LabelSacle;
    self.scale=scale;
    NSString *msg=[NSString stringWithFormat:@"X:%.2fmm  Y:%.2fmm  宽:%.2fmm  高:%.2fmm",(self.frame.origin.x/scale)/8,self.frame.origin.y/scale/8,self.frame.size.width/scale/8,self.frame.size.height/scale/8];
    [nlc updateTip:msg];
}

-(float) getXMM
{
    return self.frame.origin.x/self.scale/8;
}

-(float) getYMM
{
    return self.frame.origin.y/self.scale/8;
}

-(float) getWidthMM
{
    return self.frame.size.width/self.scale/8;
}
-(float) getHeightMM
{
    return self.frame.size.height/self.scale/8;
}

@end
