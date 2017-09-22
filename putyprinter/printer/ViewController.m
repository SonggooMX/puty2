//
//  ViewController.m
//  printer
//
//  Created by songgoo on 2017/7/10.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "ViewController.h"
#import "View2Controller.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)btnClick:(id)sender {
    [self performSegueWithIdentifier:@"gotoview2" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
