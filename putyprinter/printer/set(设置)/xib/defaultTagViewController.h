//
//  defaultTagViewController.h
//  printer
//
//  Created by 周宏全 on 2017/7/20.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface defaultTagViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *printDirect0;

@property (weak, nonatomic) IBOutlet UIButton *printDirect90;

@property (weak, nonatomic) IBOutlet UIButton *printDirect180;

@property (weak, nonatomic) IBOutlet UIButton *printDirect270;

@property (weak, nonatomic) IBOutlet UIButton *pagetType0;
@property (weak, nonatomic) IBOutlet UIButton *pagetType1;
@property (weak, nonatomic) IBOutlet UIButton *pagetType2;
@property (weak, nonatomic) IBOutlet UIButton *pagetType3;



@property (weak, nonatomic) IBOutlet UIView *viewPageType;
@property (weak, nonatomic) IBOutlet UIView *viewPrintDirect;
@property (weak, nonatomic) IBOutlet UIView *viewLabelWidth;
@property (weak, nonatomic) IBOutlet UIView *viewLabelHeight;
@property (weak, nonatomic) IBOutlet UIView *viewPrintDes;
@property (weak, nonatomic) IBOutlet UIView *viewPrintSpeed;


@property (weak, nonatomic) IBOutlet UILabel *lbWidth;
@property (weak, nonatomic) IBOutlet UILabel *lbHeight;
@property (weak, nonatomic) IBOutlet UILabel *lbPrintDes;
@property (weak, nonatomic) IBOutlet UILabel *lbPrintSpeed;

//打印浓度
@property NSArray *printDess;
//打印速度
@property NSArray *printSpeeds;

@end
