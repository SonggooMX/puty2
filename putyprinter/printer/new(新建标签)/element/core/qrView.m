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

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    if(image==nil){
        UIImage *img=[self createZXingImage:kBarcodeFormatQRCode withContent:content];
        if(img==NULL) return;
        image=img;
    }
    [super initView:frame withImage:image withNString:content];
    [self showScaleView];
    [self refresh];
}

-(void) resetViewWH:(CGSize)size
{
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
