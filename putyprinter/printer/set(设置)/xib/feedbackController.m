//
//  feedbackController.m
//  printer
//
//  Created by 周宏全 on 2017/7/20.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "feedbackController.h"

@interface feedbackController ()

@end

@implementation feedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评价与反馈";
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
