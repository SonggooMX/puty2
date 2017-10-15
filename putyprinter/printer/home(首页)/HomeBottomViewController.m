//
//  HomeBottomViewController.m
//  printer
//
//  Created by songgoo on 2017/7/12.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "HomeBottomViewController.h"
#import "NewLabelViewController.h"
#import "PrintViewController.h"
#import "masterplateViewController.h"
#import "historyViewController.h"
#import "connetController.h"
#import "setViewController.h"
#import "TagTemplateController.h"

LabelInfo *TEMP_LABEL_INFO;
drawArea *TEMP_DRAW_AREA;
UIImage *TEMP_BITMAP;
NSString *TEMP_LABEL_MESSAGE;

@interface HomeBottomViewController() <CBCentralManagerDelegate,CBPeripheralDelegate>


@end

@implementation HomeBottomViewController {
    NewLabelViewController *_newLabelView;
    PrintViewController *_printView;
    masterplateViewController *_masterplateView;
    historyViewController *_historyView;
    connetController *_connectView;
    setViewController *_setView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TEMP_LABEL_MESSAGE=@"X:00mm  Y:00mm  宽:100mm  高:50mm";
    TEMP_BITMAP=nil;
    TEMP_DRAW_AREA=nil;
    TEMP_LABEL_INFO=nil;
    
    
    //初始化后会调用代理CBCentralManagerDelegate 的 - (void)centralManagerDidUpdateState:(CBCentralManager *)central
    self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}


-(void) viewDidAppear:(BOOL)animated
{
    
}


-(void) viewWillAppear:(BOOL)animated
{
    if(self.activeDevice==nil)
    {
        self.currentSelectPrinter.text=@"未连接打印机";
        return;
    }
    NSLog(@"当前连接设备：%@",self.activeDevice.name);
    self.currentSelectPrinter.text=self.activeDevice.name;
}


- (IBAction)btnNewLabel:(UIButton *)sender {
    
    switch (sender.tag) {
        case 11:
            _newLabelView = [[NewLabelViewController alloc] init];
            _newLabelView.parent=self;
            
            [self.navigationController pushViewController:_newLabelView animated:YES];
            break;
            
        case 12://打印
            _printView = [[PrintViewController alloc] init];
            _printView.parent=self;
            
            [self.navigationController pushViewController:_printView animated:YES];
            break;
            
        case 13:
            [self openCloundTempeletes];
            //_masterplateView = [[masterplateViewController alloc] init];
            //[self.navigationController pushViewController:_masterplateView animated:YES];
            break;
            
        case 14:
            _historyView = [[historyViewController alloc] init];
            [self.navigationController pushViewController:_historyView animated:YES];
            break;
            
        case 15:
            _connectView = [[connetController alloc] init];
            _connectView.parent=self;
            
            [self.navigationController pushViewController:_connectView animated:YES];
            break;
            
        case 16:
            _setView = [[setViewController alloc] init];
            [self.navigationController pushViewController:_setView animated:YES];
            break;
            
        default:
            break;
    }
    
}

//打开云端模板
- (void) openCloundTempeletes
{
    TagTemplateController *vc = [TagTemplateController new];
    [self.navigationController pushViewController:vc animated:YES];
}

// 点击选择标签 进入历史记录
- (IBAction)clickTheLabel:(UIButton *)sender {
    
    _historyView = [[historyViewController alloc] init];
    [self.navigationController pushViewController:_historyView animated:YES];
    
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
            //[centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
        case CBCentralManagerStateUnknown:
        default:
            ;
    }
    NSLog(@"Central manager state: %@", state);
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Peripheral Disconnected");
    //self.peripheral = nil;
    //[self alertMessage:@"连接断开！"];
    self.activeDevice=nil;
    self.activeWriteCharacteristic=nil;
    self.activeReadCharacteristic=nil;
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
            
            if(self.deviceListTableView==nil) return;
            
            if (![self.deviceList containsObject:peripheral])
                [self.deviceList  addObject:peripheral];
            
            //NSLog(@"foundDevice. name[%s],RSSI[%d]\n",peripheral.name.UTF8String,peripheral.RSSI.intValue);
            [self.deviceListTableView reloadData];
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
                self.activeWriteCharacteristic = characteristic;
            }
            else
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kReadCharacteristicUUID]])
                {
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                    self.activeReadCharacteristic = characteristic;
                }
            //[scanConnectActivityInd stopAnimating];
            if(self.deviceListTableView==nil) return;
            [self.deviceListTableView reloadData];
            
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"%@ has connected",peripheral.name);
    //[mutableData setLength:0];
    peripheral.delegate = self;
    //此时设备已经连接上了  你要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    
    self.activeDevice = peripheral;
    self.currentSelectPrinter.text=self.activeDevice.name;
    
    if(self.deviceListTableView==nil) return;
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

@end
