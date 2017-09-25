//
//  connetController.m
//  printer
//
//  Created by 周宏全 on 2017/7/19.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "connetController.h"
#import "Masonry.h"
#import "NewLabelViewController.h"
#import "bluetoothscell.h"

@interface connetController () <UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate,CBPeripheralDelegate>


@property (weak, nonatomic) IBOutlet UIView *statesView;

// 蓝牙
@property(nonatomic,strong)UIView *blueToothView;
// WIFI
@property(nonatomic,strong)UIView *wifiView;

@property NSMutableArray *deviceList;
@property UITableView *deviceListTableView;

@end

@implementation connetController

-(void)viewDidDisappear:(BOOL)animated
{
    [self stopScanPeripheral];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化后会调用代理CBCentralManagerDelegate 的 - (void)centralManagerDidUpdateState:(CBCentralManager *)central
    centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
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
    
    self.deviceListTableView=(UITableView*)[self.statesView viewWithTag:1000];
    self.deviceListTableView.delegate=self;
    self.deviceListTableView.dataSource=self;
    
    [self startScanner];
}

-(void) startScanner
{
    if (peripheral.state==CBPeripheralStateConnected)
        [centralManager cancelPeripheralConnection:peripheral];
    //清空当前设备列表
    //if ( self.deviceList == nil)
    self.deviceList = [[NSMutableArray alloc]init];
    //else [self.deviceList removeAllObjects];
    [self.deviceListTableView reloadData];
    //[centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
    [centralManager scanForPeripheralsWithServices:nil options:nil];
    //[scanConnectActivityInd startAnimating];
    [NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(stopScanPeripheral) userInfo:nil repeats:NO];
}

- (void) stopScanPeripheral
{
    [centralManager stopScan];
    //[scanConnectActivityInd stopAnimating];
    NSLog(@"stop scan");
}

#pragma mark 这一组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.deviceList.count;
}

#pragma mark 返回第indexPath这行对应的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    bluetoothscell * cell = (bluetoothscell*)[tableView dequeueReusableCellWithIdentifier:@"bluetoothcell"];
    
    if (cell == nil) {
        cell= [[[NSBundle  mainBundle]  loadNibNamed:@"bluetoothscell" owner:self options:nil]  lastObject];
    }
    
    UILabel *bluetoothName=(UILabel*)[cell viewWithTag:1000];
    
    CBPeripheral *cp=(CBPeripheral*)self.deviceList[indexPath.row];
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
    CBPeripheral *device=(CBPeripheral*)self.deviceList[indexPath.row];
    if(device.state==CBPeripheralStateConnected)
    {
        [centralManager cancelPeripheralConnection:device];
    }
    else
    {
        [centralManager stopScan];
        NSLog(@"stop scan");
        peripheral = device;
        [centralManager connectPeripheral:device options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : @YES}];
        
    }
    
    [self.deviceListTableView reloadData];
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



#pragma  mark -- CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString * state = nil;
    switch ([central state])
    {
        case CBCentralManagerStateUnsupported:
            state = @"The platform/hardware doesn't support Bluetooth Low Energy.";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"Bluetooth is currently powered off.";
            break;
        case CBCentralManagerStatePoweredOn:
            state = @"work";
            //启动设备扫描
            [centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
        case CBCentralManagerStateUnknown:
        default:
            ;
    }
    NSLog(@"Central manager state: %@", state);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral)
    {
        NSLog(@"foundDevice. name[%s],RSSI[%d]\n",peripheral.name.UTF8String,peripheral.RSSI.intValue);
        //if ( [peripheral.name isEqualToString:@"T9 BT Printer"] )
        {
            //self.peripheral = peripheral;
            //发现设备后即可连接该设备 调用完该方法后会调用代理CBCentralManagerDelegate的- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral表示连接上了设别
            //如果不能连接会调用 - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
            //[centralManager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : YES}];
            if(peripheral.name==NULL) return;
            if(peripheral.name.length==0) return;
            if (![self.deviceList containsObject:peripheral])
               [self.deviceList  addObject:peripheral];
            
            //NSLog(@"foundDevice. name[%s],RSSI[%d]\n",peripheral.name.UTF8String,peripheral.RSSI.intValue);
            [self.deviceListTableView reloadData];
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"has connected");
    //[mutableData setLength:0];
    peripheral.delegate = self;
    //此时设备已经连接上了  你要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    [self.deviceListTableView reloadData];
    
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Peripheral Disconnected");
    //self.peripheral = nil;
    [self.deviceListTableView reloadData];
    [self alertMessage:@"连接断开！"];
    
}




- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    //此时连接发生错误
    NSLog(@"connected periphheral failed");
    [self alertMessage:@"连接失败！"];
}


#pragma mark -- CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:error
{
    if (error==nil)
    {
        NSLog(@"Write edata failed!");
        return;
    }
    NSLog(@"Write edata success!");
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error==nil)
    {
        //在这个方法中我们要查找到我们需要的服务  然后调用discoverCharacteristics方法查找我们需要的特性
        //该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
        //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        for (CBService *service in peripheral.services)
        {
            if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]])
            {
                //[peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
                [peripheral discoverCharacteristics:nil forService:service];
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error==nil) {
        //在这个方法中我们要找到我们所需的服务的特性 然后调用setNotifyValue方法告知我们要监测这个服务特性的状态变化
        //当setNotifyValue方法调用后调用代理CBPeripheralDelegate的- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        for (CBCharacteristic *characteristic in service.characteristics)
        {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kWriteCharacteristicUUID]])
            {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                activeWriteCharacteristic = characteristic;
            }
            else
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kReadCharacteristicUUID]])
                {
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                    activeReadCharacteristic = characteristic;
                }
            [self.deviceListTableView reloadData];
            //[scanConnectActivityInd stopAnimating];
            activeDevice = peripheral;
            
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"enter didUpdateNotificationStateForCharacteristic!");
    if (error==nil)
    {
        //调用下面的方法后 会调用到代理的- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        [peripheral readValueForCharacteristic:characteristic];
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"enter didUpdateValueForCharacteristic!");
    NSData *data = characteristic.value;
    NSLog(@"read data=%@!",data);
    
}


@end
