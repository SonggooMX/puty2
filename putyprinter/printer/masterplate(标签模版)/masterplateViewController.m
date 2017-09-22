//
//  masterplateViewController.m
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "masterplateViewController.h"
#import "Masonry.h"
#import "ZXLoginViewController.h"

@interface masterplateViewController ()

// 搜索视图
@property (weak, nonatomic) IBOutlet UIView *searchView;
// 模版视图
@property (weak, nonatomic) IBOutlet UIView *masterView;
// 展示模版视图
@property (weak, nonatomic) IBOutlet UIView *showView;

// 模版
@property(nonatomic,strong)UIView *mView;
// 展示视图
@property(nonatomic,strong)UIView *sView;

@end

@implementation masterplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"历史记录";
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
    

    
    // 展示视图
    NSArray *shView = [[NSBundle mainBundle] loadNibNamed:@"show" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.sView = [shView objectAtIndex:0];
    [self.showView addSubview:self.sView]; //添加
    [self.sView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.showView);
    }];
    
}

#pragma mark - 返回
-(void)reback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginVC:(id)sender {
    ZXLoginViewController *loginVC = [ZXLoginViewController new];
    loginVC.title = @"专用模板";
    [self.navigationController pushViewController:loginVC animated:YES];
}
#pragma mark - 扫一扫
-(void)scan
{
    NSLog(@"扫一扫");
}

@end
