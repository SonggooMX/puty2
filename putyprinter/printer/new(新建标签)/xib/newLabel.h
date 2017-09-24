//
//  newLabel.h
//  printer
//
//  Created by songgoo on 2017/8/4.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewLabelViewController.h"

@interface newLabel : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property NewLabelViewController *parent;

// 打印方向 0°
@property (weak, nonatomic) IBOutlet UIView *btnPrintDirect0;
// 打印方向 90°
@property (weak, nonatomic) IBOutlet UIView *btnPrintDirect90;
// 打印方向 180°
@property (weak, nonatomic) IBOutlet UIView *btnPrintDirect180;
// 打印方向 270°
@property (weak, nonatomic) IBOutlet UIView *btnprintDirect270;

// 连续纸
@property (weak, nonatomic) IBOutlet UIView *btnPageType0;
// 定位孔
@property (weak, nonatomic) IBOutlet UIView *btnPageType1;
// 间隙纸
@property (weak, nonatomic) IBOutlet UIView *btnPageType2;
// 黑标纸
@property (weak, nonatomic) IBOutlet UIView *btnPageType3;


@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbWidth;
@property (weak, nonatomic) IBOutlet UILabel *lbHeight;


//默认从主界面跳转到新建界面 0：主界面 1：新建界面
@property int fromType;

//当前标签的实际大小 毫米
@property float labelWidth;
@property float labelHeight;


@end
