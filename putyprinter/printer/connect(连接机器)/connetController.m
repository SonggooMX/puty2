//
//  connetController.m
//  printer
//
//  Created by 周宏全 on 2017/7/19.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "connetController.h"
#import "Masonry.h"

@interface connetController ()

@property (weak, nonatomic) IBOutlet UIView *statesView;

// 蓝牙
@property(nonatomic,strong)UIView *blueToothView;
// WIFI
@property(nonatomic,strong)UIView *wifiView;

@end

@implementation connetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"连接机器";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    //button.title = @"返回";
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    
    //新增蓝牙界面
    NSArray *blueViews = [[NSBundle mainBundle] loadNibNamed:@"blueTooth" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.blueToothView = [blueViews objectAtIndex:0];
    [self.statesView addSubview:self.blueToothView]; //添加
    [self.blueToothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.statesView);
    }];
    
    //新增WIFI界面
    NSArray *wifiViews = [[NSBundle mainBundle] loadNibNamed:@"WIFI" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.wifiView = [wifiViews objectAtIndex:0];
    [self.statesView addSubview:self.wifiView]; //添加
    [self.wifiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.statesView);
    }];
    
}

#pragma mark - 返回
-(void) reback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)connectChangeClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 21://标签
            [self.statesView bringSubviewToFront:self.blueToothView];
            break;
            
        case 22://插入
            [self.statesView bringSubviewToFront:self.wifiView];
            break;
            
        default:
            break;
    }
    
}


@end
