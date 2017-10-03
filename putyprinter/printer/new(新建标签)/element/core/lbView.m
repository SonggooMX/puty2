//
//  lbView.m
//  printer
//
//  Created by songgoo on 2017/7/26.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "lbView.h"
#import "lbScaleView.h"
@implementation lbView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage*)image withNString:(NSString *)content
{
    [self initView:frame withContent:content];
}

-(void) initView:(CGRect)frame withContent:(NSString*)content
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.frame=frame;
    UILabel *lb=[[UILabel alloc] init];
    //按字符换行
    lb.lineBreakMode=NSLineBreakByCharWrapping;
    lb.text=content;
    self.content=content;
    lb.numberOfLines=0;
    lb.lineBreakMode=NSLineBreakByClipping;
    CGRect rect=[lb textRectForBounds:CGRectMake(0, 0, 100, 1000) limitedToNumberOfLines:0];
    lb.frame=CGRectMake(0, 0, rect.size.width,rect.size.height);
    [self addSubview:lb];
    
    self.frame=CGRectMake(frame.origin.x, frame.origin.y, rect.size.width, rect.size.height);
    
    self.containerView=lb;
    
    //添加缩放图标
    [self showScaleView];
    
    [self refresh];
}

-(void) resetViewWH:(CGSize)size
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    self.containerView.frame=CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, size.width, size.height);
    
    self.lbScaleView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
}

-(void) showScaleView
{
    [super showScaleView];
    
    self.lbScaleView=[[lbScaleView alloc] init];
    self.lbScaleView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
    self.lbScaleView.hidden=YES;
    self.lbScaleView.pparent=self.parent;
    self.lbScaleView.parent=self;
    
    UIImageView *rightImage=[[UIImageView alloc] init];
    rightImage.image=[UIImage imageNamed:@"Left_and_right_expansion_button"];
    rightImage.frame=CGRectMake(0, 0, 20, 20);
    [self.lbScaleView addSubview:rightImage];
    [self addSubview:self.lbScaleView];
}

//刷新
-(void) refresh
{
    [super refresh];
    if(self.isslected==1&&self.isLock==0)
    {
        self.lbScaleView.hidden=NO;
    }
    else
    {
        self.lbScaleView.hidden=YES;
    }
}

@end
