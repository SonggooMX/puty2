//
//  insertArea.m
//  printer
//
//  Created by songgoo on 2017/7/15.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "insertArea.h"
#import "ZXingObjC/ZXWriter.h"
#import "ZXingObjC/ZXImage.h"
#import "ZXingObjC/ZXEncodeHints.h"
#import "ZXingObjC/ZXMultiFormatWriter.h"
#import "baseView.h"
#import "scaleView.h"
#import "qrView.h"
#import "b1dView.h"
#import "lbView.h"
#import "BaseEdictFormViewController.h"
@implementation insertArea

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//插入一维码
- (IBAction)btnInsertBarcode1D:(id)sender {
    
    UIImage *img=[self createZXingImage:kBarcodeFormatCode128];
    if(img==NULL) return;
    
    b1dView *v1=[[b1dView alloc] init];
    v1.parent=self.parent.drawAreaView;
    v1.parentController=self.parent;
    [v1 initView:CGRectMake(50, 50, 100, 25) withImage:img];
    [self.parent.drawAreaView addSubview:v1];
    
    BaseEdictFormViewController *vc = [[BaseEdictFormViewController alloc] initWithNibName:@"BaseEdictFormViewController" bundle:nil];
    vc.type = BaseEdictFormTypeBarCode;
    [self.parent.navigationController pushViewController:vc animated:YES];
}

//插入二维码
- (IBAction)btnInsertQR:(id)sender {
    UIImage *img=[self createZXingImage:kBarcodeFormatQRCode];
    if(img==NULL) return;
    
    qrView *v1=[[qrView alloc] init];
    v1.parent=self.parent.drawAreaView;
    v1.parentController=self.parent;
    [v1 initView:CGRectMake(100, 100, 100, 100) withImage:img];
    [self.parent.drawAreaView addSubview:v1];
    
    BaseEdictFormViewController *vc = [[BaseEdictFormViewController alloc] initWithNibName:@"BaseEdictFormViewController" bundle:nil];
    vc.type = BaseEdictFormTypeQRCode;
    [self.parent.navigationController pushViewController:vc animated:YES];
}

//创建图片
-(UIImage*) createZXingImage:(int)format
{
    NSError *error = nil;
    ZXEncodeHints *hints=[[ZXEncodeHints alloc] init];
    hints.margin=0;
    hints.encoding=NSUTF8StringEncoding;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:@"A string to encode"
                                  format:format
                                   width:200
                                  height:200
                                  hints:hints
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        return [[UIImage alloc] initWithCGImage:image];
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        //NSString *errorMessage = [error localizedDescription];
        return NULL;
    }
}

//插入文本
- (IBAction)btnInsertText:(id)sender {
    
    
    lbView *v1=[[lbView alloc] init];
    v1.parent=self.parent.drawAreaView;
    v1.parentController=self.parent;
    [v1 initView:CGRectMake(50, 50, 100, 100) withContent:@"3243243244324324324324234"];
    [self.parent.drawAreaView addSubview:v1];
    
    BaseEdictFormViewController *vc = [[BaseEdictFormViewController alloc] initWithNibName:@"BaseEdictFormViewController" bundle:nil];
    vc.type = BaseEdictFormTypeLable;
    [self.parent.navigationController pushViewController:vc animated:YES];
}


- (IBAction)btnInsertImage:(id)sender {
    
    //self.parent.drawAreaView.subviews.lastObject.transform=CGAffineTransformScale(self.parent.drawAreaView.subviews.lastObject.transform, 1.1, 1.1);
    //旋转
    baseView *bv=(baseView*)self.parent.drawAreaView.subviews.lastObject;
    [bv rotate];
    
    BaseEdictFormViewController *vc = [[BaseEdictFormViewController alloc] initWithNibName:@"BaseEdictFormViewController" bundle:nil];
    vc.type = BaseEdictFormTypeImage;
    [self.parent.navigationController pushViewController:vc animated:YES];
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"insertArea" owner:self options:nil];
        self.contentView=[views objectAtIndex:0];
        self.contentView.frame=frame;
        [self addSubview:self.contentView];
    }
    return self;
}





@end
