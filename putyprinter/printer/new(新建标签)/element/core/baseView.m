//
//  barcode1d.m
//  printer
//
//  Created by songgoo on 2017/7/22.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"
#import "NewLabelViewController.h"
#import "ZXingObjC/ZXWriter.h"
#import "ZXingObjC/ZXImage.h"
#import "ZXingObjC/ZXEncodeHints.h"
#import "ZXingObjC/ZXMultiFormatWriter.h"
#import "ImageHelper.h"

@implementation baseView

//字体大小名称
-(NSArray *) fontSizeTitles{
    NSArray *arr=@[@"大特号",@"特号",@"初号",@"小初号",@"大一号",@"一号",@"二号",@"小二号",
                         @"三号",@"四号",@"小四号",@"五号",@"小五号",@"六号",@"小六号",@"七号",@"八号"];
    return arr;
}

//字体大小
-(NSArray<NSString*> *) fontSizeContents{
    NSArray<NSString*> *arr=@[@"22.142",@"18.979",@"14.761",@"12.653",@"11.071",
                   @"9.841",@"7.381",@"6.326",@"5.623",@"4.920",@"4.218",
                   @"3.690",@"3.163",@"2.812",@"2.416",@"1.845",@"1.581"];
    return arr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//创建图片
-(UIImage*) createZXingImage:(int)format withContent:(NSString*)data
{
    NSError *error = nil;
    ZXEncodeHints *hints=[[ZXEncodeHints alloc] init];
    hints.margin=0;
    hints.encoding=NSUTF8StringEncoding;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:data
                                  format:format
                                   width:200
                                  height:200
                                   hints:hints
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        UIImage *bmp = [[UIImage alloc] initWithCGImage:image];
        ImageHelper *helper=[ImageHelper new];
        bmp=[helper imageBlackToTransparent:bmp withRed:0 andGreen:0 andBlue:0];
        return bmp;
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        //NSString *errorMessage = [error localizedDescription];
        return NULL;
    }
}

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    [self.containerView removeFromSuperview];
    [self.b1dlb removeFromSuperview];
    
    self.bmp=image;
    self.frame=frame;
    self.content=content;
    
    UIImageView *view=[[UIImageView alloc] initWithImage:image];
    [self addSubview:view];
    
    if(self.elementType==0)
    {
        self.b1dlb=[[UILabel alloc] init];
        float fontsize=((NSString*)[self.fontSizeContents objectAtIndex:self.fontSizeIndex]).floatValue*8;
        UIFont *font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontsize];
        self.b1dlb.font=font;
        self.b1dlb.text=content;
        self.content=content;
        self.b1dlb.numberOfLines=1;
        self.b1dlb.lineBreakMode=NSLineBreakByCharWrapping;
        CGRect rect=[self.b1dlb textRectForBounds:CGRectMake(0, 0, frame.size.width, 1000) limitedToNumberOfLines:1];
        
        float top=frame.size.height-rect.size.height;
        float left=(frame.size.width-rect.size.width)/2;
        
        self.b1dlb.frame=CGRectMake(left, top, rect.size.width,rect.size.height);
        
        [self addSubview:self.b1dlb];
        
        view.frame=CGRectMake(0, 0, frame.size.width, frame.size.height-self.b1dlb.frame.size.height);
    }
    else
    {
        view.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    
    self.containerView=view;
    
    [self showScaleView];
    
    int angle=self.direction;
    
    [self rotate:angle];
    
    [self refresh];
}

//重新设置图片
-(void) resetContainerViewImage:(UIImage*)bitmap
{
    UIImageView *uv=(UIImageView *) self.containerView;
    uv.image=bitmap;
}

-(void) resetViewWH:(CGSize)size
{
    
}

-(void) showScaleView
{
    [self.rightView removeFromSuperview];
    [self.lbScaleView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    [self.sview removeFromSuperview];
}

-(void) rotate:(int)angle
{
    int count=angle-self.direction;
    self.direction=angle;
    
    UIView *first=self;
    first.transform=CGAffineTransformRotate(first.transform, M_PI_2*count);
    
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

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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

    int directX=currentLocation.x-self.beginpoint.x;
    int directY=currentLocation.y - self.beginpoint.y;
    
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
    
    float x=[NSString stringWithFormat:@"%.1f",self.frame.origin.x/scale/8].floatValue;
    float y=[NSString stringWithFormat:@"%.1f",self.frame.origin.y/scale/8].floatValue;
    float w=[NSString stringWithFormat:@"%.1f",self.frame.size.width/scale/8].floatValue;
    float h=[NSString stringWithFormat:@"%.1f",self.frame.size.height/scale/8].floatValue;
    
    NSString *msg=[NSString stringWithFormat:@"X:%.2fmm  Y:%.2fmm  宽:%.2fmm  高:%.2fmm",x,y,w,h];
    [nlc updateTip:msg];
}

-(float) getXMM
{
    float x=[NSString stringWithFormat:@"%.1f0", self.frame.origin.x/self.scale/8].floatValue;
    return x;
}

-(float) getYMM
{
    float y=[NSString stringWithFormat:@"%.1f0",self.frame.origin.y/self.scale/8].floatValue;
    return y;
}

-(float) getWidthMM
{
    float w=[NSString stringWithFormat:@"%.1f0",self.frame.size.width/self.scale/8].floatValue;
    return w;
}
-(float) getHeightMM
{
    float h=[NSString stringWithFormat:@"%.1f0",self.frame.size.height/self.scale/8].floatValue;
    return h;
}

@end
