//
//  b1dView.m
//  printer
//  一维码
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "b1dView.h"
#import "BottomScaleView.h"

@implementation b1dView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    if(image==nil){
        UIImage *img=[self createZXingImage:kBarcodeFormatCode128 withContent:content];
        if(img==NULL) return;
        image=img;
    }
    [super initView:frame withImage:image withNString:content];

    [self showScaleView];
    [self refresh];
}

//重新设置宽高
-(void) resetViewWH:(CGSize)size
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    if(self.direction==0||self.direction==2){
        
        
        float top=self.frame.size.height-self.b1dlb.frame.size.height;
        float left=(self.frame.size.width-self.b1dlb.frame.size.width)/2;
        
    self.containerView.frame=CGRectMake(self.containerView.frame.origin.y, self.containerView.frame.origin.x, size.width, size.height-self.b1dlb.frame.size.height);
        
        self.b1dlb.frame=CGRectMake(left, top, self.b1dlb.frame.size.width,self.b1dlb.frame.size.height);
        
        
        self.rightView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
        
        self.bottomView.frame=CGRectMake((self.frame.size.width-20)/2, self.frame.size.height-10, 20, 20);
    }
    else
    {
        float top=self.frame.size.width-self.b1dlb.frame.size.height;
        float left=(self.frame.size.height-self.b1dlb.frame.size.width)/2;
        
        self.containerView.frame=CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, size.height, size.width-self.b1dlb.frame.size.height);
        
        self.b1dlb.frame=CGRectMake(left, top, self.b1dlb.frame.size.width,self.b1dlb.frame.size.height);
        
        
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

-(void) rotate:(int)angle
{
    [super rotate:angle];
    [self refresh];
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
