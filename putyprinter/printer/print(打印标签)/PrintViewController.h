//
//  PrintViewController.h
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewLabelViewController.h"

@interface PrintViewController : UIViewController
@property UIImageView *iv ;
@property UIImage *pv;
@property NSString *labelInfo;

-(void) setPrintViewImage:(UIImage*)img;

@end
