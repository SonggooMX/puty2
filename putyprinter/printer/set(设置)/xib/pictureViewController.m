//
//  pictureViewController.m
//  printer
//
//  Created by 周宏全 on 2017/7/20.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "pictureViewController.h"

@interface pictureViewController ()

@end

@implementation pictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"默认图片属性";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    
}

#pragma mark - 返回
-(void) reback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
