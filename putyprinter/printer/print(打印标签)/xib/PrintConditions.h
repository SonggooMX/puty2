//
//  PrintConditions.h
//  printer
//
//  Created by songgoo on 2017/10/9.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrintViewController.h"

@interface PrintConditions : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;

//当前选中的打印机
@property (weak, nonatomic) IBOutlet UILabel *lbSelectPrinter;

@property (weak, nonatomic) IBOutlet UIView *viewPrintDes;

@property (weak, nonatomic) IBOutlet UIView *viewPrintSpeed;
//打印份数
@property (weak, nonatomic) IBOutlet UIView *viewPrintCount;


@property (weak, nonatomic) IBOutlet UIView *btnPrintDirect0;

@property (weak, nonatomic) IBOutlet UIView *btnPrintDirect90;

@property (weak, nonatomic) IBOutlet UIView *btnPrintDirect180;

@property (weak, nonatomic) IBOutlet UIView *btnPrintDirect270;


//打印按钮
@property (weak, nonatomic) IBOutlet UIButton *btnPrint;

@property PrintViewController *parent;

//打印浓度
@property NSArray *printDess;
//打印方向
@property NSArray *printDirects;
//打印速度
@property NSArray *printSpeeds;

@property (weak, nonatomic) IBOutlet UILabel *lbPrintDes;


@property (weak, nonatomic) IBOutlet UILabel *lbPrintSpeed;


@property (weak, nonatomic) IBOutlet UILabel *lbPrintCopys;

@property (nonatomic) int printSpeed;
@property (nonatomic) int printDes;
@property (nonatomic) int printDirect;
@property int printCopys;

-(void) setConfigPrintDirect:(int)printDirect;
-(void) setConfigPrintSpeed:(int)printSpeed;
-(void) setConfigPrintDes:(int)printDes;

@end
