//
//  qrScaleView.m
//  printer
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"
#import "bottomRightScaleView.h"

@implementation bottomRightScaleView

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
    baseView *bv=(baseView*)self.parent;
    [bv resetViewWH:bv.frame.size];
}

//元素的缩放 （二维码 右下角缩放大小）
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.pparent];
    
    //NSLog(@"sx:%f,sy:%f",self.beginpoint.x,self.beginpoint.y);
    //NSLog(@"x:%f,y:%f",currentLocation.x,currentLocation.y);
    
    float directX=currentLocation.x-self.beginpoint.x;
    float directY=directX;//currentLocation.y - self.beginpoint.y;
    
    //元素的顶层容器view
    baseView *bv=(baseView*)self.parent;
    
    directX=(directX);
    directY=(directY);
    
    self.beginpoint=currentLocation;
    
    CGRect frame=bv.frame;
    
    if(bv.direction==1)
    {
        if(directX<0)
        {
            frame.origin.x-=fabs(directX);
            frame.size.width+=fabs(directX);;
            frame.size.height+=fabs(directY);
        }
        else
        {
            frame.origin.x+=fabs(directX);
            frame.size.width-=fabs(directX);;
            frame.size.height-=fabs(directY);
        }
    }
    else if(bv.direction==2)
    {
        if(directX<0)
        {
            frame.origin.x-=fabs(directX);
            frame.origin.y-=fabs(directX);
            frame.size.width+=fabs(directX);;
            frame.size.height+=fabs(directY);
        }
        else
        {
            frame.origin.x+=fabs(directX);
            frame.origin.y+=fabs(directX);
            frame.size.width-=fabs(directX);;
            frame.size.height-=fabs(directY);
        }
    }
    else if(bv.direction==3)
    {
        if(directX<0)
        {
            frame.origin.y+=fabs(directX);
            frame.size.width-=fabs(directX);;
            frame.size.height-=fabs(directY);
        }
        else
        {
            frame.origin.y-=fabs(directX);
            frame.size.width+=fabs(directX);;
            frame.size.height+=fabs(directY);
        }
    }
    else
    {
        if(bv.elementType==2)
        {
            float scale=frame.size.width/frame.size.height;
            directY=directX/scale;
        }
        
        frame.size.width+=(directX);;
        frame.size.height+=(directY);
    }
    
    
    self.superview.frame=frame;
    
    //元素中存放二维码的view uiimageview
    UIView *cv=self.superview.subviews.firstObject;
    CGRect cframe=cv.frame;
    if(bv.direction==1)
    {
        if(directX<0)
        {
            cframe.size.width+=fabs(directX);;
            cframe.size.height+=fabs(directY);
        }
        else
        {
            cframe.size.width-=fabs(directX);;
            cframe.size.height-=fabs(directY);
        }
    }
    else if(bv.direction==2)
    {
        if(directX<0)
        {
            cframe.size.width+=fabs(directX);;
            cframe.size.height+=fabs(directY);
        }
        else
        {
            cframe.size.width-=fabs(directX);;
            cframe.size.height-=fabs(directY);
        }
    }
    else if(bv.direction==3)
    {
        if(directX<0)
        {
            cframe.size.width-=fabs(directX);;
            cframe.size.height-=fabs(directY);
        }
        else
        {
            cframe.size.width+=fabs(directX);;
            cframe.size.height+=fabs(directY);
        }
    }
    else
    {
        cframe.size.width+=directX;
        cframe.size.height+=directY;
    }
    cv.frame=cframe;
    
    //缩放图标 元素中的缩放图标view uiimageview
    cv=self.superview.subviews.lastObject;
    cframe=cv.frame;
    
    if(bv.direction==1||bv.direction==2)
    {
        cframe.origin.x-=directX;
        cframe.origin.y-=directY;
    }
    else
    {
        cframe.origin.x+=directX;
        cframe.origin.y+=directY;
    }
    cv.frame=cframe;
    
    [bv refreshMsg];
}

@end
