//
//  HomeBottomViewController.m
//  printer
//
//  Created by songgoo on 2017/7/12.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "HomeBottomViewController.h"
#import "NewLabelViewController.h"
#import "PrintViewController.h"
#import "masterplateViewController.h"
#import "historyViewController.h"
#import "connetController.h"
#import "setViewController.h"

@interface HomeBottomViewController ()


@end

@implementation HomeBottomViewController {
    NewLabelViewController *_newLabelView;
    PrintViewController *_printView;
    masterplateViewController *_masterplateView;
    historyViewController *_historyView;
    connetController *_connectView;
    setViewController *_setView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnNewLabel:(UIButton *)sender {
    
    switch (sender.tag) {
        case 11:
            _newLabelView = [[NewLabelViewController alloc] init];
            [self.navigationController pushViewController:_newLabelView animated:YES];
            break;
            
        case 12:
            _printView = [[PrintViewController alloc] init];
            [self.navigationController pushViewController:_printView animated:YES];
            break;
            
        case 13:
            _masterplateView = [[masterplateViewController alloc] init];
            [self.navigationController pushViewController:_masterplateView animated:YES];
            break;
            
        case 14:
            _historyView = [[historyViewController alloc] init];
            [self.navigationController pushViewController:_historyView animated:YES];
            break;
            
        case 15:
            _connectView = [[connetController alloc] init];
            [self.navigationController pushViewController:_connectView animated:YES];
            break;
            
        case 16:
            _setView = [[setViewController alloc] init];
            [self.navigationController pushViewController:_setView animated:YES];
            break;
            
        default:
            break;
    }
    
}

// 点击选择标签
- (IBAction)clickTheLabel:(UIButton *)sender {
    
    _newLabelView = [[NewLabelViewController alloc] init];
    [self.navigationController pushViewController:_newLabelView animated:YES];
    
}



@end
