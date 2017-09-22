//
//  setViewController.m
//  printer
//
//  Created by 周宏全 on 2017/7/20.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "setViewController.h"
#import "printController.h"
#import "languageController.h"
#import "fontController.h"
#import "logoController.h"
#import "defaultController.h"
#import "feedbackController.h"

@interface setViewController ()

@end

@implementation setViewController{
    printController *_printView;
    languageController *_languageView;
    fontController *_fontView;
    logoController *_logoView;
    defaultController *_defaultView;
    feedbackController *_feedbackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
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

#pragma mark - 界面跳转
- (IBAction)nextViewClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 111:
            _printView = [[printController alloc] init];
            [self.navigationController pushViewController:_printView animated:YES];
            break;
            
        case 112:
            _languageView = [[languageController alloc] init];
            [self.navigationController pushViewController:_languageView animated:YES];
            break;
            
        case 113:
            _fontView = [[fontController alloc] init];
            [self.navigationController pushViewController:_fontView animated:YES];
            break;
            
        case 114:
            _logoView = [[logoController alloc] init];
            [self.navigationController pushViewController:_logoView animated:YES];
            break;
            
        case 115:
            _defaultView = [[defaultController alloc] init];
            [self.navigationController pushViewController:_defaultView animated:YES];
            break;
            
        case 116:
            _feedbackView = [[feedbackController alloc] init];
            [self.navigationController pushViewController:_feedbackView animated:YES];
            break;
            
        default:
            break;
    }
    
}


@end
