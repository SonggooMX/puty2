//
//  labelArea.h
//  printer
//
//  Created by songgoo on 2017/7/15.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewLabelViewController.h"

@interface labelArea : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property NewLabelViewController *parent;

@end
