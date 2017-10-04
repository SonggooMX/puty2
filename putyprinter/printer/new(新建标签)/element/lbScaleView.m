//
//  lbScaleView.m
//  printer
//
//  Created by songgoo on 2017/7/26.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "lbScaleView.h"
#import "baseView.h"
#import "lbView.h"

@implementation lbScaleView

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
}

//文本缩放
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.pparent];
    
    //NSLog(@"sx:%f,sy:%f",self.beginpoint.x,self.beginpoint.y);
    //NSLog(@"x:%f,y:%f",currentLocation.x,currentLocation.y);
    
    float directX=currentLocation.x-self.beginpoint.x;
    float directY=currentLocation.y-self.beginpoint.y;
    
    CGRect frame=self.superview.frame;
    
    //文本顶部容器view
    lbView *sp=(lbView*)self.parent;
    
    UILabel *lb=(UILabel*)self.superview.subviews.firstObject;
    
    CGRect realSize;
    if(sp.direction==1||sp.direction==3)
    {
        //获取文本的实际大小尺寸 固定文本宽度 获取文本的实际高度
        realSize=[sp getContentRect:lb withW:frame.size.height+directY];
    }
    else
    {
        realSize=[sp getContentRect:lb withW:frame.size.width+directX];
    }
    
    //NSLog(@"rx:%.2f,ry:%.2f,rw:%.2f,rh:%.2f",realSize.origin.x,realSize.origin.y,realSize.size.width,realSize.size.height);
    
    self.beginpoint=currentLocation;
    float dx=0;
    
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
        
        dx=frame.size.width-realSize.size.height;
        //变小 x 加大
        frame.origin.x+=dx;
        frame.size.width=realSize.size.height;
        
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
        dx=frame.size.height-realSize.size.height;
        frame.size.height=realSize.size.height;
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
        dx=frame.size.width-realSize.size.height;
        frame.size.width=realSize.size.height;
        //NSLog(@"fx:%.2f,fy:%.2f,fw:%.2f,fh:%.2f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    }
    else
    {
        dx=frame.size.height-realSize.size.height;
        frame.size.width+=directX;
        frame.size.height=realSize.size.height;
    }
    
    self.superview.frame=frame;
    
    //文本存放uilabel view
    UIView *cv=(UIView*)self.superview.subviews.firstObject;
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
        cframe.size.height=realSize.size.height;
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
        cframe.size.height=realSize.size.height;
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
        cframe.size.height=realSize.size.height;
    }
    else
    {
        cframe.size.width+=directX;
        cframe.size.height=realSize.size.height;
    }
    cv.frame=cframe;
    
    //缩放图标 view
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
        
        if(dx>0)
        {
            cframe.origin.y-=fabs(dx)/2;
        }
        else
        {
            cframe.origin.y+=fabs(dx)/2;
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
        
        if(dx>0)
        {
            cframe.origin.y-=fabs(dx)/2;
        }
        else
        {
            cframe.origin.y+=fabs(dx)/2;
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
        
        if(dx>0)
        {
            cframe.origin.y-=fabs(dx)/2;
        }
        else
        {
            cframe.origin.y+=fabs(dx)/2;
        }
    }
    else
    {
        if(dx>0)
        {
            cframe.origin.y-=fabs(dx)/2;
        }
        else
        {
            cframe.origin.y+=fabs(dx)/2;
        }
        cframe.origin.x+=directX;
    }
    cv.frame=cframe;
}


@end
