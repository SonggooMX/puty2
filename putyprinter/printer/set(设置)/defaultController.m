//
//  defaultController.m
//  printer
//
//  Created by 周宏全 on 2017/7/20.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "defaultController.h"
#import "defaultTagViewController.h"
#import "defaultTextViewController.h"
#import "oneDimensionalViewController.h"
#import "twoDimensionalViewController.h"
#import "pictureViewController.h"
#import "recViewController.h"

@interface defaultController ()

@end

@implementation defaultController{
    defaultTagViewController *_defaultTagView;
    defaultTextViewController *_defaultTextView;
    oneDimensionalViewController *_oneDimensionalView;
    twoDimensionalViewController *_twoDimensionalView;
    pictureViewController *_pictureView;
    recViewController *_recView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"默认属性";
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

- (IBAction)defaultClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1011:
            _defaultTagView = [[defaultTagViewController alloc] init];
            [self.navigationController pushViewController:_defaultTagView animated:YES];
            break;
            
        case 1012:
            _defaultTextView = [[defaultTextViewController alloc] init];
            [self.navigationController pushViewController:_defaultTextView animated:YES];
            break;
            
        case 1013:
            _oneDimensionalView = [[oneDimensionalViewController alloc] init];
            [self.navigationController pushViewController:_oneDimensionalView animated:YES];
            break;
            
        case 1014:
            _twoDimensionalView = [[twoDimensionalViewController alloc] init];
            [self.navigationController pushViewController:_twoDimensionalView animated:YES];
            break;
            
        case 1015:
            _pictureView = [[pictureViewController alloc] init];
            [self.navigationController pushViewController:_pictureView animated:YES];
            break;
            
        case 1016:
            _recView = [[recViewController alloc] init];
            [self.navigationController pushViewController:_recView animated:YES];
            break;
            
        default:
            break;
    }
    
}


@end
