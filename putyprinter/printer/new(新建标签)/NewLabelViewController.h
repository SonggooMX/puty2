//
//  NewLabelViewController.h
//  printer
//
//  Created by songgoo on 2017/7/13.
//  Copyright © 2017年 puty. All rights reserved.
//


#import "drawArea.h"
#import <UIKit/UIKit.h>
@interface NewLabelViewController : UIViewController

@property float LabelSacle;

@property drawArea *drawAreaView;
@property (weak, nonatomic) IBOutlet UIView *drawViewContent;
// 整个底部功能区
@property (weak, nonatomic) IBOutlet UIView *bottomview;

-(void)updateTip:(NSString*)msg;

-(void) reback;

- (IBAction)btnSwitchView:(id)sender;


@end
