//
//  historyViewController.m
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "historyViewController.h"
#import "Masonry.h"

@interface historyViewController ()

@property (weak, nonatomic) IBOutlet UIView *historyMasterView;

@property (weak, nonatomic) IBOutlet UIView *historyShowView;

// 模版
@property(nonatomic,strong)UIView *masterView;
// 展示视图
@property(nonatomic,strong)UIView *showView;

@end

@implementation historyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"标签模版";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    //button.title = @"返回";
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    
    UIBarButtonItem *scanBtn = [[UIBarButtonItem alloc] init];
    scanBtn.title = @"扫一扫";
    scanBtn.image = [UIImage imageNamed:@"scan_grey_icon"];
    scanBtn.target = self;
    scanBtn.action = @selector(scan);
    [self.navigationItem setRightBarButtonItem:scanBtn];
    
    // 模版视图
    NSArray *mView = [[NSBundle mainBundle] loadNibNamed:@"historyMaster" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.masterView = [mView objectAtIndex:0];
    [self.historyMasterView addSubview:self.masterView]; //添加
    [self.masterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.historyMasterView);
    }];
    
    // 展示视图
    NSArray *shView = [[NSBundle mainBundle] loadNibNamed:@"historyShow" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.showView = [shView objectAtIndex:0];
    [self.historyShowView addSubview:self.showView]; //添加
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.historyShowView);
    }];
    
}

#pragma mark - 返回
-(void)reback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 扫一扫
-(void)scan
{
    NSLog(@"扫一扫");
}


@end
