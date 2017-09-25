//
//  connetController.m
//  printer
//
//  Created by 周宏全 on 2017/7/19.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "connetController.h"
#import "Masonry.h"
#import "bluetoothscell.h"
#import "HomeBottomViewController.h"


@interface connetController () <UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIView *statesView;

// 蓝牙
@property(nonatomic,strong)UIView *blueToothView;
// WIFI
@property(nonatomic,strong)UIView *wifiView;

@end

@implementation connetController

-(void)viewDidDisappear:(BOOL)animated
{
    [self stopScanPeripheral];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"连接机器";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    //button.title = @"返回";
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    
    //新增WIFI界面
    NSArray *wifiViews = [[NSBundle mainBundle] loadNibNamed:@"WIFI" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.wifiView = [wifiViews objectAtIndex:0];
    [self.statesView addSubview:self.wifiView]; //添加
    [self.wifiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.statesView);
    }];
    
    //新增蓝牙界面
    NSArray *blueViews = [[NSBundle mainBundle] loadNibNamed:@"blueTooth" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.blueToothView = [blueViews objectAtIndex:0];
    [self.statesView addSubview:self.blueToothView]; //添加
    [self.blueToothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.statesView);
    }];
    
    self.parent.deviceListTableView=(UITableView*)[self.statesView viewWithTag:1000];
    self.parent.deviceListTableView.delegate=self;
    self.parent.deviceListTableView.dataSource=self;
    
    //UISwitch *sw=(UISwitch*)[self.blueToothView viewWithTag:123456];
    //[sw addTarget:self action:@selector(startScanner) forControlEvents:UIControlEventTouchUpInside];
    [self startScanner];
}

-(void) startScanner
{
    if (self.parent.activeDevice.state==CBPeripheralStateConnected)
        [self.parent.centralManager cancelPeripheralConnection:self.parent.activeDevice];
    //清空当前设备列表
    //if ( self.deviceList == nil)
    self.parent.deviceList = [[NSMutableArray alloc]init];
    //else [self.deviceList removeAllObjects];
    [self.parent.deviceListTableView reloadData];
    //[centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
    [self.parent.centralManager scanForPeripheralsWithServices:nil options:nil];
    //[scanConnectActivityInd startAnimating];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(stopScanPeripheral) userInfo:nil repeats:NO];
}

- (void) stopScanPeripheral
{
    [self.parent.centralManager stopScan];
    //[scanConnectActivityInd stopAnimating];
    NSLog(@"stop scan");
}

#pragma mark 这一组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.parent.deviceList.count;
}

#pragma mark 返回第indexPath这行对应的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    bluetoothscell * cell = (bluetoothscell*)[tableView dequeueReusableCellWithIdentifier:@"bluetoothcell"];
    
    if (cell == nil) {
        cell= [[[NSBundle  mainBundle]  loadNibNamed:@"bluetoothscell" owner:self options:nil]  lastObject];
    }
    
    UILabel *bluetoothName=(UILabel*)[cell viewWithTag:1000];
    
    CBPeripheral *cp=(CBPeripheral*)self.parent.deviceList[indexPath.row];
    bluetoothName.text =cp.name;
    if(cp.state==CBPeripheralStateConnected)
    {
        UILabel *lstate=(UILabel*)[cell viewWithTag:2000];
        lstate.hidden=false;
    }
    return cell;
}

#pragma mark -表格行点击事件
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先断开连接
    if(self.parent.activeDevice!=nil)
    {
        [self.parent.centralManager cancelPeripheralConnection:self.parent.activeDevice];
    }
    
    //重新连接
    CBPeripheral *device=(CBPeripheral*)self.parent.deviceList[indexPath.row];

    if(device.state==CBPeripheralStateConnected)
    {
        [self.parent.centralManager cancelPeripheralConnection:device];
    }
    else
    {
        [self.parent.centralManager stopScan];
        NSLog(@"stop scan");
        self.parent.activeDevice = device;
        [self.parent.centralManager connectPeripheral:device options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : @YES}];
        
        //关闭当前界面
        [self reback];
        
    }
    
    [self.parent.deviceListTableView reloadData];
}


-(void) alertMessage:(NSString *)msg{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                   message:msg
                                                  delegate:self
                                         cancelButtonTitle:@"关闭"
                                         otherButtonTitles:nil];
    [alert show];
    //[alert release];
    
}

#pragma mark - 返回
-(void) reback
{
    [self stopScanPeripheral];
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
