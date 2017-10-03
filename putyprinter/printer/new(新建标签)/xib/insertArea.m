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
#import "rectView.h"
#import "lineView.h"
#import "BaseEdictFormViewController.h"
#import "LogoManagerController.h"
#import "ImageHelper.h"
#import "imgView.h"

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
    
    UIImage *img=[self createZXingImage:kBarcodeFormatCode128 withContent:@"12345678"];
    if(img==NULL) return;
    
    b1dView *v1=[[b1dView alloc] init];
    v1.parent=self.parent.drawAreaView;
    v1.elementType=0;
    v1.parentController=self.parent;
    [v1 initView:CGRectMake(50, 50, 100, 50) withImage:img withNString:@"12345678"];
    [self.parent.drawAreaView addSubview:v1];

}

//插入二维码
- (IBAction)btnInsertQR:(id)sender {
    UIImage *img=[self createZXingImage:kBarcodeFormatQRCode withContent:@"二维码"];
    if(img==NULL) return;
    
    qrView *v1=[[qrView alloc] init];
    v1.parent=self.parent.drawAreaView;
    v1.elementType=1;
    v1.parentController=self.parent;
    [v1 initView:CGRectMake(100, 100, 100, 100) withImage:img withNString:@"二维码"];
    [self.parent.drawAreaView addSubview:v1];
    
}



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

//插入文本
- (IBAction)btnInsertText:(id)sender {
    
    
    lbView *v1=[[lbView alloc] init];
    v1.parent=self.parent.drawAreaView;
    v1.elementType=8;
    v1.parentController=self.parent;
    [v1 initView:CGRectMake(50, 50, 100, 100) withContent:@"文本"];
    [self.parent.drawAreaView addSubview:v1];
}

//插入矩形 生成一个矩形图标 5
- (IBAction)btnInsertRect:(id)sender {
    rectView *v1=[[rectView alloc] init];
    v1.rectType=1;
    v1.elementType=5;
    [v1 initView:CGRectMake(50, 50, 100, 100) withImage:NULL withNString:@""];
    v1.parent=self.parent.drawAreaView;
    v1.parentController=self.parent;
    [self.parent.drawAreaView addSubview:v1];
}

//插入LOGO 6
- (IBAction)btnInsertLogo:(id)sender {
    //logo
    LogoManagerController *vc = [LogoManagerController new];
    
    [self.parent.navigationController pushViewController:vc animated:YES];
}

//插入线条 4
- (IBAction)btnInsertLine:(id)sender {
    lineView *v1=[[lineView alloc] init];
    v1.lineType=1;
    v1.elementType=4;
    [v1 initView:CGRectMake(50, 50, 100, 20) withImage:NULL withNString:@""];
    v1.parent=self.parent.drawAreaView;
    v1.parentController=self.parent;
    [self.parent.drawAreaView addSubview:v1];
}

//插入表格 3
- (IBAction)btnInsertTabel:(id)sender {
    
}


//插入图片
- (IBAction)btnInsertImage:(id)sender {
    
    //self.parent.drawAreaView.subviews.lastObject.transform=CGAffineTransformScale(self.parent.drawAreaView.subviews.lastObject.transform, 1.1, 1.1);
    //旋转
    //baseView *bv=(baseView*)self.parent.drawAreaView.subviews.lastObject;
    //[bv rotate];
    
    //打开图片选择界面
    // 判断当前的sourceType是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        // 实例化UIImagePickerController控制器
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        // 设置资源来源（相册、相机、图库之一）
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        imagePickerVC.mediaTypes = @[(NSString *)kUTTypeImage];
        
        // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
        imagePickerVC.delegate = self;
        // 是否允许编辑（YES：图片选择完成进入编辑模式）
        imagePickerVC.allowsEditing = YES;
        // model出控制器
        [self.parent presentViewController:imagePickerVC animated:YES completion:nil];
        
    }
    
    /*
    BaseEdictFormViewController *vc = [[BaseEdictFormViewController alloc] initWithNibName:@"BaseEdictFormViewController" bundle:nil];
    vc.type = BaseEdictFormTypeImage;
    [self.parent.navigationController pushViewController:vc animated:YES];
     */
}

// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // dismiss UIImagePickerController
    [self.parent dismissViewControllerAnimated:YES completion:nil];
    // 选择的图片信息存储于info字典中
    //NSLog(@"%@", info);
    //创建图片元素
    // 获取点击的图片
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //压缩到标签尺寸的一半大小
    float w=self.parent.drawAreaView.frame.size.width/2;
    float h=self.parent.drawAreaView.frame.size.height/2;
    
    float scaleX=w/img.size.width;
    float scaleY=h/img.size.height;
    
    float scale=scaleX>scaleY?scaleY:scaleX;
    
    float lw=img.size.width*scale;
    float lh=img.size.height*scale;
    
    float x=(w-lw)/2;
    float y=(h-lh)/2;
    
    imgView *v1=[[imgView alloc] init];
    v1.elementType=2;
    v1.imgPath=@"";//[info objectForKey:UIImagePickerControllerMediaURL];
    v1.parent=self.parent.drawAreaView;
    v1.parentController=self.parent;
    [v1 initView:CGRectMake(x, y, lw, lh) withImage:img withNString:@""];
    [self.parent.drawAreaView addSubview:v1];
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self.parent dismissViewControllerAnimated:YES completion:nil];
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
