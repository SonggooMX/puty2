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

-(void)updateTip:(NSString*)msg;

-(void) reback;


@end
