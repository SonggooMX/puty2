//
//  HomeViewController.m
//  printer
//
//  Created by songgoo on 2017/7/12.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

//顶部左边提示信息
@property (weak, nonatomic) IBOutlet UILabel *homeLBTopTip;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeLBTopTip.text=@"X:00mm  Y:00mm  宽:100mm  高:50mm";
    
}

@end
