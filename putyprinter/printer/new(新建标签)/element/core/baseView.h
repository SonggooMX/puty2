//
//  barcode1d.h
//  printer
//
//  Created by songgoo on 2017/7/22.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftScaleView.h"
#import "BottomScaleView.h"
#import "bottomRightScaleView.h"
#import "lbScaleView.h"
#import "NewLabelViewController.h"
#import "ZXingObjC/ZXWriter.h"
#import "ZXingObjC/ZXImage.h"
#import "ZXingObjC/ZXEncodeHints.h"
#import "ZXingObjC/ZXMultiFormatWriter.h"

@interface baseView : UIView

@property UILabel *b1dlb;
@property UIImage *bmp;
@property CGPoint beginpoint;
@property UIView *parent;
@property NewLabelViewController *parentController;

@property bottomRightScaleView *sview;
@property leftScaleView *rightView;
@property BottomScaleView *bottomView;
@property lbScaleView *lbScaleView;

@property NSString *content;

//元素类型
@property int elementType;

//容器
@property UIView *containerView;

//旋转角度 0 90 180 270
@property int direction;
@property int isslected;

//锁定
@property int isLock;
//缩放
@property float scale;

//参与打印
@property int isPrint;

//当前字体名称
@property NSString *fontName;
//字体大小
@property int fontSizeIndex;
//粗体
@property int fontBlod;
//斜体
@property int fontItalic;
//下划线
@property int fontUnderline;
//删除线
@property int fontDeleteline;
//对齐模式
@property int alignMode;


-(void) resetContainerViewImage:(UIImage*)bitmap;
-(UIImage *)getImageFromView:(UIView *)view;

//文字
-(NSArray *) fontSizeTitles;
-(NSArray *) fontSizeContents;

-(void) initView:(CGRect)frame withImage:(UIImage*)image withNString:(NSString*)content;

-(void) refreshMsg;

//刷新
-(void) refresh;
-(void) rotate:(int)angle;
-(void) showScaleView;

-(float) getWidthMM;
-(float) getHeightMM;
-(float) getXMM;
-(float) getYMM;

-(void) resetViewWH:(CGSize)size;

-(UIImage*) createZXingImage:(int)format withContent:(NSString*)data
                withEncoding:(NSInteger)encode withErrorLevel:(ZXQRCodeErrorCorrectionLevel*)errorCorrectionLevelL;

@end
