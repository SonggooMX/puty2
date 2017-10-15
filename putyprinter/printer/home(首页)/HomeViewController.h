//
//  HomeViewController.h
//  printer
//
//  Created by songgoo on 2017/7/12.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "HomeBottomViewController.h"

#pragma mark -蓝牙相关

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *drawImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelViewInfo;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end
