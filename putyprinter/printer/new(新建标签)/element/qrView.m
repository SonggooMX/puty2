//
//  qrView.m
//  printer
//  二维码
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "qrView.h"
#import "scaleView.h"
#import "bottomRightScaleView.h"


@implementation qrView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image
{
    [super initView:frame withImage:image];
    
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
