//
//  b1dView.m
//  printer
//  一维码
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "b1dView.h"
#import "BottomScaleView.h"
#import "ZXingObjC/ZXWriter.h"
#import "ZXingObjC/ZXImage.h"
#import "ZXingObjC/ZXEncodeHints.h"
#import "ZXingObjC/ZXMultiFormatWriter.h"

@implementation b1dView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initView:(CGRect)frame withImage:(UIImage *)image withNString:(NSString*)content
{
    self.elementType=0;
    self.fontSizeIndex=14;
    self.showTextMode=2;//文字显示条码下发
    self.alignMode=1;
    
    UIImage *img=[self createZXingImage:kBarcodeFormatCode128 withContent:content withEncoding:NSUTF8StringEncoding withErrorLevel:nil];
    
    /*
    Util *utl=[Util new];
    NSArray *result=[utl getImageLeftBlackPoint:img];
    int left=((NSString*)[result objectAtIndex:0]).intValue;
    //int top=((NSString*)[result objectAtIndex:1]).intValue;
    //重新切图
    float w=img.size.width-2*left;
    float h=img.size.height;
    img=[utl PostScale:img withW:w withH:h withL:-left withT:0];
    img=[utl PostScale:img withW:frame.size.width withH:frame.size.height];
     */
    
    [super initView:frame withImage:img withNString:content];

    [self showScaleView];
    [self refresh];
}

//重设文本显示位置
-(void) resetTextPlace
{
    
}

//重设置图片
-(void) resetContainerViewImage:(UIImage*)bitmap
{
    int formt=kBarcodeFormatCode128;
    switch (self.encodeMode) {
        case 1:
            formt=kBarcodeFormatITF;
            break;
        case 2:
            formt=kBarcodeFormatCode39;
            break;
        case 3:
            formt=kBarcodeFormatCode128;
            break;
        case 4:
            formt=kBarcodeFormatCodabar;
            break;
        case 5:
            //formt=kBarcodeFormatEan8;
            //数据长度必须为8位
            break;
        case 6:
            //formt=kBarcodeFormatEan13;
            //数据长度必须为13
            break;
        case 7:
            //formt=kBarcodeFormatUPCA;
            //数据长度必须为11-12
            break;
        case 8:
            formt=kBarcodeFormatCode93;
            break;
        case 9:
            formt=kBarcodeFormatCode128;
            break;
        default:
            break;
    }
     UIImage *img=[self createZXingImage:formt withContent:self.content withEncoding:NSUTF8StringEncoding withErrorLevel:nil];
    [super resetContainerViewImage:img];
}

//重新设置宽高
-(void) resetViewWH:(CGSize)size
{
    [super resetViewWH:size];
    
    self.b1dlb.hidden=false;
    self.b1dlb.textAlignment=self.alignMode;
    int len=(int)self.b1dlb.text.length;
    
    float fontsize=((NSString*)[self.fontSizeContents objectAtIndex:self.fontSizeIndex]).floatValue*8;
    
    if(self.fontBlod==1)
    {
        self.b1dlb.font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontsize];
    }
    else
    {
        self.b1dlb.font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontsize];
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.b1dlb.text];
    //字体 uilabel 富文本
    //[attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0f] range:NSMakeRange(4, 3)];
    //间距
    //[attrStr addAttribute:NSKernAttributeNamevalue:@10 range:NSMakeRange(4, 3)];
    //斜体 // 正值向右倾斜 负值向左倾斜
    if(self.fontItalic==1)
    {
        [attrStr addAttribute:NSObliquenessAttributeName value:@(0.5f) range:NSMakeRange(0, len)];
    }
    //// 正值横向拉伸 负值横向压缩
    //[attrStr addAttribute:NSExpansionAttributeName value:@(0.5f) range:NSMakeRange(4, 3)];
    //下划线
    if(self.fontUnderline==1)
    {
        [attrStr addAttribute:NSUnderlineStyleAttributeName
                        value:@(NSUnderlineStyleSingle)
                        range:NSMakeRange(0, len)];
    }
    //删除线
    if(self.fontDeleteline==1)
    {
        [attrStr addAttribute:NSStrikethroughStyleAttributeName
                        value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                        range:NSMakeRange(0, len)];
    }
    
    self.b1dlb.attributedText=attrStr;
    CGRect rect=[self.b1dlb textRectForBounds:CGRectMake(0, 0, size.width, 1000) limitedToNumberOfLines:1];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    if(self.direction==0||self.direction==2){
        
        if(self.showTextMode==0)
        {
            //不显示文本
            self.containerView.frame=CGRectMake(0, 0, size.width, size.height);
            self.b1dlb.hidden=true;
        }
        else if(self.showTextMode==1)
        {
            //文本显示在上面
            if(rect.size
               .height>=size.height) return;
            self.b1dlb.frame=CGRectMake(0, 0, size.width,rect.size.height);
            
            self.containerView.frame=CGRectMake(0, self.b1dlb.frame.size.height, size.width, size.height-self.b1dlb.frame.size.height);
        }
        else
        {
            float top=self.frame.size.height-rect.size.height;
            if(top<=0) return;
            
            self.b1dlb.frame=CGRectMake(0, top, size.width,rect.size
                                        .height);
            
            self.containerView.frame=CGRectMake(0, 0, size.width, size.height-self.b1dlb.frame.size.height);
        }
        
        
        self.rightView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
        
        self.bottomView.frame=CGRectMake((self.frame.size.width-20)/2, self.frame.size.height-10, 20, 20);
    }
    else
    {
        if(self.showTextMode==0)
        {
            //不显示文本
            self.b1dlb.hidden=true;
            self.containerView.frame=CGRectMake(0, 0, size.height, size.width);
        }
        else if(self.showTextMode==1)
        {
            //上方
            self.containerView.frame=CGRectMake(0, self.b1dlb.frame.size.height,size.height, size.width-self.b1dlb.frame.size.height);
            
            self.b1dlb.frame=CGRectMake(0, 0, self.frame.size.height,self.b1dlb.frame.size.height);
        }
        else
        {
            self.containerView.frame=CGRectMake(0, 0, size.height, size.width-self.b1dlb.frame.size.height);
            
            self.b1dlb.frame=CGRectMake(0, self.containerView.frame.size.height, self.frame.size.height,self.b1dlb.frame.size.height);
        }
        
        
        self.rightView.frame=CGRectMake(self.frame.size.height-10, (self.frame.size.width-20)/2, 20, 20);
        
        self.bottomView.frame=CGRectMake((self.frame.size.height-20)/2, self.frame.size.width-10, 20, 20);
    }
}

-(void) showScaleView
{
    [super showScaleView];
    
    self.rightView=[[leftScaleView alloc] init];
    self.rightView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
    self.rightView.hidden=YES;
    self.rightView.pparent=self.parent;
    self.rightView.parent=self;
    
    //右小角放一个缩放图标
    UIImageView *rightImage=[[UIImageView alloc] init];
    rightImage.image=[UIImage imageNamed:@"Left_and_right_expansion_button"];
    rightImage.frame=CGRectMake(0, 0, 20, 20);
    [self.rightView addSubview:rightImage];
    [self addSubview:self.rightView];
    
    
    self.bottomView=[[BottomScaleView alloc] init];
    self.bottomView.frame=CGRectMake((self.frame.size.width-20)/2, self.frame.size.height-10, 20, 20);
    self.bottomView.hidden=YES;
    self.bottomView.pparent=self.parent;
    self.bottomView.parent=self;
    
    UIImageView *bottomImage=[[UIImageView alloc] init];
    bottomImage.image=[UIImage imageNamed:@"Up_and_down_expansion_button"];
    bottomImage.frame=CGRectMake(0, 0, 20, 20);
    [self.bottomView addSubview:bottomImage];
    [self addSubview:self.bottomView];
    
    [self resetViewWH:self.frame.size];
}

-(void) rotate:(int)angle
{
    [super rotate:angle];
    [self refresh];
}

//刷新
-(void) refresh
{
    
    [super refresh];
    
    if(self.isslected==1&&self.isLock==0)
    {
        self.rightView.hidden=NO;
        self.bottomView.hidden=NO;
    }
    else
    {
        self.rightView.hidden=YES;
        self.bottomView.hidden=YES;
    }
}

@end
