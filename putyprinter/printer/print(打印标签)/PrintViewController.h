//
//  PrintViewController.h
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "connetController.h"
#import "HomeBottomViewController.h"

@interface PrintViewController : UIViewController

@property HomeBottomViewController *parent;

@property UIImageView *iv ;
@property UIImage *pv;
@property NSString *labelInfo;

@property int printDes;
@property int printSpeed;
@property int printDirect;

#pragma mark -标签的实际宽高(毫米)
@property float labelWidth;
@property float labelHeight;

-(void) setPrintViewImage:(UIImage*)img;
-(void) printLabel;
-(void) selectPrinter;

@end
