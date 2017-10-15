//
//  HomeViewController.m
//  printer
//
//  Created by songgoo on 2017/7/12.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "HomeViewController.h"

extern UIImage *TEMP_BITMAP;
extern NSString *TEMP_LABEL_MESSAGE;

@interface HomeViewController ()

//顶部左边提示信息
@property (weak, nonatomic) IBOutlet UILabel *homeLBTopTip;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeLBTopTip.text=@"X:00mm  Y:00mm  宽:100mm  高:50mm";
}

-(void) viewWillAppear:(BOOL)animated
{
    self.drawImageView.layer.cornerRadius=5;
    if(TEMP_BITMAP==nil)
    {
        self.drawImageView.backgroundColor=UIColor.whiteColor;
    }
    else
    {
        self.drawImageView.image=TEMP_BITMAP;
        self.labelViewInfo.text=TEMP_LABEL_MESSAGE;
        self.drawImageView.backgroundColor=nil;
    }
}

@end
