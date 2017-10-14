//
//  Util.m
//  printer
//
//  Created by songgoo on 2017/10/10.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "Util.h"

@implementation Util

#pragma mark - 获取颜色值
-(NSArray *) getImageLeftBlackPoint:(UIImage*)bitmap
{
    uint32_t *pixelData=[self getPixData:bitmap];
    int useRowWith=bitmap.size.width;
    
    int left = 0,top=0;
    
    for(int h=0;h<bitmap.size.height;h++)
    {
        int row=h;
        for (int w = 0; w < useRowWith; w++) {
            //得到像素值 ARGB
            int seq=(row*(int)bitmap.size.width)+w;
            int pixel = pixelData[seq];
            
            int red = ((pixel & 0x00FF0000) >> 16);
            int green = ((pixel & 0x0000FF00) >> 8);
            int blue = (pixel & 0x000000FF);
            
            //取得灰度值
            int gray =(int) (red * 0.3 + green * 0.59 + blue * 0.11);
            if(gray>0)
            {
                left=w;
                top=row;
                break;
            }
        }
    }
    
    NSArray *result=@[[NSString stringWithFormat:@"%d",left],[NSString stringWithFormat:@"%d",top]];
    return result;
}

#pragma mark - 获取图片的所有像素值
-(uint32_t*) getPixData:(UIImage*)bitmap
{
    int imageWidth=bitmap.size.width;
    int imageHeight=bitmap.size.height;
    
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), bitmap.CGImage);
    
    uint32_t *pixelData=rgbImageBuf;
    return pixelData;
}

//缩放图片
-(UIImage*) PostScale:(UIImage*)image withW:(float)pw withH:(float)ph withL:(int)left withT:(int)top
{
    //绘图的context
    UIGraphicsBeginImageContext(CGSizeMake(pw, ph));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true); //抗锯齿设置
    
    //绘制图片
    [image drawInRect:CGRectMake(left, top, pw, ph)];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

//缩放图片
-(UIImage*) PostScale:(UIImage*)image withW:(float)pw withH:(float)ph
{
    //绘图的context
    UIGraphicsBeginImageContext(CGSizeMake(pw, ph));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true); //抗锯齿设置
    
    //绘制图片
    [image drawInRect:CGRectMake(0, 0, pw, ph)];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

//图片旋转
- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
