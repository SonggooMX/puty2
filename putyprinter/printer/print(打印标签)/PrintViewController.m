//
//  PrintViewController.m
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "PrintViewController.h"
#import "Masonry.h"
#import "Print.h"
#import "HomeBottomViewController.h"

@interface PrintViewController ()

@property (weak, nonatomic) IBOutlet UIView *topDrawView;

@property (weak, nonatomic) IBOutlet UIView *bottomFuncView;


// 画板视图
@property(nonatomic,strong)UIView *drawView;


// 功能视图
@property(nonatomic,strong)UIView *funcView;

@property UILabel *currentSelectPrinter;
@property UIButton *btnSelectPrinter;

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
    
    //打印按钮点击
    UIButton *btnPrint=(UIButton*)[self.funcView viewWithTag:8888];
    [btnPrint addTarget:self action:@selector(printLabel) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.currentSelectPrinter=(UILabel*)[self.funcView viewWithTag:6001];
    self.btnSelectPrinter=(UIButton*)[self.funcView viewWithTag:6000];
    [self.btnSelectPrinter addTarget:self action:@selector(selectPrinter) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    if(self.parent.activeDevice==nil)
    {
        self.currentSelectPrinter.text=@"未连接打印机";
        return;
    }
    self.currentSelectPrinter.text=self.parent.activeDevice.name;
}

#pragma mark -选择打印机
-(void) selectPrinter
{
    connetController *_connectView = [[connetController alloc] init];
    _connectView.parent=self.parent;
    
    [self.navigationController pushViewController:_connectView animated:YES];
}

#pragma  mark -打印
-(void) printLabel
{
    if(!(self.parent.activeDevice!=nil&&self.parent.activeDevice.state==CBPeripheralStateConnected&&self.parent.activeWriteCharacteristic!=nil&&self.parent.activeReadCharacteristic!=nil))
    {
        [self.parent alertMessage:@"打印机未连接！"];
        return;
    }
    
    //检查打印机状态
    Print *pt=[Print new];
    pt.parent=self.parent;
    int w=self.pv.size.width/8;
    int h=self.pv.size.height/8;
    [pt printLabel:self.pv lw:w lh:h pt:1 pageTotal:1 pageIndex:1];
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
