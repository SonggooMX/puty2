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
    
    UILabel *lb=[[UILabel alloc] init];
    lb.lineBreakMode=NSLineBreakByCharWrapping;
    lb.numberOfLines=0;
    
    [self addSubview:lb];
    CGRect rect=lb.frame;
    
    self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
    
    self.containerView=lb;
    
    //添加缩放图标
    [self showScaleView];
    
    [self resetViewWH:self.frame.size];
    
    [self refresh];
}

//自动换行
-(void) setWarp:(int)autoWarp
{
    self.autoWarp=autoWarp;
    ((UILabel*)self.containerView).numberOfLines=self.autoWarp==1?0:1;
    [self resetViewWH:self.frame.size];
}

//设置行间距 1 自定义  0  1倍 1.5倍 1.2倍
-(void) setLineSpace:(float)height withMode:(int)mode
{
    self.rowSpaceHeight=height;
    self.rowSpaceMode=mode;
    [self resetViewWH:self.frame.size];
}

-(void) resetViewWH:(CGSize)size
{
    [super resetViewWH:size];
    
    UILabel *lb=(UILabel*)self.containerView;
    lb.textAlignment=self.alignMode;
    lb.text=self.content;
    int len=(int)self.content.length;
    
    if(self.rowSpaceMode==1)
    {
        self.rowSpaceHeight=0.2f*[self getLineSpace:lb withW:100].size.height;
    }
    else if(self.rowSpaceMode==2)
    {
        self.rowSpaceHeight=0.5f*[self getLineSpace:lb withW:100].size.height;
    }
    else
    {
        self.rowSpaceHeight=0.0000001f;
    }
    
    float fontsize=((NSString*)[self.fontSizeContents objectAtIndex:self.fontSizeIndex]).floatValue*8;
    
    if(self.fontBlod==1)
    {
        lb.font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontsize];
    }
    else
    {
        lb.font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontsize];
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.content];
    
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.rowSpaceHeight];//调整行间距
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, len)];
    
    //字间距
    [attrStr addAttribute:NSKernAttributeName value:@(self.charSpaceWidth) range:NSMakeRange(0, len)];
    
    //字体 uilabel 富文本
    //http://blog.csdn.net/sinat_34194127/article/details/51702836
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
    
    lb.attributedText=attrStr;
    
    float lw=self.frame.size.width;
    if(self.direction==1||self.direction==3)
    {
        lw=self.frame.size.height;
    }
    
    CGRect rect=[lb textRectForBounds:CGRectMake(0, 0, lw, 1000) limitedToNumberOfLines:self.autoWarp==1?0:1];
    
    if(self.direction==0||self.direction==2){
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, lw, rect.size.height);
        
        self.containerView.frame=CGRectMake(0, 0, lw, rect.size.height);
        
         self.lbScaleView.frame=CGRectMake(self.frame.size.width-10, (self.frame.size.height-20)/2, 20, 20);
    }
    else
    {
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.height,lw);
        
        self.containerView.frame=CGRectMake(0, 0, lw, rect.size.height);
        
        self.lbScaleView.frame=CGRectMake(self.frame.size.height-10, (self.frame.size.width-20)/2, 20, 20);
    }
    
}

-(void) rotate:(int)angle
{
    [super rotate:angle];
    [self resetViewWH:self.frame.size];
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
