//
//  b1dBottomScaleView.m
//  printer
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"
#import "BottomScaleView.h"

@implementation BottomScaleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //将当期元素置于顶端
    [self.parent bringSubviewToFront:self];
    
    UITouch *touch = [touches anyObject];
    self.beginpoint = [touch locationInView:self.pparent];
    //[super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [((baseView*)self.parent) resetViewWH:self.parent.frame.size];
    //baseView *bv=(baseView*)self.parent;
    //[bv initView:bv.frame withImage:nil withNString:bv.content];
}

//一维码缩放
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.pparent];
    
    //NSLog(@"sx:%f,sy:%f",self.beginpoint.x,self.beginpoint.y);
    //NSLog(@"x:%f,y:%f",currentLocation.x,currentLocation.y);
    
    float directX=currentLocation.x-self.beginpoint.x;
    float directY=currentLocation.y-self.beginpoint.y;
    
    //一维码顶层容器view
    baseView *sp=(baseView*)self.parent;
    
    //NSLog(@"dx:%d,dy:%d",directX,directY);
    
    self.beginpoint=currentLocation;
    
    CGRect frame=self.superview.frame;
    if(sp.direction==1)
    {
        if(directX<0)
        {
            frame.size.width+=fabs(directX);
            frame.origin.x-=fabs(directX);
        }
        else
        {
            frame.size.width-=fabs(directX);
            frame.origin.x+=fabs(directX);
        }
    }
    else if(sp.direction==2)
    {
        if(directY<0)
        {
            frame.size.height+=fabs(directY);
            frame.origin.y-=fabs(directY);
        }
        else
        {
            frame.size.height-=fabs(directY);
            frame.origin.y+=fabs(directY);
        }
    }
    else if(sp.direction==3)
    {
        if(directX<0)
        {
            frame.size.width-=fabs(directX);
        }
        else
        {
            frame.size.width+=fabs(directX);
        }
    }
    else
    {
        frame.size.height+=directY;
    }
    
    self.superview.frame=frame;
    
    //图片 一维码图片view uiiamgeview
    UIView *cv=self.superview.subviews.firstObject;
    CGRect cframe=cv.frame;
    if(sp.direction==1)
    {
        if(directX<0)
        {
            cframe.size.height+=fabs(directX);
        }
        else
        {
            cframe.size.height-=fabs(directX);
        }
    }
    else  if(sp.direction==2)
    {
        if(directY<0)
        {
            cframe.size.height+=fabs(directY);
        }
        else
        {
            cframe.size.height-=fabs(directY);
        }
    }
    else  if(sp.direction==3)
    {
        if(directX<0)
        {
            cframe.size.height-=fabs(directX);
        }
        else
        {
            cframe.size.height+=fabs(directX);
        }
    }
    else
    {
        cframe.size.height+=directY;
    }
    cv.frame=cframe;
    
    //缩放图标 底部缩放图标view
    cv=self;
    cframe=cv.frame;
    if(sp.direction==1)
    {
        if(directX<=0)
        {
            cframe.origin.y+=fabs(directX);
        }
        else
        {
            cframe.origin.y-=fabs(directX);
        }
    }
    else if(sp.direction==2)
    {
        if(directY<=0)
        {
            cframe.origin.y+=fabs(directY);
        }
        else
        {
            cframe.origin.y-=fabs(directY);
        }
    }
    else if(sp.direction==3)
    {
        if(directX<=0)
        {
            cframe.origin.y-=fabs(directX);
        }
        else
        {
            cframe.origin.y+=fabs(directX);
        }
    }
    else
    {
        cframe.origin.y+=directY;
    }
    cv.frame=cframe;
    
    //右边缩放图标view
    if(sp.rightView!=nil)
    {
        cv=sp.rightView;
        cframe=cv.frame;
        if(sp.direction==1)
        {
            if(directX<0)
            {
                cframe.origin.y+=fabs(directX)/2;
            }
            else
            {
                cframe.origin.y-=fabs(directX)/2;
            }
        }
        else if(sp.direction==2)
        {
            if(directY<0)
            {
                cframe.origin.y+=fabs(directY)/2;
            }
            else
            {
                cframe.origin.y-=fabs(directY)/2;
            }
        }
        else if(sp.direction==3)
        {
            if(directX<0)
            {
                cframe.origin.y-=fabs(directX)/2;
            }
            else
            {
                cframe.origin.y+=fabs(directX)/2;
            }
        }
        else
        {
            cframe.origin.y+=directY/2;
        }
        cv.frame=cframe;
    }
    
    //刷新顶部坐标显示
    [sp refreshMsg];
}

@end
