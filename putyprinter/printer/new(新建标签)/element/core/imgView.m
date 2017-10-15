//
//  qrView.m
//  printer
//  二维码
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "imgView.h"
#import "scaleView.h"
#import "bottomRightScaleView.h"


@implementation imgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    self.sourceImage=image;
    [super initView:frame withImage:image withNString:content];
    [self resetViewWH:frame.size];
    //右小角放一个缩放图标
    [self showScaleView];
}

-(void) resetViewWH:(CGSize)size
{
    [super resetViewWH:size];
    
    //图片缩放
    self.rightView.hidden=self.isScale?NO:YES;
    
    //黑白显示
    if(self.isBlack)
    {
        UIImage *bmp=[self drawImage:self.grayValue*255 withImage:self.sourceImage];
        ((UIImageView*)self.containerView).image=bmp;
    }
    else
    {
        ((UIImageView*)self.containerView).image=self.sourceImage;
    }
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    if(self.direction==0||self.direction==2){
        self.containerView.frame=CGRectMake(self.containerView.frame.origin.y, self.containerView.frame.origin.x, size.width, size.height);
        
        self.sview.frame=CGRectMake(self.frame.size.width-13, self.frame.size.height-13, 20, 20);
    }
    else
    {
        self.containerView.frame=CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, size.height, size.width);
        
        self.sview.frame=CGRectMake(self.frame.size.height-13, self.frame.size.width-13, 20, 20);
    }
    
    [self refresh];
}

- (UIImage*)drawImage:(double)filterValue withImage:(UIImage*)image
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        //      ABGR
        uint8_t* ptr = (uint8_t*)pCurPtr;
        int B = ptr[1];
        int G = ptr[2];
        int R = ptr[3];
        double Gray = R*0.3+G*0.59+B*0.11;
        if (Gray > filterValue || (Gray == filterValue && filterValue == 0)) {
            ptr[0] = 0;
        }else{
            ptr[0] = 0xff;
        }
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight,NULL);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

-(void) showScaleView
{
    [super showScaleView];
    
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

-(void) rotate:(int)angle
{
    [super rotate:angle];
    
    
}

//刷新
-(void) refresh
{
    [super refresh];
    if(self.isslected==1&&self.isLock==0)
    {
        if(self.isScale)
        {
            self.sview.hidden=NO;
        }
        else
        {
            self.sview.hidden=YES;
        }
    }
    else
    {
        self.sview.hidden=YES;
    }
}

@end
