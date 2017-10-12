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
#import "PrintConditions.h"

@interface PrintViewController ()

@property (weak, nonatomic) IBOutlet UIView *topDrawView;

@property (weak, nonatomic) IBOutlet UIView *bottomFuncView;


// 画板视图
@property(nonatomic,strong)UIView *drawView;


// 功能视图
@property(nonatomic,strong)UIView *funcView;

@property UILabel *currentSelectPrinter;
@property UIButton *btnSelectPrinter;

@property PrintConditions *pc;

@end



@implementation PrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect=[UIScreen mainScreen].bounds;
    
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
    
    // 打印参数界面
    self.pc=[[PrintConditions alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 320)];
   
    [self.pc setConfigPrintDirect:self.printDirect];
    [self.pc setConfigPrintSpeed:self.printSpeed-1];
    [self.pc setConfigPrintDes:self.printDes-1];
    
    self.pc.parent=self;
    //NSArray *funcViews = [[NSBundle mainBundle] loadNibNamed:@"print" owner:self options:nil]; //通过这个方法,取得我们的视图
    //self.funcView = [funcViews objectAtIndex:0];
    //    self.subView.frame = CGRectMake(0, 0, rect.size.width, 284); //设置frame
    [self.bottomFuncView addSubview:self.pc]; //添加
    [self.funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.bottomFuncView);
    }];
    
}

#pragma mark -选择打印机
-(void) selectPrinter
{
    connetController *_connectView = [[connetController alloc] init];
    _connectView.parent=self.parent;
    
    [self.navigationController pushViewController:_connectView animated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    if(self.parent.activeDevice==nil)
    {
        self.pc.lbSelectPrinter.text=@"未连接打印机";
        return;
    }
    self.pc.lbSelectPrinter.text=self.parent.activeDevice.name;
}


#pragma  mark -打印
-(void) printLabel
{
    if(!(self.parent.activeDevice!=nil&&self.parent.activeDevice.state==CBPeripheralStateConnected&&self.parent.activeWriteCharacteristic!=nil&&self.parent.activeReadCharacteristic!=nil))
    {
        [self.parent alertMessage:@"打印机未连接！"];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"请稍后，正在打印...";
    [hud showAnimated:true];
    
    //设置图片大小
    Util *ut=[Util new];
    UIImage *bmp=[ut PostScale:self.pv withW:self.labelWidth*8 withH:self.labelHeight*8];
    
    //设置图片打印方向及尺寸
    switch (self.printDirect*90) {
        case 270:
            bmp=[ut image:bmp rotation:UIImageOrientationLeft];
            break;
        case 180:
            bmp=[ut image:bmp rotation:UIImageOrientationDown];
            break;
        case 90:
            bmp=[ut image:bmp rotation:UIImageOrientationRight];
            break;
        default:
            break;
    }
    
    [self saveImageToPhotos:bmp];
    
    
    
    //检查打印机状态
    self.pt=[Print new];
    self.pt.parent=self.parent;
    
    int w=bmp.size.width/8;
    int h=bmp.size.height/8;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        for(int i=1;i<=self.pc.lbPrintCopys.text.intValue;i++)
        {
            while (self.pt.sendDataComplete>0) {
                NSLog(@"%d",self.pt.sendDataComplete);
            }
            self.pt.sendDataComplete=1;
            //[mbphud hideHUD];
            //[mbphud showMessage:[NSString stringWithFormat:@"请稍后，正在打印%d/%d",i,self.pc.lbPrintCopys.text.intValue]];
            [self.pt printLabel:bmp lw:w lh:h pt:1 pageTotal:self.pc.lbPrintCopys.text.intValue pageIndex:i];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    //[mbphud hideHUD];
    
    //self.pv imager
    //NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"方式一启动"];
    
    //需要启动一下
    //[thread1 start];
}

-(void) run:(NSString*)content
{
    
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
