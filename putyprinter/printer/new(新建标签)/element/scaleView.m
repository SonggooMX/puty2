//
//  scaleView.m
//  printer
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "scaleView.h"

@implementation scaleView

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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.pparent];
    
    //NSLog(@"sx:%f,sy:%f",self.beginpoint.x,self.beginpoint.y);
    //NSLog(@"x:%f,y:%f",currentLocation.x,currentLocation.y);
    
    int directX=currentLocation.x-self.beginpoint.x;
    //int directY=currentLocation.y - self.beginpoint.y;
    
    //NSLog(@"dx:%d,dy:%d",directX,directY);
    
    self.beginpoint=currentLocation;
    
    CGRect frame=self.superview.frame;
    float w=frame.size.width+directX;
    //float h=frame.size.height+directY;
    
    float sacex=w/frame.size.width;
    float sacey=sacex;//w/frame.size.height;
    
    NSLog(@"x:%f,y:%f",sacex,sacey);
    
    self.superview.transform=CGAffineTransformScale(self.superview.transform, sacex,sacey);
}


@end
