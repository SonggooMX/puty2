//
//  PrintConditions.m
//  printer
//
//  Created by songgoo on 2017/10/9.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "PrintConditions.h"


@implementation PrintConditions

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initFrame:frame];
    }
    return self;
}

- (void) initFrame:(CGRect)frame
{
    
    self.printDess=@[@"1(最淡)",@"2",@"3",@"4(较淡)",@"5",@"6(正常)",@"7",@"8",@"9",@"10",@"11(较浓)",@"12",@"13",@"14",@"15(最浓)"];
    self.printSpeeds=@[@"1(最慢)",@"2",@"3(正常)",@"4",@"5(最快)"];
    
    NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"PrintConditions" owner:self options:nil];
    self.contentView=[views objectAtIndex:0];
    self.contentView.frame=frame;
    self.contentView.layer.cornerRadius=5;
    [self addSubview:self.contentView];
    
    //e5e5e5
    UIColor *borderColor=[UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.000];
    
    [self.viewPrintDes.layer setBorderWidth:0.5];
    [self.viewPrintDes.layer setBorderColor:borderColor.CGColor];
    self.viewPrintDes.layer.cornerRadius=5;
    
    [self.viewPrintCount.layer setBorderWidth:0.5];
    [self.viewPrintCount.layer setBorderColor:borderColor.CGColor];
    self.viewPrintCount.layer.cornerRadius=5;
    
    [self.viewPrintSpeed.layer setBorderWidth:0.5];
    [self.viewPrintSpeed.layer setBorderColor:borderColor.CGColor];
    self.viewPrintSpeed.layer.cornerRadius=5;
}

-(void) setConfigPrintDirect:(int)printDirect
{
    self.printDirect=printDirect;
    //设置打印方向
    [self setButtonViewStyle:self.btnPrintDirect0 :false];
    [self setButtonViewStyle:self.btnPrintDirect90 :false];
    [self setButtonViewStyle:self.btnPrintDirect180 :false];
    [self setButtonViewStyle:self.btnPrintDirect270 :false];
    
    if(self.printDirect==0){
        [self setButtonViewStyle:self.btnPrintDirect0 :true];
    }
    else if(self.printDirect==1)
    {
        [self setButtonViewStyle:self.btnPrintDirect90 :true];
    }
    else if(self.printDirect==2)
    {
        [self setButtonViewStyle:self.btnPrintDirect180 :true];
    }
    else
    {
        [self setButtonViewStyle:self.btnPrintDirect270 :true];
    }
    

}

-(void) setConfigPrintDes:(int)printDes
{
    self.printDes=printDes;
    //打印浓度
    NSArray<NSString*> *arr=(NSArray*)self.printDess;
    self.lbPrintDes.text=[NSString stringWithFormat:@"%@",[arr objectAtIndex:self.printDes]];
}

-(void) setConfigPrintSpeed:(int)printSpeed
{
    self.printSpeed=printSpeed;
    //打印速度
    NSArray<NSString*> *arr2=(NSArray*)self.printSpeeds;
    self.lbPrintSpeed.text=[NSString stringWithFormat:@"%@",[arr2 objectAtIndex:self.printSpeed]];
}

//选择打印机
- (IBAction)btnSelectPrinter:(id)sender {
    [self.parent selectPrinter];
    
}


#pragma mark - 设置样式
- (void)setButtonViewStyle:(UIView*)view :(BOOL)isfocus
{
    //017ce2
    UIColor *backColor=[UIColor colorWithRed:1.0/255 green:124.0/255 blue:226.0/255 alpha:1.000];
    UIColor *whiteColor=[UIColor colorWithRed:1.0 green:1 blue:1 alpha:1.000];
    //e5e5e5
    UIColor *borderColor=[UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.000];
    
    [view.layer setBorderWidth:0.5];
    [view.layer setBorderColor:borderColor.CGColor];
    view.layer.cornerRadius=5;
    if(isfocus)
    {
        [view.layer setBackgroundColor:backColor.CGColor];
        ((UILabel*)view.subviews[1]).textColor=whiteColor;
    }
    else
    {
        [view.layer setBackgroundColor:whiteColor.CGColor];//白色
        ((UILabel*)view.subviews[1]).textColor=[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.000];
        
    }
}

//打印
- (IBAction)btnPrintLabel:(id)sender {
    [self.parent printLabel];
}

//按钮点击切换
- (IBAction)btnSelect:(UIButton*)sender {
    
    switch (sender.tag) {
        case 1000:
        case 1001:
        case 1002:
        case 1003:
            [self setButtonViewStyle:self.btnPrintDirect0 :false];
            [self setButtonViewStyle:self.btnPrintDirect90 :false];
            [self setButtonViewStyle:self.btnPrintDirect180 :false];
            [self setButtonViewStyle:self.btnPrintDirect270 :false];
            self.printDirect=(int)sender.tag-1000;
            break;
    }
    
    [self setButtonViewStyle:sender.superview :YES];
    
}

//打印浓度
- (IBAction)btnPrintDes:(UIButton*)sender {
    int ste=(int)sender.tag;
    NSArray<NSString*> *arr=(NSArray*)self.printDess;
    int c=self.lbPrintDes.text.intValue;
    if(c<=1&&ste<=0) return;
    if(c>=15&&ste>=0) return;
    c=c+ste;
    self.lbPrintDes.text=[NSString stringWithFormat:@"%@",[arr objectAtIndex:c-1]];
    self.printDes=self.lbPrintDes.text.intValue-1;
}

//打印速度
- (IBAction)btnPrintSpeed:(UIButton*)sender {
    int ste=(int)sender.tag;
    NSArray<NSString*> *arr=(NSArray*)self.printSpeeds;
    int c=self.lbPrintSpeed.text.intValue;
    if(c<=1&&ste<=0) return;
    if(c>=5&&ste>=0) return;
    c=c+ste;
    self.lbPrintSpeed.text=[NSString stringWithFormat:@"%@",[arr objectAtIndex:c-1]];
    self.printSpeed=self.lbPrintSpeed.text.intValue-1;
    
}

//打印份数
- (IBAction)btnPrintCopys:(UIButton*)sender {
     int ste=(int)sender.tag;
    int c=self.lbPrintCopys.text.intValue;
    if(c<=1&&ste<=0) return;
    if(c>=200&&ste>=0) return;
    c=c+ste;
    self.lbPrintCopys.text=[NSString stringWithFormat:@"%d",c];
    self.printCopys=self.lbPrintCopys.text.intValue-1;
}


@end
