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

-(void) setPrintViewImage:(UIImage*)img;

@end
