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
// Only ov(nonatomic) (nonatomic) erride drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage*)image withNString:(NSString *)content
{
    [self initView:frame withContent:content];
}

//获取行间距
-(CGRect) getLineSpace:(UILabel *)lb withW:(float)width
{
    NSString *content=lb.text;
    lb.text=@"文本";
    CGRect rect=[lb textRectForBounds:CGRectMake(0, 0, width, 10000) limitedToNumberOfLines:self.autoWarp==1?0:1];
    lb.text=content;
    return rect;
}

//获取文本所占区域
-(CGRect) getContentRect:(UILabel *)lb withW:(float)width
{
    CGRect rect=[lb textRectForBounds:CGRectMake(0, 0, width, 10000) limitedToNumberOfLines:self.autoWarp==1?0:1];
    return rect;
}

-(void) initView:(CGRect)frame withContent:(NSString*)content
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.content=content;
    
    self.frame=frame;
    
    UILabel *lb=[self createLabel:0];
    [self addSubview:lb];
    CGRect rect=lb.frame;
    
    /*[[UILabel alloc] init];
    float fontsize=((NSString*)[self.fontSizeContents objectAtIndex:self.fontSizeIndex]).floatValue*8;
    UIFont *font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontsize];
    lb.font=font;
    lb.textAlignment=self.alignMode;
    lb.text=content;
    self.content=content;
    lb.numberOfLines=self.autoWarp==1?0:1;
    lb.lineBreakMode=NSLineBreakByCharWrapping;
    CGRect rect=[lb textRectForBounds:CGRectMake(0, 0, frame.size.width, 1000) limitedToNumberOfLines:self.autoWarp==1?0:1];
    lb.frame=CGRectMake(0, 0, rect.size.width,rect.size.height);
    [self addSubview:lb];
    */
    
    self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
    
    self.containerView=lb;
    
    //添加缩放图标
    [self showScaleView];
    
    [self refresh];
}

-(UILabel *) createLabel:(float)height
{
    UILabel *lb=[[UILabel alloc] init];
    lb.text=self.content;
    if(self.rowSpaceMode==3)
    {
        self.rowSpaceHeight=height;
    }
    else if(self.rowSpaceMode==1)
    {
        self.rowSpaceHeight=0.2f*[self getLineSpace:lb withW:100].size.height;
    }
    else if(self.rowSpaceMode==2)
    {
        self.rowSpaceHeight=0.5f*[self getLineSpace:lb withW:100].size.height;
    }
    else
    {
        self.rowSpaceHeight=0.0f;
    }
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = self.rowSpaceHeight; //设置行间距
    NSDictionary *dic =@{NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@(self.charSpaceWidth)};//设置字间距
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:lb.text attributes:dic];
    lb.attributedText=attributeStr;
    float fontsize=((NSString*)[self.fontSizeContents objectAtIndex:self.fontSizeIndex]).floatValue*8;
    UIFont *font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontsize];
    lb.font=font;
    lb.textAlignment=self.alignMode;
    //float w=(self.direction==0||self.direction==2)?self.frame.size.width:self.frame.size.height;
    CGRect rect=[lb textRectForBounds:CGRectMake(0, 0, self.frame.size.width, 1000) limitedToNumberOfLines:self.autoWarp==1?0:1];
    lb.frame=rect;
    return lb;
}

//自动换行
-(void) setWarp:(int)autoWarp
{
    self.autoWarp=autoWarp;
    ((UILabel*)self.containerView).numberOfLines=self.autoWarp==1?0:1;
}

//设置行间距 1 自定义  0  1倍 1.5倍 1.2倍
-(void) setLineSpace:(float)height withMode:(int)mode
{
    
    
    //[self resetViewWH:CGSizeMake(self.frame.size.width, rect.size.height)];
}

-(void) resetViewWH:(CGSize)size
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    
    if(self.direction==0||self.direction==2){
        self.containerView.frame=CGRectMake(self.containerView.frame.origin.y, self.containerView.frame.origin.x, size.width, size.height);
        
         self.lbScaleView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
    }
    else
    {
        self.containerView.frame=CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, size.height, size.width);
        
        self.lbScaleView.frame=CGRectMake(self.frame.size.height-10, (self.frame.size.width-20)/2, 20, 20);
    }
    
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
