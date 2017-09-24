//
//  PrintViewController.m
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "PrintViewController.h"
#import "Masonry.h"

@interface PrintViewController ()

@property (weak, nonatomic) IBOutlet UIView *topDrawView;

@property (weak, nonatomic) IBOutlet UIView *bottomFuncView;


// 画板视图
@property(nonatomic,strong)UIView *drawView;


// 功能视图
@property(nonatomic,strong)UIView *funcView;

@end



@implementation PrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"打印";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    //button.title = @"返回";
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    
    // 新建画板视图
    NSArray *drawViews = [[NSBundle mainBundle] loadNibNamed:@"draw" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.drawView = [drawViews objectAtIndex:0];
    //    self.subView.frame = CGRectMake(0, 0, rect.size.width, 284); //设置frame
    [self.topDrawView addSubview:self.drawView]; //添加
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.topDrawView);
    }];
    
    //打印预览图
    self.iv =(UIImageView*)[self.topDrawView viewWithTag:8899];
    [self setPrintViewImage:self.pv];
    //标签信息
    [((UILabel*)[self.topDrawView viewWithTag:9988]) setText:self.labelInfo];
    
    // 新建功能视图
    NSArray *funcViews = [[NSBundle mainBundle] loadNibNamed:@"print" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.funcView = [funcViews objectAtIndex:0];
    //    self.subView.frame = CGRectMake(0, 0, rect.size.width, 284); //设置frame
    [self.bottomFuncView addSubview:self.funcView]; //添加
    [self.funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.bottomFuncView);
    }];
    
}

-(void) setPrintViewImage:(UIImage*)img
{
    //图片保存本地
    //[self saveImageToPhotos:img];
    [self.iv setImage:img];
}

//实现该方法
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
}

//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}

#pragma mark - 返回
-(void) reback
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
