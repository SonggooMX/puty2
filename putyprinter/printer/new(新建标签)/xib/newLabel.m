//
//  newLabel.m
//  printer
//
//  Created by songgoo on 2017/8/4.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "newLabel.h"

@implementation newLabel

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
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"newLabel" owner:self options:nil];
        self.contentView=[views objectAtIndex:0];
        self.contentView.frame=frame;
        [self addSubview:self.contentView];
        
        self.printDirect=1;
        self.pagetType=2;
        
        self.printDesnty=6;
        self.printSpeed=3;
        
        
        //设置打印方向
        [self setButtonViewStyle:self.btnPrintDirect0 :false];
        [self setButtonViewStyle:self.btnPrintDirect90 :true];
        [self setButtonViewStyle:self.btnPrintDirect180 :false];
        [self setButtonViewStyle:self.btnprintDirect270 :false];
        
        //纸张类型
        [self setButtonViewStyle:self.btnPageType0 :false];
        [self setButtonViewStyle:self.btnPageType1 :false];
        [self setButtonViewStyle:self.btnPageType2 :true];
        [self setButtonViewStyle:self.btnPageType3 :false];
        
    }
    return self;
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
            [self setButtonViewStyle:self.btnprintDirect270 :false];
            self.printDirect=(int)sender.tag-1000;
            break;
        default:
            [self setButtonViewStyle:self.btnPageType0 :false];
            [self setButtonViewStyle:self.btnPageType1 :false];
            [self setButtonViewStyle:self.btnPageType2 :false];
            [self setButtonViewStyle:self.btnPageType3 :false];
            self.pagetType=(int)sender.tag-2000;
            break;
    }
    
    [self setButtonViewStyle:sender.superview :YES];
    
}




- (IBAction)labelNameClick:(UIButton *)sender {
    
    NSString *title;
    NSString *message;
    switch (sender.tag) {
        case 1101:
            title = @"标签名称";
            message= @"请输入标签名称";
            break;
        case 1102:
            title = @"标签宽度";
            message= @"范围：1～1000 单位：mm";
            break;
        case 1103:
            title = @"标签高度";
            message= @"范围：1～1000 单位：mm";
            break;
        default:
            break;
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"";
        switch (sender.tag) {
            case 1102:
            case 1103:
                textField.keyboardType=UIKeyboardTypeDecimalPad;
                break;
            default:
                break;
        }
    }];
    
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
        switch (sender.tag) {
            case 1101:
                self.lbName.text=alertVC.textFields.firstObject.text;
                break;
            case 1102:
                self.lbWidth.text=[NSString stringWithFormat:@"%@mm",alertVC.textFields.firstObject.text];
                break;
            case 1103:
                self.lbHeight.text=[NSString stringWithFormat:@"%@mm",alertVC.textFields.firstObject.text];
                break;
            default:
                break;
        }
    }];
    
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [alertVC addAction:ac1];
    [alertVC addAction:ac2];
    
    [self.parent presentViewController:alertVC animated:YES completion:nil];
    
}

//取消
- (IBAction)btnCancel:(id)sender {
    if(self.fromType==0){
        [self.parent reback];
    }
    else if(self.fromType==1)
    {
        [self removeFromSuperview];
        //开启顶部icon按钮
        [self.parent setTopIconButton];
    }
}
//确定
- (IBAction)btnOK:(id)sender {
    [self removeFromSuperview];
    
    NSString *width=[self.lbWidth.text stringByReplacingOccurrencesOfString:@"mm" withString:@""];
    NSString *height=[self.lbHeight.text stringByReplacingOccurrencesOfString:@"mm" withString:@""];
    
    self.labelName=self.lbName.text;
    
    [self refresh:width withHeight:height];
    
    //选中首页插入模块
    UIButton *bt=[[UIButton alloc] init];
    bt.tag=1002;
    [self.parent btnSwitchView:bt];
    //开启顶部icon按钮
    [self.parent setTopIconButton];
}

//刷新界面
-(void)refresh:(NSString*)width withHeight:(NSString*)height
{
    self.labelWidth=[width floatValue];
    self.labelHeight=[height floatValue];
    
    float w=[width floatValue]*8;
    float h=[height floatValue]*8;
    
    //画图实际区域
    CGRect reel=self.parent.drawAreaView.superview.frame;
    float rw=reel.size.width;
    float rh=reel.size.height;
    
    float sw=rw/w;
    float sh=rh/h;
    
    //缩放比例
    float sc=sw>sh?sh:sw;
    
    CGRect frame=self.parent.drawAreaView.frame;
    frame=CGRectMake((rw-w*sc)/2, (rh-h*sc)/2, w*sc, h*sc);
    self.parent.drawAreaView.frame=frame;
    self.parent.LabelSacle=sc;
}

@end
