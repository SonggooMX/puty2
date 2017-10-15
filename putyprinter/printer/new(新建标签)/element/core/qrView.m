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
#import "ZXingObjC/ZXWriter.h"
#import "ZXingObjC/ZXImage.h"
#import "ZXingObjC/ZXEncodeHints.h"
#import "ZXingObjC/ZXMultiFormatWriter.h"


@implementation qrView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    self.elementType=1;
    self.errorLevel=1;
    
    UIImage *img=[self createZXingImage:kBarcodeFormatQRCode withContent:content withEncoding:NSUTF8StringEncoding withErrorLevel:ZXQRCodeErrorCorrectionLevel.errorCorrectionLevelM];
    [super initView:frame withImage:img withNString:content];
    [self showScaleView];
    [self resetViewWH:self.frame.size];
    [self refresh];
}

//重设置图片
-(void) resetContainerViewImage:(UIImage*)bitmap
{
    int formt=kBarcodeFormatQRCode;
    switch (self.codeType) {
        case 1:
            formt=kBarcodeFormatMaxiCode;
            break;
        case 2:
            formt=kBarcodeFormatPDF417;
            break;
        case 3:
            formt=kBarcodeFormatQRCode;
            break;
        case 4:
            formt=kBarcodeFormatQRCode;
            break;
        case 5:
            formt=kBarcodeFormatQRCode;
            break;
        case 6:
            formt=kBarcodeFormatDataMatrix;
            //不支持中文
            return;
        default:
            break;
    }
    
    ZXQRCodeErrorCorrectionLevel *level=ZXQRCodeErrorCorrectionLevel.errorCorrectionLevelL;
    switch (self.errorLevel) {
        case 1:
            level=ZXQRCodeErrorCorrectionLevel.errorCorrectionLevelM;
            break;
        case 2:
            level=ZXQRCodeErrorCorrectionLevel.errorCorrectionLevelQ;
            break;
        case 3:
            level=ZXQRCodeErrorCorrectionLevel.errorCorrectionLevelH;
            break;
        default:
            break;
    }
    
    int encode=NSUTF8StringEncoding;
    switch (self.encodeMode) {
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
    
    UIImage *img=[self createZXingImage:formt withContent:self.content withEncoding:encode withErrorLevel:level];
    [super resetContainerViewImage:img];
}

-(void) resetViewWH:(CGSize)size
{
    [super resetViewWH:size];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    self.containerView.frame=CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, size.width, size.height);
    
    self.sview.frame=CGRectMake(self.frame.size.width-13, self.frame.size.height-13, 20, 20);
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
        self.sview.hidden=NO;
    }
    else
    {
        self.sview.hidden=YES;
    }
}

@end
