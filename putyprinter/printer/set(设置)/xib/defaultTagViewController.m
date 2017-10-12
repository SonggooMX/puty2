//
//  defaultTagViewController.m
//  printer
//
//  Created by 周宏全 on 2017/7/20.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "defaultTagViewController.h"

@interface defaultTagViewController ()




@end

@implementation defaultTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.printDess=@[@"1(最淡)",@"2",@"3",@"4(较淡)",@"5",@"6(正常)",@"7",@"8",@"9",@"10",@"11(较浓)",@"12",@"13",@"14",@"15(最浓)"];
    self.printSpeeds=@[@"1(最慢)",@"2",@"3(正常)",@"4",@"5(最快)"];
    
    self.navigationItem.title = @"默认标签属性";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    
    
    [self setViewStyle];
    
    [self setButtonViewStyle:self.printDirect0 :false];
    [self setButtonViewStyle:self.printDirect90 :true];
    [self setButtonViewStyle:self.printDirect180 :false];
    [self setButtonViewStyle:self.printDirect270 :false];
    
    [self setButtonViewStyle:self.pagetType0 :false];
    [self setButtonViewStyle:self.pagetType1 :false];
    [self setButtonViewStyle:self.pagetType2 :true];
    [self setButtonViewStyle:self.pagetType3 :false];
    
}

#pragma mark - 设置按钮样式
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
        [((UIButton*)view) setTitleColor:whiteColor forState:UIControlStateNormal];
    }
    else
    {
        [view.layer setBackgroundColor:whiteColor.CGColor];//白色
        [((UIButton*)view) setTitleColor: [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.000] forState:(UIControlStateNormal)];
        
    }
}

#pragma mark - 设置样式
-(void) setViewStyle
{
    //e5e5e5
    UIColor *borderColor=[UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.000];
    
    [self.viewLabelWidth.layer setBorderWidth:0.5];
    [self.viewLabelWidth.layer setBorderColor:borderColor.CGColor];
    self.viewLabelWidth.layer.cornerRadius=5;
    
    [self.viewLabelHeight.layer setBorderWidth:0.5];
    [self.viewLabelHeight.layer setBorderColor:borderColor.CGColor];
    self.viewLabelHeight.layer.cornerRadius=5;
    
    [self.viewPrintSpeed.layer setBorderWidth:0.5];
    [self.viewPrintSpeed.layer setBorderColor:borderColor.CGColor];
    self.viewPrintSpeed.layer.cornerRadius=5;
    
    [self.viewPrintDes.layer setBorderWidth:0.5];
    [self.viewPrintDes.layer setBorderColor:borderColor.CGColor];
    self.viewPrintDes.layer.cornerRadius=5;
}

#pragma mark - 按钮颜色切换
- (IBAction)btnSelect:(UIButton*)sender {
    
    switch (sender.tag) {
        case 1000:
        case 1001:
        case 1002:
        case 1003:
            [self setButtonViewStyle:self.printDirect0 :false];
            [self setButtonViewStyle:self.printDirect90 :false];
            [self setButtonViewStyle:self.printDirect180 :false];
            [self setButtonViewStyle:self.printDirect270 :false];
            break;
        case 2000:
        case 2001:
        case 2002:
        case 2003:
            [self setButtonViewStyle:self.pagetType0 :false];
            [self setButtonViewStyle:self.pagetType1 :false];
            [self setButtonViewStyle:self.pagetType2 :false];
            [self setButtonViewStyle:self.pagetType3 :false];
            break;
    }
    
    [self setButtonViewStyle:sender :YES];
    
}

- (IBAction)btnClick:(UIButton*)sender {
    [self setLabelText:self.lbWidth sender:sender];
}

- (IBAction)btnHClick:(UIButton*)sender {
    [self setLabelText:self.lbHeight sender:sender];
}



#pragma mark - 更改毫米
-(void) setLabelText:(UILabel*)lb sender:(UIButton*)button
{
    double vl=lb.text.doubleValue;
    vl=vl+button.tag*0.1;
    vl=vl<=0.0?0.1:vl;
    lb.text=[NSString stringWithFormat:@"%.2f",vl];
}

- (IBAction)btnPD:(UIButton*)sender {
    [self setLabelText2:self.lbPrintDes sender:sender];
}
- (IBAction)btnPS:(UIButton*)sender {
    [self setLabelText2:self.lbPrintSpeed sender:sender];
}


#pragma mark - 更改数组
-(void) setLabelText2:(UILabel*)lb sender:(UIButton*)button
{
    int ste=(int)button.tag;
    NSArray<NSString*> *arr=(NSArray*)self.printDess;
    int c=self.lbPrintDes.text.intValue;
    if(c<=1&&ste<=0) return;
    if(c>=15&&ste>=0) return;
    c=c+ste;
    self.lbPrintDes.text=[NSString stringWithFormat:@"%@",[arr objectAtIndex:c-1]];
}

#pragma mark - 返回
-(void) reback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
