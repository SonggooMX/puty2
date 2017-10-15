//
//  b1dScaleView.m
//  printer
//  一维码缩放按钮
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"
#import "leftScaleView.h"

@implementation leftScaleView

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

//一维码右边缩放图标
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.pparent];
    
    //NSLog(@"sx:%f,sy:%f",self.beginpoint.x,self.beginpoint.y);
    //NSLog(@"x:%f,y:%f",currentLocation.x,currentLocation.y);
    
    float directX=currentLocation.x-self.beginpoint.x;
    float directY=currentLocation.y-self.beginpoint.y;
    
    //元素的顶层容器View
    baseView *sp=(baseView*)self.parent;

    //NSLog(@"dx:%d,dy:%d",directX,directY);
    
    self.beginpoint=currentLocation;
    
    CGRect frame=self.superview.frame;
    
    if(sp.direction==1)
    {
        if(directY<0)
        {
            frame.size.height-=fabs(directY);
        }
        else
        {
            frame.size.height+=fabs(directY);
        }
    }
    else if(sp.direction==2)
    {
        if(directX<0)
        {
            frame.origin.x-=fabs(directX);
            frame.size.width+=fabs(directX);
        }
        else
        {
            frame.origin.x+=fabs(directX);
            frame.size.width-=fabs(directX);;
        }
    }
    else if(sp.direction==3)
    {
        if(directY<0)
        {
            frame.origin.y-=fabs(directY);
            frame.size.height+=fabs(directY);
        }
        else
        {
            frame.origin.y+=fabs(directY);
            frame.size.height-=fabs(directY);;
        }
    }
    else
    {
        frame.size.width+=directX;
    }
    
    self.superview.frame=frame;
    
    //一维码图片view
    UIView *cv=self.superview.subviews.firstObject;
    CGRect cframe=cv.frame;
    if(sp.direction==1)
    {
        if(directY<0)
        {
            cframe.size.width-=fabs(directY);;
        }
        else
        {
            cframe.size.width+=fabs(directY);;
        }
    }
    else if(sp.direction==2)
    {
        if(directX<0)
        {
            cframe.size.width+=fabs(directX);
        }
        else
        {
            cframe.size.width-=fabs(directX);
        }
    }
    else if(sp.direction==3)
    {
        if(directY<0)
        {
            cframe.size.width+=fabs(directY);
        }
        else
        {
            cframe.size.width-=fabs(directY);
        }
    }
    else
    {
        cframe.size.width+=directX;
    }
    cv.frame=cframe;
    
    //缩放图标 右边缩放图标view
    cv=self;
    cframe=cv.frame;
    if(sp.direction==1)
    {
        if(directY<0)
        {
            cframe.origin.x-=fabs(directY);
        }
        else
        {
            cframe.origin.x+=fabs(directY);
        }
    }
    else if(sp.direction==2)
    {
        if(directX<0)
        {
            cframe.origin.x+=fabs(directX);
        }
        else
        {
            cframe.origin.x-=fabs(directX);
        }
    }
    else if(sp.direction==3)
    {
        if(directY<0)
        {
            cframe.origin.x+=fabs(directY);
        }
        else
        {
            cframe.origin.x-=fabs(directY);
        }
    }
    else
    {
        cframe.origin.x+=directX;
    }
    cv.frame=cframe;
    
    //底部缩放图标view
    if(sp.bottomView!=nil)
    {
        cv=sp.bottomView;
        cframe=cv.frame;
        if(sp.direction==1)
        {
            if(directY<0)
            {
                cframe.origin.x-=fabs(directY)/2;
            }
            else
            {
                cframe.origin.x+=fabs(directY)/2;
            }
        }
        else if(sp.direction==2)
        {
            if(directX<0)
            {
                cframe.origin.x+=fabs(directX)/2;
            }
            else
            {
                cframe.origin.x-=fabs(directX)/2;
            }
        }
        else if(sp.direction==3)
        {
            if(directY<0)
            {
                cframe.origin.x+=fabs(directY)/2;
            }
            else
            {
                cframe.origin.x-=fabs(directY)/2;
            }
        }
        else
        {
            cframe.origin.x+=directX/2;
        }
        cv.frame=cframe;
    }
    
    [sp refreshMsg];
}


@end
